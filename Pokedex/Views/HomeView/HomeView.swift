//
//  HomeView.swift
//  Pokedex
//
//  Created by Jon Chang on 8/7/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    switch viewModel.status {
                    case .initial, .loading:
                        Text("Loading...")
                    case .error:
                        Text("ERROR.")
                    case .loaded:
                        listView
                    }
                }
            }
            .navigationTitle("Pokédex")
        }
        .onAppear {
            viewModel.getPokedexData()
        }
    }
    
    private var listView: some View {
        ForEach(viewModel.data, id: \.self) { pokemon in
            NavigationLink {
                PageView(pokemon: pokemon)
            } label: {
                PokemonCellView(pokemon: pokemon)
                    .foregroundColor(Color.black)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
