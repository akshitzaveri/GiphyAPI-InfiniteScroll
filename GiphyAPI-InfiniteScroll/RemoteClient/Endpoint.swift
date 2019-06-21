//
//  Endpoint.swift
//  GiphyAPI-InfiniteScroll
//
//  Created by Akshit Zaveri on 21/06/19.
//  Copyright © 2019 Akshit Zaveri. All rights reserved.
//

import Foundation

enum EndpointRequestHTTPMethod: String {
    case GET
    case POST
    case DELETE
    case PUT
}

protocol EndpointResponse {
    var statusCode: String? { get }
    var errorMessage: String? { get }
}

extension EndpointResponse {
    
    var isSuccess: Bool {
        return (self.statusCode == "200")
    }
}

protocol Endpoint {
    
    typealias RequestParametersType = [String: Any]
    
    func getRequestParameters() -> RequestParametersType?
    
    var response: EndpointResponse? { get }
    var httpMethod: EndpointRequestHTTPMethod { get }
    var path: String { get }
}

// Assumption - Does not support POST method, for now.
extension Endpoint {
    
    // Assumption - Ideally we should have different base URL for production and development environments
    var base: String { return "api.giphy.com" }
    
    // Assumption - Ideally we should have different keys for production and development environments
    var apiKey: String { return "S6E6B58AkpGPnYkQ4IHAVgr0heeae5ju" }
    
    var format: String { return "json" }
    
    // Default value = GET
    var httpMethod: EndpointRequestHTTPMethod { return .GET }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path += path
        components.queryItems = getRequestParameters()?.map({ URLQueryItem(name: $0.key, value: (($0.value as? String) ?? String(describing: $0.value))) })
        return components
    }
    
    var urlRequest: URLRequest {
        let url = urlComponents.url!
        var req = URLRequest(url: url)
        req.timeoutInterval = 30
        req.httpMethod = httpMethod.rawValue
        return req
    }
}
