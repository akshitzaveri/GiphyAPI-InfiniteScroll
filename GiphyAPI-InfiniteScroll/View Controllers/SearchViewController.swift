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
        resultsCollectionView.reloadData()
    }
    
    private func giphy_search(for string: String) {
        searchTask = manager.search(string, completion: { (response, error) in
            self.result = response
            DispatchQueue.main.async { [unowned self] in
                self.collectionViewAdapter = GiphyImageListCollectionViewAdapter(with: self.resultsCollectionView, and: response, delegate: self)
                self.collectionViewAdapter?.reloadData()
            }
        })
    }
}

extension SearchViewController: GiphyImageListCollectionViewAdapterDelegate {
    
    func loadNextPage() {
        print("=============================")
    }
}
