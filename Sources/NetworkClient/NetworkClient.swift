//
//  NetworkClient.swift
//  NetworkClient
//
//  Created by Hardik Modha on 15/11/26.
//

import Foundation
import Helpers
import Protocols



public final class NetworkClient {
    
    var requestInterceptors: [RequestInterceptor]
    var responseInterceptors: [ResposeInterceptor]
    
    public init(
        requestInterceptors: [RequestInterceptor] = [],
        responseInterceptors: [ResposeInterceptor] = []
    ) {
        self.requestInterceptors = requestInterceptors
        self.responseInterceptors = responseInterceptors
    }
    
    
    public func get<T: Codable>(withURLPath path: APIService) async throws -> T {
        
        
        let request = try await self.makeRequest(path: path)
        
        let webResource = WebResource<T>(request: request, networkClient: self)
        return try await webResource.request()
    }
    
    public func post<T: Codable>(withURLPath path: APIService, parameters: JSONType) async throws -> T {
        let request = try await self.makeRequest(path: path, method: .post(parameters))
        let webResource = WebResource<T>(request: request, networkClient: self)
        return try await webResource.request()
    }
    
    public func put<T: Codable>(withURLPath path: APIService, parameters: JSONType) async throws -> T {
        let request = try await self.makeRequest(path: path, method: .put(parameters))
        let webResource = WebResource<T>(request: request, networkClient: self)
        return try await webResource.request()
    }
    
    public func delete<T: Codable>(withURLPath path: APIService) async throws -> T {
        let request = try await self.makeRequest(path: path, method: .delete)
        let webResource = WebResource<T>(request: request, networkClient: self)
        return try await webResource.request()
    }
    
    private func makeRequest(path: APIService, method: HTTPMethod = .get) async throws -> URLRequest {
        guard let url = path.url else {
            throw NetworkError.invalidURL("invalid URL: \(path.url?.absoluteString ?? "")")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.description
        
        if let parameters = method.parameter {
            request.httpBody = parameters.toData
        }
        
        for interceptor in requestInterceptors {
            interceptor.adapt(&request)
        }
        
        return request
    }
    
}

