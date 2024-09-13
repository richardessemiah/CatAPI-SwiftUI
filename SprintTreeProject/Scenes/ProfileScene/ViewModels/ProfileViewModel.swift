//
//  ProfileViewModel.swift
//  SprintTreeProject
//
//  Created by Richard Essemiah on 13/09/2024.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var favorites: [FavoritesResponse] = []
    @Published var votes: [VoteReponse] = []
    @Published var filterOptions: [String: Any] = [:]
    @Published var hasBreed = false
    @Published var orderedText = "RANDOM".localize()
    @Published var favoritesIsLoading = true
    @Published var votesIsLoading = true

    func getFavorites() async throws -> [FavoritesResponse] {
       favoritesIsLoading = true
       return try await withCheckedThrowingContinuation { continuation in
           APIClient.makeRequest(HttpRouter.getFavorites)
               .onSuccess { [weak self] (response)  in
                   guard let object = response.object as? [[String: Any]] else { return }
                   let favorites: [FavoritesResponse] = Constants.convertDictionaryToModels(dic: object)
                   self?.favoritesIsLoading = false
                   continuation.resume(with: .success(favorites))
               }
               .onFailure { error in
                   continuation.resume(with: .failure(error))
               }
       }
   }
   
    func getVotes() async throws -> [VoteReponse] {
       votesIsLoading = true
       return try await withCheckedThrowingContinuation { continuation in
           APIClient.makeRequest(HttpRouter.getVotes)
               .onSuccess { [weak self] (response)  in
                   guard let object = response.object as? [[String: Any]] else { return }
                   let votes: [VoteReponse] = Constants.convertDictionaryToModels(dic: object)
                   self?.votes = votes
                   self?.votesIsLoading = false
                   continuation.resume(with: .success(votes))
               }
               .onFailure { error in
                   continuation.resume(with: .failure(error))
               }
               
       }
   }
    
}
