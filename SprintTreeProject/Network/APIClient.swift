//
//  APIClient.swift
//  SprintTreeProject
//
//  Created by Richard Essemiah on 12/09/2024.
//

import Foundation
import BrightFutures
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

enum NetworkError: Error {
    case unauthorized
    case other
}

struct ApiResponse {
    var statusCode: Int?
    var object: Any?
}

protocol API {
    static func makeRequest(_ urlRequest: URLRequestConvertible) -> Future<ApiResponse, NetworkError>
}

class APIClient: API {
    static let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        configuration.waitsForConnectivity = true
        return Session(configuration: configuration)
    }()
    
    static let networkQueue = DispatchQueue(label: "networking-queue", attributes: .concurrent)
    
    static func makeRequest(_ urlRequest: URLRequestConvertible) -> Future<ApiResponse, NetworkError> {
        
        let successRange = 200..<399
        let promise = Promise<ApiResponse, NetworkError>()
        
        sessionManager.request(urlRequest)
            .cURLDescription(calling: { desc in
                print(desc)
            })
            .validate(statusCode: successRange)
            .responseData(queue: networkQueue, completionHandler: { (response: AFDataResponse<Data>) in
                
                switch response.result {
                case .success:
                    guard let statusCode = response.response?.statusCode else { return }
                    var objectData: Any?
                    if let data = response.data, !data.isEmpty {
                        objectData = try? JSONSerialization.jsonObject(with: data) 
                    }
                    let fynchResponse = ApiResponse(statusCode: statusCode, object: objectData)
                    promise.success(fynchResponse)
                    
                case .failure
                    where response.response?.statusCode == 401:
                    promise.failure(.unauthorized)
                    
                case .failure(let error):
                    promise.failure(.other)
                }
        })
        
        return promise.future
    }
    
}
