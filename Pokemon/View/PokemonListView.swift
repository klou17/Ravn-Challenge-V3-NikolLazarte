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
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.errorLoadData {
                    ProgressView()
                }
                VStack(spacing: .zero) {
                    DividerCustom()
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
        .alertCustom(isPresented: $monitor.isFailConexion, typeError: viewModel.error ?? .failConexion)
        .imageErrorCustom(typeError: viewModel.error ?? NetworkError.failLoadData)
        .onAppear {
            let coloredAppearance = UINavigationBarAppearance()
            coloredAppearance.configureWithOpaqueBackground()
            coloredAppearance.backgroundColor = UIColor(.cellBackground)
            UINavigationBar.appearance().standardAppearance = coloredAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
            viewModel.subscriptions()
        }
    }
    
    private var listPokemons: some View {
        ScrollView {
            if viewModel.searchResults.isEmpty && !viewModel.searchText.isEmpty {
                
                noDataView
                
            } else {
                ForEach(viewModel.classifications) { classification in
                    VStack(alignment: .leading, spacing: .zero) {
                        Text("\(classification)")
                            .font(.title3)
                            .padding(.bottom, 3)
                        DividerCustom()
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    .padding(.horizontal, 20)
                    
                    ForEach(viewModel.pokemonsGroupSection[classification] ?? [], id: \.idInt) { pokemon in
                        NavigationLink {
                            PokemonDetailView(viewModel: PokemonDetailViewModel(
                                pokemon: pokemon
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
    
    private var noDataView: some View {
        VStack {
            Image(systemName: "tray.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            Text("No Data")
        }
        .foregroundColor(Color.gray)
        .padding(.top, 150)
        .alert(isPresented: $noResults) {
            Alert(
                title: Text("\(NetworkError.noResultsFound.messageErrorTitle)"),
                message: Text("\(NetworkError.noResultsFound.messageErrorBody)"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
