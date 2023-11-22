//
//  ServiceError.swift
//  
//
//  Created by Ntobeko SIkithi on 2023/11/22.
//

import Foundation
public enum ServiceError: Error {
    case invalidEndPoint
    case requestFailed
    case jsonParsingFailure
    case invalidParameters
    case invalidResponse

    var localizedDescription: String {
        switch self {
        case .invalidEndPoint: return "invalid end point"
        case .requestFailed: return "Request Failed"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .invalidParameters: return "Error converting model to HTTP Parameters"
        case .invalidResponse: return "invalid response"
        }
    }
}
