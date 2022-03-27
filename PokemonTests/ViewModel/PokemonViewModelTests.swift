//
//  PokemonViewModelTests.swift
//  PokemonTests
//
//  Created by Nikol Lazarte on 26/03/22.
//

import XCTest
import Foundation
import Combine
import Apollo
@testable import Pokemon


class PokemonViewModelTests: XCTestCase {

    func testFetchPokemonsSucess() throws {
        let expectation = XCTestExpectation()
        let service = PokemonListServiceMock()
        let viewModel = PokemonListViewModel(service: service)
        let cancellable = viewModel.$pokemons
            .dropFirst()
            .sink(receiveCompletion: {  _ in
                XCTExpectFailure()
            }, receiveValue: {
                expectation.fulfill()
                XCTAssertNotNil($0)
            })
        viewModel.fetchPokemons()
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(1, viewModel.pokemons.count)
        XCTAssertEqual(viewModel.classifications.count, 1)
        XCTAssertEqual(viewModel.getEvolutions(to: Pokemon.charmeleon)!.count, 0)
        XCTAssertEqual(viewModel.searchPokemons.count, 1)
        XCTAssertNotNil(cancellable)
    }
    
    func testFetchPokemonsFailure() throws {
        let expectation = XCTestExpectation()
        let service = PokemonListServiceMock(result: .failure)
        let viewModel = PokemonListViewModel(service: service)
        
        let cancellable = viewModel.$pokemons
            .sink(receiveCompletion: {  _ in
                XCTExpectFailure()
                XCTAssertEqual(viewModel.error, NetworkError.failLoadData)
            }, receiveValue: {
                expectation.fulfill()
                
                XCTAssertNotNil($0)
            })
        viewModel.fetchPokemons()
        XCTAssert(viewModel.pokemons.isEmpty)
        XCTAssert(viewModel.searchPokemons.isEmpty)
        XCTAssert(viewModel.errorLoadData)
        XCTAssertNotNil(cancellable)
    }
    
    func testFetchPokemonsDelayed() throws {
        let expectation = XCTestExpectation()
        let service = PokemonListServiceMock(result: .delayed)
        let viewModel = PokemonListViewModel(service: service)
        
        let cancellable = viewModel.$pokemons
            .dropFirst()
            .sink(receiveCompletion: {  _ in
                XCTExpectFailure()
            }, receiveValue: {
                expectation.fulfill()
                XCTAssertNotNil($0)
            })
        viewModel.fetchPokemons()
        wait(for: [expectation], timeout: 1)
        
        XCTAssertFalse(viewModel.pokemons.isEmpty)
        XCTAssertNotNil(cancellable)
    }

}

extension Pokemon {
    static let ivysaur = Pokemon(number: "002", name: "Ivysaur", classification: "Seed Pokémon", types: [
        "Grass", "Poison"], evolutions: [GetAllPokemonsQuery.Data.Pokemon.Evolution(number: "003", name: "Venusaur")], image: "https://img.pokemondb.net/artwork/ivysaur.jpg")
    
    static let charmeleon = Pokemon(number: "005", name: "Charmeleon", classification: "Flame Pokémon", types: [
        "Fire"], evolutions: [GetAllPokemonsQuery.Data.Pokemon.Evolution(number: "006", name: "Venusaur"), GetAllPokemonsQuery.Data.Pokemon.Evolution(number: "007", name: "Charizard")], image: "https://img.pokemondb.net/artwork/ivysaur.jpg")
}
