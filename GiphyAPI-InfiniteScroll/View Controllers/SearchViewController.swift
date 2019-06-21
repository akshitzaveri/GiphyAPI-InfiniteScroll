//
//  SearchViewController.swift
//  GiphyAPI-InfiniteScroll
//
//  Created by Akshit Zaveri on 19/06/19.
//  Copyright © 2019 Akshit Zaveri. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {

    @IBOutlet weak var resultsCollectionView: UICollectionView!
    
    private var manager = GiphyNetworkManager()
    private var result: SearchAPIResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        giphy_search(for: "hello")
    }
    
    private func giphy_search(for string: String) {
        manager.search(string, completion: { (response, error) in
            self.result = response
            DispatchQueue.main.async {
                self.resultsCollectionView.reloadData()
            }
        })
    }
}

// Assumption - We don't need UICollectionViewDelegate for now
//extension SearchViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return results.count }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        return UICollectionViewCell()
//    }
//}
//
//extension SearchViewController: UICollectionViewDataSourcePrefetching {
//    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
//
//    }
//}
