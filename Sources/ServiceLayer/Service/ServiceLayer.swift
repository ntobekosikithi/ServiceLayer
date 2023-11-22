//
//  ServiceLayer.swift
//
//
//  Created by Ntobeko SIkithi on 2023/11/22.
//
public protocol ServiceLayer {
    func makeRequest<T: Codable>(url: String,
                                 method: HTTPMethod,
                                 headers: [String: String]?,
                                 parameters: [String: Any]?,
                                 success: @escaping (T) -> Void,
                                 error: @escaping (ServiceError) -> Void)
}
