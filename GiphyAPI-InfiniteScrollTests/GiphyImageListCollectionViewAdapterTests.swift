//
//  GiphyImageListCollectionViewAdapterTests.swift
//  GiphyAPI-InfiniteScrollTests
//
//  Created by Akshit Zaveri on 21/06/19.
//  Copyright © 2019 Akshit Zaveri. All rights reserved.
//

import XCTest
@testable import GiphyAPI_InfiniteScroll

class GiphyImageListCollectionViewAdapterTests: XCTestCase {

    private class SearchViewControllerMock: UIViewController, GiphyImageListCollectionViewAdapterDelegate {
        var loadNextPageCalled = false
        func loadNextPage() { loadNextPageCalled = true }
    }
}

// MARK: Tests for data source functions
extension GiphyImageListCollectionViewAdapterTests {
    func test_Initialization() {
        // given
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 500, height: 500), collectionViewLayout: TilesCollectionViewLayout())
        let searchResult = try! JSONDecoder().decode(SearchAPIResult.self, from: getData(from: "giphy_search_response_success")!)
        let viewcontroller = SearchViewControllerMock()
        
        // when
        let sut = GiphyImageListCollectionViewAdapter(with: collectionView, and: searchResult, delegate: viewcontroller)
        
        // then
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.collectionView, collectionView)
        
        XCTAssertNotNil(sut.collectionView.dataSource)
        assert(sut.collectionView.dataSource is GiphyImageListCollectionViewAdapter)
        
        XCTAssertNotNil(sut.collectionView.prefetchDataSource)
        assert(sut.collectionView.prefetchDataSource is GiphyImageListCollectionViewAdapter)
        
        XCTAssertNotNil(sut.collectionView.delegate)
        assert(sut.collectionView.delegate is GiphyImageListCollectionViewAdapter)
        
        XCTAssertEqual(sut.result!, searchResult)
        
        assert(sut.delegate! is SearchViewControllerMock)
        assert(sut.collectionView.collectionViewLayout is TilesCollectionViewLayout)
        
        let flowLayout = collectionView.collectionViewLayout as! TilesCollectionViewLayout
        XCTAssertEqual(flowLayout.sectionInset, sut.kSECTION_INSETS)
        XCTAssertEqual(flowLayout.minimumInteritemSpacing, sut.kMINIMUM_INTER_ITEM_SPACING)
        XCTAssertEqual(flowLayout.minimumLineSpacing, sut.kMINIMUM_LINE_SPACING)
    }
    
    func test_CollectionView_NumberOfItems() {
        // given
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 500, height: 500), collectionViewLayout: TilesCollectionViewLayout())
        let searchResult = try! JSONDecoder().decode(SearchAPIResult.self, from: getData(from: "giphy_search_response_success")!)
        let viewcontroller = SearchViewControllerMock()
        
        // when
        let sut = GiphyImageListCollectionViewAdapter(with: collectionView, and: searchResult, delegate: viewcontroller)
        let numberOfItems = sut.collectionView(collectionView, numberOfItemsInSection: 0)
        
        // then
        XCTAssertEqual(numberOfItems, 25)
    }
    
    func test_CollectionView_CellForItemAtIndexPath() {
        // given
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 500, height: 500), collectionViewLayout: TilesCollectionViewLayout())
        let searchResult = try! JSONDecoder().decode(SearchAPIResult.self, from: getData(from: "giphy_search_response_success")!)
        let viewcontroller = SearchViewControllerMock()
        
        // when
        let sut = GiphyImageListCollectionViewAdapter(with: collectionView, and: searchResult, delegate: viewcontroller)
        let cell = sut.collectionView(collectionView, cellForItemAt: IndexPath(item: 0, section: 0))
        
        // then
        XCTAssertTrue(cell is GIFImageCollectionViewCell)
    }
    
    func test_CollectionViewCell_Size() {
        // given
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 500, height: 500), collectionViewLayout: TilesCollectionViewLayout())
        let searchResult = try! JSONDecoder().decode(SearchAPIResult.self, from: getData(from: "giphy_search_response_success")!)
        let viewcontroller = SearchViewControllerMock()
        
        // when
        let sut = GiphyImageListCollectionViewAdapter(with: collectionView, and: searchResult, delegate: viewcontroller)
        let size = sut.collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: IndexPath(item: 0, section: 0))
        
        // then
        XCTAssertEqual(size.width, 238)
        XCTAssertEqual(size.height, 119)
    }
}

// MARK: Tests for data source prefetching
extension GiphyImageListCollectionViewAdapterTests {
    
    func test_CollectionView_PrefetchingNextImages() {
        // given
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 500, height: 500), collectionViewLayout: TilesCollectionViewLayout())
        let searchResult = try! JSONDecoder().decode(SearchAPIResult.self, from: getData(from: "giphy_search_response_success")!)
        let viewcontroller = SearchViewControllerMock()
        
        // when
        let sut = GiphyImageListCollectionViewAdapter(with: collectionView, and: searchResult, delegate: viewcontroller)
        let indexPath = IndexPath(item: 2, section: 0)
        let indexPath1 = IndexPath(item: 3, section: 0)
        sut.collectionView(collectionView, prefetchItemsAt: [indexPath, indexPath1])
        
        // then
        XCTAssertNotNil(sut.prefetchingDownloadTasks[indexPath])
        XCTAssertNotNil(sut.prefetchingDownloadTasks[indexPath1])
    }
    
    func test_CollectionView_PrefetchingNextImages_CancelOperation() {
        // given
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 500, height: 500), collectionViewLayout: TilesCollectionViewLayout())
        let searchResult = try! JSONDecoder().decode(SearchAPIResult.self, from: getData(from: "giphy_search_response_success")!)
        let viewcontroller = SearchViewControllerMock()
        
        // when
        let sut = GiphyImageListCollectionViewAdapter(with: collectionView, and: searchResult, delegate: viewcontroller)
        let indexPath = IndexPath(item: 2, section: 0)
        let indexPath1 = IndexPath(item: 3, section: 0)
        sut.collectionView(collectionView, prefetchItemsAt: [indexPath, indexPath1])
        sut.collectionView(collectionView, cancelPrefetchingForItemsAt: [indexPath1])
        
        // then
        XCTAssertNotNil(sut.prefetchingDownloadTasks[indexPath])
        XCTAssertNil(sut.prefetchingDownloadTasks[indexPath1])
    }
    
    func test_Prefetch_loadNextPage() {
        // given
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 500, height: 500), collectionViewLayout: TilesCollectionViewLayout())
        let searchResult = try! JSONDecoder().decode(SearchAPIResult.self, from: getData(from: "giphy_search_response_success")!)
        let viewcontroller = SearchViewControllerMock()
        
        // when
        let sut = GiphyImageListCollectionViewAdapter(with: collectionView, and: searchResult, delegate: viewcontroller)
        sut.collectionView(collectionView, prefetchItemsAt: [IndexPath(item: 24, section: 0)])
        
        // then
        XCTAssertTrue(viewcontroller.loadNextPageCalled)
    }
}
