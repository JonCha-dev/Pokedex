//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by Jon Chang on 8/7/23.
//

import Foundation
import Combine

enum Status {
    case initial, loading, loaded, error
}

class HomeViewModel: ObservableObject {
    private var cancellable = Set<AnyCancellable>()
    private let service = PokedexService()
    
    @Published var data:[Pokemon] = [Pokemon]()
    @Published var status:Status = .initial
    
    func getPokedexData() {
        status = .loading
        
        service.fetchPokedexData()
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    self?.status = .error
                    print(String(describing: err))
                }
            } receiveValue: { [weak self] response in
                for pokemon in response {
                    self?.getPokemonData(pokemon)
                }
                
                self?.status = .loaded
            }
            .store(in: &cancellable)
    }
    
    func getPokemonData(_ pokemon: PokemonResponse) {
        service.fetchPokemonData(pokemon.url)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    self?.status = .error
                    print(String(describing: err))
                }
            } receiveValue: { [weak self] response in
                self?.data.append(Pokemon(name: pokemon.name, data: response))
            }
            .store(in: &cancellable)
    }
}
