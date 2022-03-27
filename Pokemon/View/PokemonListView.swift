//
//  ContentView.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 20/03/22.
//

import SwiftUI

struct PokemonListView: View {
    @ObservedObject var viewModel = PokemonListViewModel()
    @ObservedObject var monitor = InternetConexion()
    @State var noResults = true
    
    enum Constants {
        static let sizeNoDataImage: CGFloat = 50
        static let paddingTopNoDataImage: CGFloat = 150
        static let sizeFailConexionImage: CGFloat = 130
        static let paddingTopFailConexionImage: CGFloat = 30
        static let paddingTopFailLoadDataText: CGFloat = 10
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                if monitor.networkError == .failConexion {
                   failConexion
                } else if viewModel.error == .failLoadData {
                    failLoadData
                } else {
                    if viewModel.errorLoadData {
                        ProgressView()
                    }
                    listPokemons
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Pokemon List")
                        .font(.largeTitle.bold())
                }
            }
        }
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onAppear {
            let coloredAppearance = UINavigationBarAppearance()
            coloredAppearance.configureWithOpaqueBackground()
            coloredAppearance.backgroundColor = UIColor(.cellBackground)
            UINavigationBar.appearance().standardAppearance = coloredAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
            viewModel.fetchPokemons()
        }
    }
    
    private var listPokemons: some View {
        VStack(spacing: .zero){
            DividerCustom()
            ScrollView {
                if viewModel.searchPokemons.isEmpty && !viewModel.searchText.isEmpty {
                    
                    noDataView
                    
                } else {
                    ForEach(viewModel.classifications) { classification in
                        VStack(alignment: .leading, spacing: .zero) {
                            Text("\(classification)")
                                .font(.title3)
                                .padding(.bottom, 3)
                            DividerCustom()
                        }
                        .padding([.horizontal, .top], 20)
                        .padding(.bottom, 10)
                        
                        ForEach(viewModel.pokemonsGroupSection[classification] ?? [], id: \.idInt) { pokemon in
                            NavigationLink {
                                PokemonDetailView(viewModel: PokemonDetailViewModel(
                                    pokemon: pokemon, evolutions: viewModel.getEvolutions(to: pokemon) 
                                ))
                            } label: {
                                PokemonCell(pokemon: pokemon)
                                    .padding(.bottom, 10)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }
        
    }
    
    private var noDataView: some View {
        VStack {
            Image(systemName: "tray.fill")
                .resizable()
                .scaledToFit()
                .frame(width: Constants.sizeNoDataImage, height: Constants.sizeNoDataImage)
            Text("No Data")
        }
        .foregroundColor(Color.gray)
        .padding(.top, Constants.paddingTopNoDataImage)
        .alertNoDataLoadCustom(isPresented: $noResults, typeError: NetworkError.noResultsFound)
    }
    
    private var failConexion: some View {
        VStack {
            Image(systemName: "icloud.slash.fill")
                .resizable()
                .scaledToFit()
                .frame(width: Constants.sizeFailConexionImage, height: Constants.sizeFailConexionImage)
                .foregroundColor(Color.gray)
                .padding(.top, Constants.paddingTopFailConexionImage)
            Spacer()
        }
        .alertFailConexionCustom(isPresented: $monitor.isFailConexion, typeError: .failConexion, tryAgain: {})
    }
    
    private var failLoadData: some View {
        VStack {
            Text("\(NetworkError.failLoadData.messageErrorBody)")
                .foregroundColor(Color.red)
                .padding(.top, Constants.paddingTopFailLoadDataText)
            Spacer()
        }
        .alertNoDataLoadCustom(isPresented: $viewModel.errorLoadData, typeError: NetworkError.failLoadData)
    }
}
