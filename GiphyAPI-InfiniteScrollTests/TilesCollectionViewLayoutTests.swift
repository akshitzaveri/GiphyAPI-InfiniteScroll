//
//  TilesCollectionViewLayoutTests.swift
//  GiphyAPI-InfiniteScrollTests
//
//  Created by Akshit Zaveri on 21/06/19.
//  Copyright © 2019 Akshit Zaveri. All rights reserved.
//

import XCTest
@testable import GiphyAPI_InfiniteScroll

class TilesCollectionViewLayoutTests: XCTestCase {

    // Assumption - The collectionview layout is supports 2 columns layout only.
    
    func test_FirstSecondCell_Frame_OriginY() {
        // given
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 500, height: 500), collectionViewLayout: TilesCollectionViewLayout())
        let searchResult = try! JSONDecoder().decode(SearchAPIResult.self, from: getData(from: "giphy_search_response_success")!)
        let adapter = GiphyImageListCollectionViewAdapter(with: collectionView, and: searchResult, delegate: nil)
        
        // when
        let attribtues = collectionView.layoutAttributesForItem(at: IndexPath(item: 0, section: 0))
        let attribtues1 = collectionView.layoutAttributesForItem(at: IndexPath(item: 1, section: 0))
        
        // then
        XCTAssertEqual(attribtues?.frame.origin.y, adapter.kSECTION_INSETS.top)
        XCTAssertEqual(attribtues1?.frame.origin.y, adapter.kSECTION_INSETS.top)
    }
    
    func test_ThirdCell_Frame_OriginY() {
        // given
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 500, height: 500), collectionViewLayout: TilesCollectionViewLayout())
        let searchResult = try! JSONDecoder().decode(SearchAPIResult.self, from: getData(from: "giphy_search_response_success")!)
        let adapter = GiphyImageListCollectionViewAdapter(with: collectionView, and: searchResult, delegate: nil)
        
        // when
        let attribtues = collectionView.layoutAttributesForItem(at: IndexPath(item: 2, section: 0))
        
        // then
        let spacings = adapter.kSECTION_INSETS.top + adapter.kMINIMUM_LINE_SPACING
        XCTAssertEqual(attribtues?.frame.origin.y, 119 + spacings)
    }
}
