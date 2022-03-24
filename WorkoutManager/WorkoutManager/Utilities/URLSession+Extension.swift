//
//  ApiManager.swift
//  RestApiHelpers
//
//  Created by Lloyd Hendricks on 2022/02/09.
//

import Foundation

extension URLSession {

    enum CustomError: Error {
        case invalidResponse
        case invalidRequest
        case invalidBody
        case invalidUrl
        case invalidData
    }

    enum HttpMethod: String {
        case get = "GET"
        case patch = "PATCH"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }

    private func buildRequest(url: URL, httpMethod: HttpMethod?, bodyParamaters: [String:Any]?, serilizedBody: Data?) throws -> URLRequest {
    
        var request = URLRequest(url:url)

        request.httpMethod = HttpMethod.get.rawValue

        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(Constants.apiKey, forHTTPHeaderField: "Authorization")

        if let serviceMethod = httpMethod {

            request.httpMethod = serviceMethod.rawValue
            
        }

        if let safeParamaters = bodyParamaters {

            if let body = try? JSONSerialization.data(withJSONObject: safeParamaters, options: []) {

                request.httpBody = body
                
                print(body.description)
            } else {

                throw CustomError.invalidBody
                
            }
            
        } else if let body = serilizedBody {

            request.httpBody = body
            
        }
        
        return request
    }

    func makeRequest<Generic: Codable>(url: URL?,
                                       method: HttpMethod? = nil,
                                       returnModel: Generic.Type,
                                       paramters: [String: Any]? = nil,
                                       knownBody: Data? = nil,
                                       completion: @escaping (Result<Generic, Error>) -> Void) {

        guard let endpointUrl = url else {
            completion(.failure(CustomError.invalidUrl))
            return
        }
        
        do {
        
            let urlRequest = try buildRequest(url: endpointUrl, httpMethod: method, bodyParamaters: paramters, serilizedBody: knownBody)

            let apiTask = self.dataTask(with: urlRequest) { data, _, error in

                guard let safeData = data else {

                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(CustomError.invalidData))
                    }
                    return
                }
                
                do {
         
                    let result = try JSONDecoder().decode(returnModel, from: safeData)

                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
                
            }
        
            apiTask.resume()
            
        } catch CustomError.invalidBody {
            completion(.failure(CustomError.invalidRequest))
            
        } catch {
            completion(.failure(error))
            
        }
    }
}
