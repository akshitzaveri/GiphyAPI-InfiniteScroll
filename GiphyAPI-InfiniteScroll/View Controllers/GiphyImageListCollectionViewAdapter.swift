//
//  GiphyImageListCollectionViewAdapter.swift
//  GiphyAPI-InfiniteScroll
//
//  Created by Akshit Zaveri on 21/06/19.
//  Copyright © 2019 Akshit Zaveri. All rights reserved.
//

import UIKit
import SwiftyGif

protocol GiphyImageListCollectionViewAdapterDelegate {
    func loadNextPage()
}

class GiphyImageListCollectionViewAdapter: NSObject {
    let kSECTION_INSETS = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    let kNUMBER_OF_COLUMNS = CGFloat(2)
    let kMINIMUM_INTER_ITEM_SPACING = CGFloat(8)
    let kMINIMUM_LINE_SPACING = CGFloat(8)
    let kGIFImageCollectionViewCellName = "GIFImageCollectionViewCell"
    private(set) var collectionView: UICollectionView!
    private(set) var result: SearchAPIResult?
    private(set) var delegate: GiphyImageListCollectionViewAdapterDelegate?
    private(set) var prefetchingDownloadTasks = [IndexPath: URLSessionDataTask]()
    
    init(with collectionView: UICollectionView, and result: SearchAPIResult?, delegate: GiphyImageListCollectionViewAdapterDelegate?) {
        super.init()
        
        self.delegate = delegate
        self.result = result
        
        self.collectionView = collectionView
        setSectionInsetAndSpacings()
        
        let nib = UINib(nibName: kGIFImageCollectionViewCellName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        
        // Note - We don't need UICollectionViewDelegate methods for now. But to make UICollectionViewDelegateFlowLayout work, we have to assign a delegate
        collectionView.delegate = self
    }
    
    // Note - We could simply keep reloadData in view controller but it's more about separating concerns
    func reloadData() { collectionView.reloadData() }
    
    private func setSectionInsetAndSpacings() {
        let flowLayout = collectionView.collectionViewLayout as? TilesCollectionViewLayout
        flowLayout?.sectionInset = kSECTION_INSETS
        flowLayout?.minimumInteritemSpacing = kMINIMUM_INTER_ITEM_SPACING
        flowLayout?.minimumLineSpacing = kMINIMUM_LINE_SPACING
    }
}

extension GiphyImageListCollectionViewAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return result?.data?.count ?? 0 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? GIFImageCollectionViewCell else { return UICollectionViewCell() }
        if let image = result?.data?[indexPath.item] { cell.set(image) }
        return cell
    }
}

extension GiphyImageListCollectionViewAdapter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize.zero
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout,
            let image = result?.data?[indexPath.item], let width = Double(image.images?.preview_gif?.width ?? "0"),
            let height = Double(image.images?.preview_gif?.height ?? "0") else { return size }
        
        let insets = flowLayout.sectionInset.left + flowLayout.sectionInset.right + flowLayout.minimumInteritemSpacing
        size.width = (collectionView.frame.width - insets) / kNUMBER_OF_COLUMNS
        
        let aspectRatio = CGFloat(width / height)
        size.height = size.width / aspectRatio
        
        return size
    }
}

extension GiphyImageListCollectionViewAdapter: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let maxIndexPath = indexPaths.max(), let totalImagesCount = result?.data?.count else {
            return
        }
        if maxIndexPath.item >= totalImagesCount-1 { delegate?.loadNextPage() }
        else { prefetchGIFs(for: indexPaths) }
    }
    
    func prefetchGIFs(for indexPaths: [IndexPath]) {
        // Pre-fetching the GIFs
        for indexPath in indexPaths {
            guard let url = result?.data?[indexPath.item].images?.preview_gif?.url else { continue }
            let downloadTask = UIImageView().setGifFromURL(url)
            prefetchingDownloadTasks[indexPath] = downloadTask
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        cancelPrefetch(for: indexPaths)
    }
    
    func cancelPrefetch(for indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            prefetchingDownloadTasks[indexPath]?.cancel()
            prefetchingDownloadTasks[indexPath] = nil
        }
    }
}

