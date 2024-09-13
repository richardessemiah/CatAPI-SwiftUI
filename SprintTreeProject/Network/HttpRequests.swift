//
//  HttpRequests.swift
//  SprintTreeProject
//
//  Created by Richard Essemiah on 12/09/2024.
//

import Alamofire
import ObjectMapper

enum HttpRouter: URLRequestConvertible {
    case fetchCats(parameters: [String: Any])
    case getVotes
    case voteItem(data: [String: Any])
    case favoriteItem(data: [String: Any])
    case getFavorites
    
    private var method: HTTPMethod {
        switch self {
        case .fetchCats,
                .getVotes,
                .getFavorites:
            return .get
        case .favoriteItem, .voteItem:
            return .post
        }
    }
    
    private var path: String {
        switch self {
        case .fetchCats:
            return "images/search"
        case .getVotes, 
                .voteItem:
            return "votes"
        case .favoriteItem,
                .getFavorites:
            return "favourites"
        }
    }
    
    var jsonArrayParameters: [Int64]? {
        switch self {
        default:
            return nil
        }
    }
    
    var jsonParameters: [String: Any]? {
        switch self {
        case .favoriteItem(let data),
                .voteItem(let data):
            return data
        default:
            return nil
        }
    }
    
    var urlParameters: [String: Any]? {
        switch self {
        case .fetchCats(let requests) :
            return requests
        default:
            return nil
        }
    }
    
    var apiKey: String {
        return AppSecrets[.apiKey]
    }
    
    func asURLRequest() throws -> URLRequest {
        var url = URL(string: Constants.baseUrl)
        url = url?.appendingPathComponent(self.path)
        
        var urlRequest = URLRequest(url: url! as URL)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(AppSecrets[.apiKey], forHTTPHeaderField: "x-api-key")

        switch self {
        case .voteItem, 
                .favoriteItem:
            do {
                let jsonData: NSData = try JSONSerialization.data(withJSONObject: self.jsonParameters ?? Dictionary(), options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
                print("\nJSON request: \(NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)!)\n")
            }
            catch let error as NSError {
                print(error.localizedDescription)
            }
            
            return try JSONEncoding.default.encode(urlRequest, with: self.jsonParameters)
        default:
            return try URLEncoding.queryString.encode(urlRequest, with: self.urlParameters)
        }
    }
}
