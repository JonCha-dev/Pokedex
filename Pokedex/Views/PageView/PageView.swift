//
//  PageView.swift
//  Pokedex
//
//  Created by Jon Chang on 8/7/23.
//

import SwiftUI

struct PageView: View {
    let pokemon: Pokemon
    private let urlStr = "https://img.pokemondb.net/artwork/large/"
    private let extStr = ".jpg"
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: urlStr + pokemon.name + extStr)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal)
            } placeholder: {
                Image(systemName:"photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal)
            }
            .padding(.bottom, 30)
            
            Text(pokemon.name.prefix(1).uppercased() + pokemon.name.dropFirst() + ", #\(pokemon.data.id)")
                .font(.title)
            Text("Height: \(pokemon.data.height)")
                .font(.body)
            Text("Weight: \(pokemon.data.weight)")
                .font(.body)
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(pokemon: mockData.mockPkmn)
    }
}
