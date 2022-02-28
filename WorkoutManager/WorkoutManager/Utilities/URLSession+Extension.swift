//
//  ApiManager.swift
//  RestApiHelpers
//
//  Created by Lloyd Hendricks on 2022/02/09.
//

import Foundation

extension URLSession {
    
    // Known errors we want to listen for
    enum CustomError: Error {
        case invalidResponse
        case invalidRequest
        case invalidBody
        case invalidUrl
        case invalidData
    }
    
    // An enum for us to work with and determin the method we want
    enum HttpMethod: String {
        case get = "GET"
        case patch = "PATCH"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    // Builds the request to handle different types of scenarios
    private func buildRequest(url: URL, httpMethod: HttpMethod?, bodyParamaters: [String:Any]?, serilizedBody: Data?) throws -> URLRequest {
        
        // Creates a request that we can work with and parse information
        var request = URLRequest(url:url)
        
        // Defaults the response to a GET method
        request.httpMethod = HttpMethod.get.rawValue
        
        // Defaults a header value
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(Constants.apiKey, forHTTPHeaderField: "Authorization")
        // Checks if we determined a method else default to a get method
        if let serviceMethod = httpMethod {
            
            // Set the method to the raw value of the enum
            request.httpMethod = serviceMethod.rawValue
            
        }
        
        // Looks if we are trying to send body paramaters
        if let safeParamaters = bodyParamaters {
            
            // Try serilize those parameters
            if let body = try? JSONSerialization.data(withJSONObject: safeParamaters, options: []) {
                
                // Add the serilized body data to the request
                request.httpBody = body
                
                print(body.description)
            } else {
                
                // Serilization failure
                throw CustomError.invalidBody
                
            }
            
        } else if let body = serilizedBody {
            
            // Attached a body that has already been serilized
            request.httpBody = body
            
        }
        
        return request
    }
    
    // Custom function that we want to now use
    func makeRequest<Generic: Codable>(url: URL?,
                                       method: HttpMethod? = nil,
                                       returnModel: Generic.Type,
                                       paramters: [String: Any]? = nil,
                                       knownBody: Data? = nil,
                                       completion: @escaping (Result<Generic, Error>) -> Void) {
        
        // Ensuring the URL is safe and we can use it
        guard let endpointUrl = url else {
            completion(.failure(CustomError.invalidUrl))
            return
        }
        
        do {
        
            // Create the request
            let urlRequest = try buildRequest(url: endpointUrl, httpMethod: method, bodyParamaters: paramters, serilizedBody: knownBody)
            
            // This task processes the url & simple cancelable asynchronous interface to receiving data
            let apiTask = self.dataTask(with: urlRequest) { data, _, error in
                
                // Ensures that the data recieved is safe to use
                guard let safeData = data else {
                    
                    // Confirms if there is an error else custom error we created
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(CustomError.invalidData))
                    }
                    return
                }
                
                do {
                    // Runs JSON deserialization from the safe data into the generic model we pass in
                    let result = try JSONDecoder().decode(returnModel, from: safeData)
                    
                    // Tells the code we are complete and return what we deserialization
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
                
            }
            // Resume is execute request in this instant
            apiTask.resume()
            
        } catch CustomError.invalidBody {
            
            // Create a known error for multiple error types
            completion(.failure(CustomError.invalidRequest))
            
        } catch {
            
            // Return unhandled error
            completion(.failure(error))
            
        }
        
    }
}
