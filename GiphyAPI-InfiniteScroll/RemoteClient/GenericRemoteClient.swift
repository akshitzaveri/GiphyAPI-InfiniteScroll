//
//  GenericRemoteClient.swift
//  GiphyAPI-InfiniteScroll
//
//  Created by Akshit Zaveri on 21/06/19.
//  Copyright © 2019 Akshit Zaveri. All rights reserved.
//

import Foundation

enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    case unknownError
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        case .unknownError: return "Unknown error occured. Please contact the administrator."
        }
    }
}


enum SuccessResult<T> {
    case result(T)
    
    var value: T {
        switch self {
        case .result(let object): return object
        }
    }
}

enum ErrorResult<U> where U: Error {
    case failure(U)
    
    var value: U {
        switch self {
        case .failure(let error): return error
        }
    }
}


protocol RemoteClient: class where ResultType: Decodable {
    
    associatedtype EndpointType
    associatedtype ResultType
    
    typealias SuccessClosure = (SuccessResult<ResultType>) -> Void
    typealias ErrorClosure = (ErrorResult<APIError>) -> Void
    
    var session: URLSession { get }
    func fetch(with request: URLRequest,
               successClosure: @escaping SuccessClosure,
               errorClosure: @escaping ErrorClosure)
    
}

extension RemoteClient {
    
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    func decodingTask(with request: URLRequest,
                      decodingType: ResultType.Type,
                      completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        session.configuration.timeoutIntervalForRequest = 30
        session.configuration.timeoutIntervalForResource = 30
        session.configuration.waitsForConnectivity = true
        
        let task = session.dataTask(with: request) { rawData, response, error in
            print("=================== API Response START ==================")
            guard let httpResponse = response as? HTTPURLResponse else {
                self.printResponseError(rawData, request: request, error: error)
                DispatchQueue.main.async { completion(nil, .requestFailed) }
                return
            }
            print("Calling url method: \(String(describing: request.httpMethod)), url: \(String(describing: request.url?.absoluteString))")
            guard httpResponse.statusCode == 200 else {
                DispatchQueue.main.async { completion(nil, .responseUnsuccessful) }
                self.printResponseError(rawData, request: request, error: error)
                return
            }
            
            guard let data = rawData else {
                self.printResponseError(rawData, request: request, error: error)
                DispatchQueue.main.async { completion(nil, .invalidData) }
                return
            }
            do {
                let decoder = JSONDecoder()
                let genericModel = try decoder.decode(decodingType, from: data)
                completion(genericModel, nil)
            } catch {
                print("JSON conversion error \(error)")
                self.printResponseError(data, request: request, error: error)
                DispatchQueue.main.async { completion(nil, .jsonConversionFailure) }
            }
            print("=================== API Response END ==================")
        }
        return task
    }
    
    func fetch(with request: URLRequest,
               successClosure: @escaping SuccessClosure,
               errorClosure: @escaping ErrorClosure) {
        
        DispatchQueue.global(qos: .background).async {
            if let postData = request.httpBody, let string = String(data: postData, encoding: .utf8) {
                print("API Request body START======================================")
                print(string)
                print("API Request body END======================================")
            }
        }
        
        let task = decodingTask(with: request, decodingType: ResultType.self) { [unowned self] (json, error) in
            DispatchQueue.main.async {
                guard let json = json else {
                    self.printJSONConversionError(nil, request: request)
                    if let error = error { errorClosure(.failure(error)) }
                    else { errorClosure(.failure(.invalidData)) }
                    return
                }
                
                if let value = self.decode(json) { successClosure(.result(value)) }
                else {
                    self.printJSONConversionError(json, request: request)
                    errorClosure(.failure(.jsonParsingFailure))
                }
            }
        }
        task.resume()
    }
    
    private func printJSONConversionError(_ json: Decodable?, request: URLRequest) {
        DispatchQueue.global(qos: .default).async {
            print("=---------------- ERROR ------------------")
            print("Called API: \(request)")
            print("Received response \(json ?? "N.A")")
            print("=---------------- ERROR END ------------------")
        }
    }
    
    private func printResponseError(_ data: Data?, request: URLRequest, error: Error?) {
        DispatchQueue.global(qos: .default).async {
            guard let data = data else { return }
            let string = String(data: data, encoding: String.Encoding.utf8)
            print("=---------------- ERROR ------------------")
            print("Called API: \(request)")
            print("Received response \(string ?? "N.A")")
            print("Error: \(String(describing:error?.localizedDescription))")
            print("=---------------- ERROR END ------------------")
        }
    }
    
    private func decode(_ json: Decodable) -> ResultType? {
        guard let result = json as? ResultType else { return nil }
        return result
    }
}
