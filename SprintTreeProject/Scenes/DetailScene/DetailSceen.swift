//
//  DetailSceen.swift
//  SprintTreeProject
//
//  Created by Richard Essemiah on 12/09/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailSceen: View {
    @Environment(\.isPresented) var presentationMode
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    @State var showAlert: Bool = false
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    
    @State var cat: CatReponse? = nil
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    image
                    favoriteButton(text: "FAVORITE".localize())
                        .onTapGesture {
                            didTapOnFavorite()
                        }
                    favoriteButton(text: "VOTE".localize())
                        .onTapGesture {
                            didTapOnVote()
                        }
                }
            }
        }
        .showAlert(title: alertTitle, message: alertMessage, isPresented: $showAlert
        )
        
    }
    
    private func didTapOnFavorite() {
        guard let cat = cat, let id = cat.id else { return }
        viewModel.favoriteImage(image: id) { results in
            switch results {
            case .success:
                alertTitle = "SUCCESS".localize()
                alertMessage = "CAT_FAVORITED".localize()
                showAlert.toggle()
            case .failure(let error):
                alertTitle = "ERROR".localize()
                alertMessage = "API_ERROR".localize()
                showAlert.toggle()
            }
        }
    }
    
    private func didTapOnVote() {
        guard let cat = cat, let id = cat.id else { return }
        let info: [String: Any] = [
            "image_id": id,
            "sub_id": Constants.user_id,
            "value": 1
        ]
        
        viewModel.voteImage(voteRequest: info) { results in
            switch results {
            case .success:
                alertTitle = "SUCCESS".localize()
                alertMessage = "CAT_VOTED".localize()
                showAlert.toggle()
            case .failure(let error):
                alertTitle = "ERROR".localize()
                alertMessage = "API_ERROR".localize()
                showAlert.toggle()
            }
        }
    }
}

// MARK: - Views
private extension DetailSceen {
    var image: some View {
        ZStack {
            WebImage(url: URL(string: cat?.url ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Rectangle().foregroundColor(.gray)
                }
                .indicator(.activity) // Activity Indicator
                .transition(.fade(duration: 0.5)) // Fade Transition with duration
                .scaledToFit()
                .frame(height: 300)

        }
        .padding(.horizontal)
        .padding(.top)
    }
    
    func favoriteButton(text: String) -> some View {
        ZStack {
            Capsule(style: .circular)
            
            Text(text)
                .padding(.horizontal)
                .padding(.vertical)
                .font(.title)
                .foregroundStyle(.white)
        }
        .padding(.horizontal)
    }
}

#Preview {
    
    DetailSceen()
}
