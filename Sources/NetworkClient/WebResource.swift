//
//  WebResource.swift
//
//
//  Created by Hardik Modha on 30/11/23.
//

import Foundation
import Helpers

public struct WebResource<Value: Codable> {
    
    let request: URLRequest
    let networkClient: NetworkClient
    
    public init(request: URLRequest, networkClient: NetworkClient) {
        self.request = request
        self.networkClient = networkClient
    }
    
    public func request() async throws -> Value  {
        return try await WebServiceManager.shared.fetch(resource: self)
    }
}
