//
//  URLSessionRequest.swift
//  Test
//
//  Created by Minh on 23/11/2022.
//

import Foundation


public typealias JSON = [String: Any]
public typealias HTTPHeaders = [String: String]

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class URLSessionRequest{
    static let shared = URLSessionRequest()
    
    let sessionManager = URLSession(configuration: .default)
    
    func fetchData<T:Decodable>(_ url: String,
                                method: RequestMethod,
                                headers: HTTPHeaders? = nil,
                                body: JSON? = nil,
                                completion: @escaping (Result<T, Error>) -> Void) {
        let url = URL(string: url)!
        var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method.rawValue
        
        if let headers = headers {
            urlRequest.allHTTPHeaderFields = headers
//            urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "application/json")
        }
        
        if let body = body {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        sessionManager.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error { completion(.failure(error))}
            if let data = data {
                if let str = String(data: data, encoding: .utf8) {
                    print(str)
                }
                do {
                    let toDos = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(toDos))
                } catch let decoderError {
                    completion(.failure(decoderError))
                }
            }
        }.resume()
    }
}
