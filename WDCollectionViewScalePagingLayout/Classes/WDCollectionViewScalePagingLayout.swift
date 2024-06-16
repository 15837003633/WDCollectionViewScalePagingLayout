//
//  WDCollectionViewScalePagingLayout.swift
//  WDCollectionViewScalePagingLayout
//
//  Created by scott on 2024/6/16.
//

import UIKit
import Foundation

public class WDCollectionViewScalePagingLayout: UICollectionViewLayout {
    public var edgeSpacing: CGFloat = 15  //边缘间距
    public var itemSpacing: CGFloat = 0 //item宽度+item间隙
    public var interitemSpacing: CGFloat = 0  //item间隙
    public var itemSize: CGSize = .zero //item大小
    
    private var needUpdateBounds: Bool = true //是否需要更新collectionView的bounds
    private var contentWidth: CGFloat = 0  //宽度总内容
    private var numberOfItems: NSInteger = 0  //cell数量
    
    //MARK: life circle
    public override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else {
            fatalError("collectionView is required")
        }
        edgeSpacing = (collectionView.frame.size.width - itemSize.width) * 0.5
        collectionView.decelerationRate = .fast
        itemSpacing = itemSize.width + interitemSpacing
        numberOfItems = collectionView.numberOfItems(inSection: 0)
        let totalEdgeSpacing = edgeSpacing * 2
        let totalItemWidth = itemSize.width * CGFloat(numberOfItems)
        let totalSpacing = CGFloat(numberOfItems - 1) * interitemSpacing
        contentWidth = totalSpacing + totalItemWidth + totalEdgeSpacing
        if needUpdateBounds {
            let newBounds = CGRect(x: CGFloat(numberOfItems) * 0.5 * itemSpacing, y: 0, width: collectionView.frame.size.width, height: collectionView.frame.size.height)
            collectionView.bounds = newBounds
//            bounds相当于contentOffset
//            collectionView.contentOffset = CGPointMake(CGFloat(numberOfItems) * 0.5 * itemSpacing, 0)
            needUpdateBounds = false
        }
    }
    
    //MARK: override
    public override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: collectionView?.frame.size.height ?? 0)
    }
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    public override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            fatalError("collectionView is required")
        }
        let startOffsetX = roundf(Float(collectionView.contentOffset.x / itemSpacing)) * Float(itemSpacing)
        var proposedOffsetX = startOffsetX
        let translation = collectionView.panGestureRecognizer.translation(in: collectionView)
        let minTranslationDistance = min(itemSpacing * 0.5, 150)
        if abs(translation.x) < minTranslationDistance {
            if abs(velocity.x) > 0.3 && abs(startOffsetX - proposedOffsetX) < Float(itemSpacing) {
                proposedOffsetX = proposedOffsetX + Float(itemSpacing * velocity.x / abs(velocity.x))
            }
        }
        if abs(proposedOffsetX - startOffsetX) >= Float(2 * itemSpacing) {
            proposedOffsetX = proposedOffsetX + Float(itemSpacing * velocity.x / abs(velocity.x))
        }
        return CGPoint(x: CGFloat(proposedOffsetX), y: proposedContentOffset.y)
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesArray = [UICollectionViewLayoutAttributes]()
        let rectMinx = rect.origin.x
        let rectMaxx = rect.origin.x + rect.size.width
        var startIndex = max(Int((rectMinx - edgeSpacing) / itemSpacing), 0)
        var startPosition = edgeSpacing + CGFloat(startIndex) * itemSpacing
        let endPosition = min(rectMaxx, contentWidth - itemSpacing - edgeSpacing)
        while startPosition <= endPosition {
            let indexPath = IndexPath(item: startIndex, section: 0)
            if let attribute = self.layoutAttributesForItem(at: indexPath) {
                attributesArray.append(attribute)
            } else {
                attributesArray.append(self.layoutAttributesForItemIfNil(at: indexPath))
            }
            startIndex = startIndex + 1
            startPosition = startPosition + itemSpacing
        }
        return attributesArray
    }
    
    public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let collectionView = collectionView else {
            return nil
        }
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.size = itemSize
        let x = edgeSpacing + CGFloat(indexPath.item) * itemSpacing
        let y = (collectionView.frame.size.height - itemSize.height) * 0.5
        attributes.frame = CGRect(x: x, y: y, width: itemSize.width, height: itemSize.height)
        if numberOfItems > 1 {
            let centerX = collectionView.bounds.origin.x + collectionView.bounds.width * 0.5
            let attributeCenterX = attributes.center.x
            let proportion = (attributeCenterX - centerX) / itemSpacing
            let scale = (1 - abs(proportion) * 0.1)
            var transform = CGAffineTransform.identity
            transform = CGAffineTransformScale(transform, scale, scale)
//            transform = CGAffineTransformTranslate(transform, 0, (attributes.frame.size.height * (1 - scale)) * 0.5)
            attributes.transform = transform
        }
        return attributes
    }

    private func layoutAttributesForItemIfNil(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes {

        guard let collectionView = collectionView else {
            fatalError("collectionView is required")
        }
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.size = itemSize
        let x = edgeSpacing + CGFloat(indexPath.item) * itemSpacing
        let y = (collectionView.frame.size.height - itemSize.height) * 0.5
        attributes.frame = CGRect(x: x, y: y, width: itemSize.width, height: itemSize.height)
        if numberOfItems > 1 {
            let centerX = collectionView.bounds.origin.x + collectionView.bounds.width * 0.5
            let attributeCenterX = attributes.center.x
            let proportion = (attributeCenterX - centerX) / itemSpacing
            let scale = (1 - abs(proportion) * 0.1)
            var transform = CGAffineTransform.identity
            transform = CGAffineTransformScale(transform, scale, scale)
            transform = CGAffineTransformTranslate(transform, 0, (attributes.frame.size.height * (1 - scale)) * 0.5)
            attributes.transform = transform
        }
        return attributes
    }
}
