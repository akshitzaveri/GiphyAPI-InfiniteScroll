//
//  GIFImageCollectionViewCell.swift
//  GiphyAPI-InfiniteScroll
//
//  Created by Akshit Zaveri on 21/06/19.
//  Copyright © 2019 Akshit Zaveri. All rights reserved.
//

import UIKit
import SwiftyGif

final class GIFImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    private var downloadTask: URLSessionDataTask?
    
    func set(_ image: GIFImage) {
        downloadTask?.cancel()
        imageView.image = nil
        imageView.gifImage?.clear()
        imageView.gifImage = nil
        imageView.currentImage = nil
        guard let url = image.images?.preview_gif?.url else { return }
        downloadTask = imageView.setGifFromURL(url)
    }
}
