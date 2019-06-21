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
        
        let nib = UINib(nibName: "GIFImageCollectionViewCell", bundle: nil)
        resultsCollectionView.register(nib, forCellWithReuseIdentifier: "cell")
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
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return result?.data?.count ?? 0 }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? GIFImageCollectionViewCell else { return UICollectionViewCell() }
        if let image = result?.data?[indexPath.item] { cell.set(image) }
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize(width: 100, height: 100)
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout,
        let image = result?.data?[indexPath.item], let width = Double(image.images?.preview_gif?.width ?? "0"),
        let height = Double(image.images?.preview_gif?.height ?? "0") else { return size }
        
        let aspectRatio = CGFloat(width/height)
        size.width = (collectionView.frame.width-flowLayout.minimumInteritemSpacing)/2
        size.height = size.width/aspectRatio
        
        return size
    }
}

extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("Prefetch - \(indexPaths)")
    }

    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("Cancel prefetch - \(indexPaths)")
    }
}
