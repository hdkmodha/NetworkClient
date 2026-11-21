//
//  Protocols.swift
//  WebServiceManager
//
//  Created by Hardik Modha on 26/08/26.
//

import Foundation



public protocol RequestInterceptor {
    func adapt(_ urlRequest: inout URLRequest)
    func retry(_ request: inout URLRequest, dueTo error: Error, retryCount: Int) async -> Bool
}

public protocol ResposeInterceptor {
    func inrercept(response: HTTPURLResponse)
}
