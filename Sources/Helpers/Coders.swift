//
//  Coders.swift
//  NetworkClient
//
//  Created by Hardik Modha on 21/11/26.
//

import Foundation


public typealias JSONType = (any Encodable & Sendable)
public typealias HTTPHeaders = [String: String]
public typealias Progress = @Sendable (Double) -> Void
public typealias ResponseCodable = Codable & Sendable

public enum Coders {
    public static let jsonDecoder = JSONDecoder()
    public static let jsonEncoder = JSONEncoder()
}





public enum HTTPMethod: CustomStringConvertible, Sendable {
    case get
    case post(JSONType)
    case put(JSONType)
    case delete
    
    public var parameter: (any Encodable & Sendable)? {
        switch self {
        case .get, .delete:
            return nil
        case .post(let parameter), .put(let parameter):
            return parameter
        }
    }
    
    public var description: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .delete:
            return "DELETE"
        }
    }
}

public enum ServerStatus: Int, Error, Sendable {
    case success = 200
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case internalServerError = 500
    case serviceUnavailable = 503
    
    public var errorCode: Int {
        return self.rawValue
    }
    
    public var localizedDescription: String {
        switch self {
        case .success:
            return Constants.ErrorMessage.successMessage
        case .badRequest:
            return Constants.ErrorMessage.badRequestMessage
        case .unauthorized:
            return Constants.ErrorMessage.invalidTokenMessage
        case .forbidden:
            return Constants.ErrorMessage.forbiddenMessage
        case .notFound:
            return Constants.ErrorMessage.notFoundMessage
        case .internalServerError:
            return Constants.ErrorMessage.internalServerError
        case .serviceUnavailable:
            return Constants.ErrorMessage.serviceUnavailableMessage
        }
    }
}

public enum NetworkError: Error {
    case invalidURL(String)
    case invalidResponse
    case canNotParse(String)
    
    public var localizedDescription: String {
        switch self {
        case .invalidURL(let string):
            return string
        case .invalidResponse:
            return "invalid response"
        case .canNotParse(let message):
            return message
        }
    }
}
