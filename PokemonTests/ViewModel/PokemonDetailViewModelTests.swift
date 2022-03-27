//
//  PokemonDetailViewModelTests.swift
//  PokemonTests
//
//  Created by Nikol Lazarte on 26/03/22.
//

import XCTest
import Foundation
import Combine
import Apollo
@testable import Pokemon

class PokemonDetailViewModelTests: XCTestCase {

    func testFetchPokemonFlavourSucess() throws {
        let expectation = XCTestExpectation()
        let service = PokemonDetailServiceMock()
        let viewModel = PokemonDetailViewModel(pokemon: Pokemon.charmeleon, service: service, evolutions: [Pokemon.ivysaur])
        let cancellable = viewModel.$pokemon
            .sink(receiveCompletion: { _ in
                XCTExpectFailure()
            }, receiveValue: {
                expectation.fulfill()
                XCTAssertNotNil($0)
            })
        viewModel.fetchDetail(Pokemon.charmeleon)
        wait(for: [expectation], timeout: 0.1)
        XCTAssertEqual(viewModel.activeSprite, 0)
        XCTAssertEqual(viewModel.urlSprite, URL(string: viewModel.pokemonDefault))
        XCTAssert(((viewModel.evolutions?.isEmpty) != nil))
        XCTAssertNotNil(cancellable)
    }

    
    func testFetchPokemonFlavourFailure() throws {
        let expectation = XCTestExpectation()
        let service = PokemonDetailServiceMock()
        let viewModel = PokemonDetailViewModel(pokemon: Pokemon.charmeleon, service: service, evolutions: [Pokemon.ivysaur])
        let cancellable = viewModel.$pokemon
            .sink(receiveCompletion: { _ in
                XCTExpectFailure()
                XCTAssertEqual(viewModel.error, NetworkError.failLoadData)
            }, receiveValue: {
                expectation.fulfill()
                
                XCTAssertNotNil($0)
            })
        viewModel.fetchDetail(Pokemon.charmeleon)
        wait(for: [expectation], timeout: 1)
        XCTAssert(viewModel.pokemonColor.isEmpty)
        XCTAssert(viewModel.pokemonDescription.isEmpty)
        XCTAssertNotNil(cancellable)
    }

}
