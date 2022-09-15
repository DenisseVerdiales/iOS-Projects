//
//  RickAndMortyTestCase.swift
//  RickAndMortyTests
//
//  Created by Consultant on 8/8/22.
//

import XCTest
@testable import RickAndMorty

class RickAndMortyTestCase: XCTestCase {

    var viewModel: RickAndMortyViewModel?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.viewModel = RickAndMortyViewModel()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        self.viewModel = nil
        try super.tearDownWithError()
    }
    
    func testRequestModelDataSuccess(){
        //Arrange
        let expectation = XCTestExpectation(description: "Successfully retrieving Models")
        
        //Act
        self.viewModel?.bind {
            expectation.fulfill()
        }
        
        self.viewModel?.fetchRickAndMortyPage()
        wait(for: [expectation], timeout: 3)
        
        //Assert
        XCTAssertEqual(self.viewModel?.count, 20)
        XCTAssertEqual(self.viewModel?.name(for: 0), "Rick Sanchez")
        XCTAssertEqual(self.viewModel?.status(for: 0), "Alive")
        XCTAssertEqual(self.viewModel?.gender(for: 0), "Male")
        XCTAssertEqual(self.viewModel?.species(for: 0), "Human")
        
        
    }


}
