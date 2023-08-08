//
//  PokedexService.swift
//  Pokedex
//
//  Created by Jon Chang on 8/7/23.
//

import Foundation
import Combine

class PokedexService {
    private var cancellable = Set<AnyCancellable>()
    private let urlStr = "https://pokeapi.co/api/v2/pokemon/?limit=100&offset=0"
    
    func fetchPokedexData() -> Future<[PokemonResponse], Error> {
        return Future { [weak self] promise in
            guard let self = self else { return }
            guard let url = URL(string: urlStr) else { return }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: PokedexModel.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let err):
                        promise(.failure(err))
                    }
                } receiveValue: { response in
                    promise(.success(response.results))
                }
                .store(in: &cancellable)
        }
    }
    
    func fetchPokemonData(_ dataUrlStr: String) -> Future<PokemonData, Error> {
        return Future { [weak self] promise in
            guard let self = self else { return }
            guard let url = URL(string: dataUrlStr) else { return }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: PokemonData.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let err):
                        promise(.failure(err))
                    }
                } receiveValue: { response in
                    promise(.success(response))
                }
                .store(in: &cancellable)
        }
    }
}
