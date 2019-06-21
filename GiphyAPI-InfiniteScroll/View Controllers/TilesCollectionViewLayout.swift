//
//  TilesCollectionViewLayout.swift
//  GiphyAPI-InfiniteScroll
//
//  Created by Akshit Zaveri on 21/06/19.
//  Copyright © 2019 Akshit Zaveri. All rights reserved.
//

import UIKit

class TilesCollectionViewLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributesForElementsInRect = super.layoutAttributesForElements(in: rect)
        for attributesForElement in attributesForElementsInRect ?? [] {
            guard (attributesForElement.representedElementKind == nil) else { continue }
            guard let frame = layoutAttributesForItem(at: attributesForElement.indexPath)?.frame else { continue }
            attributesForElement.frame = frame
        }
        return attributesForElementsInRect
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributesForCurrentItem = super.layoutAttributesForItem(at: indexPath) else { return nil }
        var frameForCurrentItem = attributesForCurrentItem.frame
        
        // Assumption - 2 columns only
        if indexPath.item == 0 || indexPath.item == 1 {
            frameForCurrentItem.origin.y = sectionInset.top
            attributesForCurrentItem.frame = frameForCurrentItem
            return attributesForCurrentItem
        }
        
        let indexPathForItemAboveCurrentItem = IndexPath(item: indexPath.item-2, section: indexPath.section)
        guard let frameForItemAboveCurrentItem = layoutAttributesForItem(at: indexPathForItemAboveCurrentItem)?.frame else {
            return attributesForCurrentItem
        }
        
        frameForCurrentItem.origin.y = frameForItemAboveCurrentItem.origin.y + frameForItemAboveCurrentItem.height + minimumLineSpacing
        attributesForCurrentItem.frame = frameForCurrentItem
        
        return attributesForCurrentItem
    }
}
