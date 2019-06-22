//
//  GiphyAPI_InfiniteScrollUITests.swift
//  GiphyAPI-InfiniteScrollUITests
//
//  Created by Akshit Zaveri on 19/06/19.
//  Copyright © 2019 Akshit Zaveri. All rights reserved.
//

import XCTest

class GiphyAPI_InfiniteScrollUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }

    func test_Search_GIF_And_SwipeUp() {
        
        let app = XCUIApplication()

        let searchCoolGifsSearchField = app.searchFields["Search cool GIFs"]
        searchCoolGifsSearchField.typeText("Me")
        
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards.buttons[\"Search\"]",".buttons[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.otherElements.containing(.navigationBar, identifier:"Cool GIFs").children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .collectionView).element.swipeUp()
    }
}
