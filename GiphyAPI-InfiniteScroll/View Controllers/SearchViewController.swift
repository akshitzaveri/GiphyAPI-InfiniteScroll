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
    
    private var results: []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
}
