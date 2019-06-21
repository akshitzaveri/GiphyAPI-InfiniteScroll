//
//  GiphyNetworkManager.swift
//  GiphyAPI-InfiniteScroll
//
//  Created by Akshit Zaveri on 21/06/19.
//  Copyright © 2019 Akshit Zaveri. All rights reserved.
//

import Foundation

protocol NetworkSession {
    func loadData(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func loadData(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: url) { (data, _, error) in
            completionHandler(data, error)
        }
        task.resume()
    }
}

struct GiphyNetworkURLBuilder {
    enum Endpoint: String {
        case search = "/v1/gifs/search"
    }
    
    private let baseURL: String
    private let apiKey: String
    
    // dependency injection
    init(baseURL: String = "api.giphy.com", apiKey: String = "S6E6B58AkpGPnYkQ4IHAVgr0heeae5ju") {
        self.baseURL = baseURL
        self.apiKey = apiKey
    }
    
    func build(for type: Endpoint, with parameters: [String: Any]? = nil) -> URL? {
        guard var components = URLComponents(string: baseURL) else {
            print("Failed to create components for \(type)")
            return nil
        }
        components.path += type.rawValue
        components.queryItems = parameters?.map({ URLQueryItem(name: $0.key, value: ($0.value as? String) ?? String(describing: $0.value)) })
        components.queryItems?.append(URLQueryItem(name: "api_key", value: apiKey))
        return components.url
    }
}

final class GiphyNetworkManager {
    private let session: NetworkSession
    
    init(with session: NetworkSession = URLSession.shared) { self.session = session }
    
    func search(_ string: String, completion: @escaping ((SearchAPIResult?, Error?) -> Void)) {
        guard let url = GiphyNetworkURLBuilder().build(for: .search) else { return }
        session.loadData(from: url) { (data, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            do {
                let result = try JSONDecoder().decode(SearchAPIResult.self, from: data)
                completion(result, nil)
            } catch {
                print("Error in API: \(error)")
                completion(nil, error)
            }
        }
    }
}

struct SearchAPIResult: Decodable {
    struct Pagination: Decodable {
        var total_count: Int? // Assumption - The total count is less than 2^64 = 1.844674407E19
        var count: Int?
        var offset: Int?
    }
    
    struct Meta: Decodable {
        var status: Int?
        var msg: String?
    }
    
    var data: [GIFImage]?
    var pagination: Pagination?
    var meta: Meta?
    
    var statusCode: String?
    var errorMessage: String?
}
