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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(_ image: GIFImage) {
        imageView.image = nil
        guard let url = image.images?.preview_gif?.url else { return }
        imageView.setGifFromURL(url)
    }
}
