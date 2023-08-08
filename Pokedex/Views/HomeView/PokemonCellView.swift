//
//  PokemonCellView.swift
//  Pokedex
//
//  Created by Jon Chang on 8/7/23.
//

import SwiftUI

struct PokemonCellView: View {
    let pokemon:Pokemon
    private let urlStr = "https://img.pokemondb.net/artwork/large/"
    private let extStr = ".jpg"
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: urlStr + pokemon.name + extStr)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .padding(.horizontal)
            } placeholder: {
                Image(systemName:"photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .padding(.horizontal)
            }
            
            Spacer()
            
            VStack {
                Text(pokemon.name.prefix(1).uppercased() + pokemon.name.dropFirst())
                    .font(.title)
                Text("# \(pokemon.data.id)")
                    .font(.title2)
            }
            
            Spacer()
        }
    }
}


struct PokemonCellView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            PokemonCellView(pokemon: mockData.mockPkmn)
            PokemonCellView(pokemon: mockData.mockPkmn2)
        }
    }
}

