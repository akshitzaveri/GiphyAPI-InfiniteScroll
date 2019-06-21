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
    private var searchTask: URLSessionDataTask?
    private var result: SearchAPIResult?
    private var collectionViewAdapter: GiphyImageListCollectionViewAdapter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        giphy_search(for: "bottle")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        resultsCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func giphy_search(for string: String) {
        let newOffSet = (result?.pagination?.offset ?? 0) + (result?.pagination?.count ?? 0)
        print("Loading new data \(newOffSet)")
        searchTask = manager.search(string, newOffSet, completion: { (response, error) in
            DispatchQueue.main.async {
                if self.collectionViewAdapter == nil {
                    self.result = response
                    self.collectionViewAdapter = GiphyImageListCollectionViewAdapter(with: self.resultsCollectionView, and: response, delegate: self)
                    self.collectionViewAdapter?.reloadData()
                } else if (response?.data?.count ?? 0) > 0 {
                    let existingImages = self.result?.data ?? []
                    self.result = response
                    self.result?.data?.insert(contentsOf: existingImages, at: 0)
                    self.collectionViewAdapter?.update(self.result)
                }
            }
        })
    }
}

extension SearchViewController: GiphyImageListCollectionViewAdapterDelegate {
    func loadNextPage() {
        giphy_search(for: "bottle")
    }
}
