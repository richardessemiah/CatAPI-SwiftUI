//
//  HomeView.swift
//  SprintTreeProject
//
//  Created by Richard Essemiah on 12/09/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    @State var detailPresented: Bool = false
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    @State var showAlert: Bool = false
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 5, alignment: nil),
        GridItem(.flexible(), spacing: 5, alignment: nil),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack(alignment: .center, spacing: 10) {
                        Text("FILTER".localize())
                            .font(.headline)
                        Spacer()
                        filterButton("HAS_BREED")
                            .onTapGesture {
                                hasBreedTapped()
                            }
                        menuItem
                    }
                    
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.cats, id: \.self) { cat in
                            WebImage(url: URL(string: cat.url ?? ""))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .sheet(isPresented: $detailPresented, content: {
                                    DetailSceen(cat: cat)
                                    
                                })
                                .onTapGesture {
                                    detailPresented.toggle()
                                }
                        }
                    }
                    if viewModel.isLoading { ProgressView() }
                    
                }
            }
            .padding()
            .onAppear(perform: {
                getData()
            })
            .showAlert(title: alertTitle, message: alertMessage, isPresented: $showAlert
            )
            .navigationTitle("HOME".localize())
        }
    }
    
    private func hasBreedTapped() {
        viewModel.cats = []
        viewModel.hasBreed.toggle()
        viewModel.filterOptions["has_breed"] = viewModel.hasBreed
        getData()
    }
    
    private func orderByTapped(item: String) {
        viewModel.cats = []
        viewModel.filterOptions["order"] = item
        getData()
    }
    
    func getData() {
        viewModel.fetchCats() { results in
            switch results {
            case .success:
                break
            case .failure(let error):
                alertTitle = "ERROR".localize()
                alertMessage = "API_ERROR".localize()
                showAlert.toggle()
            }
        }
    }
}

// MARK: - Views
private extension HomeView {
    var menuItem: some View {
        Menu("ORDER_BY".localize() + " \(viewModel.orderedText)") {
            Button("RANDOM".localize()) {
                viewModel.orderedText = "RANDOM".localize()
                orderByTapped(item: "RANDOM".localize())
            }
            Button("DESC".localize()) {
                viewModel.orderedText = "DESC".localize()
                orderByTapped(item: "DESC".localize())
            }
            Button("ASC".localize()) {
                viewModel.orderedText = "ASC".localize()
                orderByTapped(item: "ASC".localize())
            }
        }
        .padding(.init(top: 4, leading: 10, bottom: 4, trailing: 10))
        .background(Color.gray)
        .clipShape(Capsule(style: .circular))
        .frame(height: 40)
        .foregroundStyle(Color.primary)
    }
    
    func filterButton(_ text: String) -> some View {
        HStack {
            Text(text.localize())
                .minimumScaleFactor(0.5)
                .foregroundStyle(.primary)
            
            if viewModel.hasBreed { Image(systemName: "checkmark.circle") }
        }
        .padding(.init(top: 4, leading: 10, bottom: 4, trailing: 10))
        .background(.gray)
        .clipShape(Capsule(style: .circular))
        .frame(height: 40)
    }
}

#Preview {
    HomeView()
}
