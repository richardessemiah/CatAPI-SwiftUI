//
//  ProfileView.swift
//  SprintTreeProject
//
//  Created by Richard Essemiah on 12/09/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    List {
                        Section(
                            header:
                                HStack {
                                    Text("FAVORITES".localize())
                                    Image(systemName: "star")
                                }
                                .font(.headline)
                                .foregroundColor(.orange)
                        ) {
                            ForEach(viewModel.favorites) { favorite in
                                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                if let image = favorite.image, let url = image.url {
                                    WebImage(url: URL(string: url))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                       
                                } else {
                                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                        .foregroundStyle(Color.secondary)
                                }
                            }
                        }
                        
                        Section(
                            header:
                                HStack {
                                    Text("VOTES".localize())
                                    Image(systemName: "hand.thumbsup")
                                }
                                .font(.headline)
                                .foregroundColor(.orange)
                        ) {
                            ForEach(viewModel.votes) { votes in
                                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                if let image = votes.image, let url = image.url {
                                    WebImage(url: URL(string: url))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                       
                                } else {
                                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                        .foregroundStyle(Color.secondary)
                                }
                            }
                        }
                    }
                    
                }
            }
            .navigationTitle("PROFILE".localize())
            .navigationBarItems(
                
                trailing:
                    HStack {
                        Text("UPLOAD_IMAGE".localize())
                            .bold()
                        Image(systemName: "chevron.right.square")
                    }
            )
        }
        .onAppear(perform: {
            fetchVotes()
            fetchFavorites()
        })
    }
    
    private func fetchFavorites() {
        Task {
            viewModel.favorites = try await viewModel.getFavorites()
        }
    }
    
    private func fetchVotes() {
        Task {
            viewModel.votes = try await viewModel.getVotes()
        }
    }
    
}

#Preview {
    ProfileView()
}
