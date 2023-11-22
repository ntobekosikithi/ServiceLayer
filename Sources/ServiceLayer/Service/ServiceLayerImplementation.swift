//
//  ServiceLayerImplementation.swift
//  
//
//  Created by Ntobeko SIkithi on 2023/11/22.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    // Add more methods as needed
}

public class ServiceLayerImplementation: ServiceLayer {
    
    public func makeRequest<T>(url: String,
                               method: HTTPMethod = .get,
                               headers: [String : String]? = nil,
                               parameters: [String : Any]? = nil,
                               success: @escaping (T) -> Void,
                               error: @escaping (ServiceError) -> Void) where T : Decodable, T : Encodable {
        
        guard let url = URL(string: url) else {
            error(.invalidEndPoint)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if let parameters = parameters {
            if method == .get {
                var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
                urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
                request.url = urlComponents?.url
            } else if method == .post {
                request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, serviceError in
            if let _ = serviceError {
                error(.requestFailed)
                return
            }

            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let model = try jsonDecoder.decode(T.self, from: data)
                    success(model)
                } catch _ {
                    error(.jsonParsingFailure)
                }
            }else{
                error(.invalidResponse)
            }
        }

        task.resume()
    }

}
