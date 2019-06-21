//
//  TilesCollectionViewLayout.swift
//  GiphyAPI-InfiniteScroll
//
//  Created by Akshit Zaveri on 21/06/19.
//  Copyright © 2019 Akshit Zaveri. All rights reserved.
//

import UIKit

protocol TilesCollectionViewLayoutDelegate: class {
    func collectionView(_ collectionView: UICollectionView, aspectRatioForImageAtIndexPath indexPath: IndexPath) -> CGFloat
}

class TilesCollectionViewLayout: UICollectionViewFlowLayout {
    
    weak var delegate: TilesCollectionViewLayoutDelegate!
    fileprivate var numberOfColumns: Int
    private(set) var cache = [UICollectionViewLayoutAttributes]()
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    fileprivate var contentHeight = CGFloat(0)
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    var xOffset = [CGFloat]()
    var yOffset = [CGFloat]()
    
    init(numberOfColumns: Int = 2,
         delegate: TilesCollectionViewLayoutDelegate?,
         sectionInset: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8),
         minimumInteritemSpacing: CGFloat = CGFloat(8),
         minimumLineSpacing: CGFloat = CGFloat(8)) {
        
        self.numberOfColumns = numberOfColumns
        self.delegate = delegate
        super.init()
        self.sectionInset = sectionInset
        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.minimumLineSpacing = minimumLineSpacing
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func getColumnWidth() -> CGFloat {
        let interItemSpacing = (minimumInteritemSpacing * CGFloat(numberOfColumns - 1))
        let columnWidth = (contentWidth - interItemSpacing - sectionInset.left - sectionInset.right) / CGFloat(numberOfColumns)
        return columnWidth
    }
    
    override func prepare() {
        guard cache.isEmpty, let collectionView = collectionView else { return }
        
        let columnWidth = getColumnWidth()
        xOffset = [CGFloat]()
        for column in 0..<numberOfColumns {
            var x: CGFloat = 0
            if let previous = xOffset.last { x = previous + columnWidth + minimumInteritemSpacing }
            else { x = CGFloat(column) * columnWidth + sectionInset.left }
            xOffset.append(x)
        }
        var column = 0
        let firstRowOffset = collectionView.contentInset.top + sectionInset.top
        yOffset = [CGFloat](repeating: firstRowOffset, count: numberOfColumns)
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            calculateFrames(itemIndex: item, column: &column, columnWidth: columnWidth)
        }
    }
    
    func calculateFrames(itemIndex: Int, column: inout Int, columnWidth: CGFloat) {
        guard let collectionView = collectionView else { return }
        
        let indexPath = IndexPath(item: itemIndex, section: 0)
        
        let aspectRatio = delegate.collectionView(collectionView, aspectRatioForImageAtIndexPath: indexPath)
        let height = (columnWidth / aspectRatio)
        let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
        
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = frame
        cache.append(attributes)
        
        contentHeight = max(contentHeight, frame.maxY)
        yOffset[column] += (height + minimumLineSpacing)
        
        column = (column < (numberOfColumns - 1)) ? (column + 1) : 0
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        cache = []
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesForElementsInVisibleRect = [UICollectionViewLayoutAttributes]()
        for attributesForElement in cache {
            guard attributesForElement.frame.intersects(rect) else { continue }
            attributesForElementsInVisibleRect.append(attributesForElement)
        }
        return attributesForElementsInVisibleRect
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
