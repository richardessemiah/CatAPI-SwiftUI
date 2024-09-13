//
//  HomeViewModel.swift
//  SprintTreeProject
//
//  Created by Richard Essemiah on 12/09/2024.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class HomeViewModel: ObservableObject {
    
    @Published var cats: [CatReponse] = []
    @Published var filterOptions: [String: Any] = [:]
    @Published var hasBreed = false
    @Published var orderedText = "RANDOM".localize()
    @Published var isLoading = true
  
    
    
    func favoriteImage(image: String, completion: @escaping (_ result: Result<Bool, Error>)->()) {
        let requestData: [String: Any] =
        [
            "image_id": image,
            "sub_id": Constants.user_id
        ]
        
        APIClient.makeRequest(HttpRouter.favoriteItem(data: requestData))
            .onSuccess {(response: ApiResponse)  in
                completion(.success(true))
            }
            .onFailure { error in
                completion(.failure(error))
            }
    }
    
    
    func voteImage(voteRequest: [String: Any], completion: @escaping (_ result: Result<VoteReponse, Error>)->()) {
        isLoading = true
        APIClient.makeRequest(HttpRouter.voteItem(data: voteRequest))
            .onSuccess { [weak self] (response: ApiResponse)  in
                guard let object = response.object as? [String: Any],
                      let voteResponse = VoteReponse(JSON: object) else { 
                          completion(.failure(NetworkError.other))
                          return
                      }
                self?.isLoading = false
                completion(.success(voteResponse))
            }
            .onFailure { error in
                completion(.failure(error))
            }
    }
   
    func fetchCats(completion: @escaping (_ result: Result<[CatReponse], Error>)->()) {
        filterOptions["limit"] = 25
        isLoading = true
        APIClient.makeRequest(HttpRouter.fetchCats(parameters: filterOptions))
            .onSuccess { [weak self] (response: ApiResponse)  in
                guard let data = response.object as? [[String: Any]] else { return }
                let cats: [CatReponse] = Constants.convertDictionaryToModels(dic: data)
                self?.cats = cats
                self?.isLoading = false
                completion(.success(cats))
                
            }
            .onFailure { error in
                completion(.failure(error))
            }
    }
    
}
