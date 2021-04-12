//
//  MembersCollectionView.swift
//  onboarding
//
//  Created by Anastasia Holovash on 2021-04-12.
//

import UIKit

//final class MembersCollectionView: UICollectionView {
//  
//  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
//    super.init(frame: frame, collectionViewLayout: layout)
//    
//    self.backgroundColor = Asset.systemLight.color
//    self.register(cell: MemberCollectionViewCell.self)
//  }
//  
//  convenience init() {
//    self.init(frame: .zero, collectionViewLayout: CollectionViewFlowLayout())
//  }
//  
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//}
//
//class CollectionViewFlowLayout: UICollectionViewFlowLayout {
//  
//  required override init() {
//    super.init()
//    setup()
//  }
//  
//  required init?(coder aDecoder: NSCoder) {
//    super.init(coder: aDecoder)
//    setup()
//  }
//  
//  private func setup() {
//    estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//    minimumLineSpacing = 16
//    minimumInteritemSpacing = 16
//  }
//  
//  override func layoutAttributesForElements(
//    in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//    
//    guard let att = super.layoutAttributesForElements(in:rect) else {
//      return []
//    }
//    var x: CGFloat = sectionInset.left
//    var y: CGFloat = -1.0
//    
//    for a in att {
//      if a.representedElementCategory != .cell {
//        continue
//      }
//      
//      if a.frame.origin.y >= y { x = sectionInset.left }
//      a.frame.origin.x = x
//      x += a.frame.width + minimumInteritemSpacing
//      y = a.frame.maxY
//    }
//    return att
//  }
//}

final class LeftAlignmentFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var attributesCopy: [UICollectionViewLayoutAttributes] = []
        
        if let attributes = super.layoutAttributesForElements(in: rect) {
            attributesCopy = attributes.compactMap { $0.copy() as? UICollectionViewLayoutAttributes }
        }
        
        for attributes in attributesCopy {
            if attributes.representedElementKind == nil {
                let indexpath = attributes.indexPath
                if let attr = layoutAttributesForItem(at: indexpath) {
                    attributes.frame = attr.frame
                }
            }
        }
        return attributesCopy
    }
        
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        if let currentItemAttributes = super.layoutAttributesForItem(at: indexPath as IndexPath)?.copy() as? UICollectionViewLayoutAttributes, let collection = collectionView {
            
            let sectionInset = evaluatedSectionInsetForItem(at: indexPath.section)
            let isFirstItemInSection = indexPath.item == 0
            let layoutWidth = collection.frame.width - sectionInset.left - sectionInset.right
            
            guard !isFirstItemInSection else {
                currentItemAttributes.leftAlignFrame(with: sectionInset)
                return currentItemAttributes
            }
            
            let previousIndexPath = IndexPath(item: indexPath.item - 1, section: indexPath.section)
            
            let previousFrame = layoutAttributesForItem(at: previousIndexPath)?.frame ?? CGRect.zero
            let previousFrameRightPoint = previousFrame.origin.x + previousFrame.width
            let currentFrame = currentItemAttributes.frame
            let strecthedCurrentFrame = CGRect(x: sectionInset.left,
                                               y: currentFrame.origin.y,
                                               width: layoutWidth,
                                               height: currentFrame.size.height)
            
            // if the current frame, once left aligned to the left and stretched to the full collection view
            // widht intersects the previous frame then they are on the same line
            let isFirstItemInRow = !previousFrame.intersects(strecthedCurrentFrame)
            
            guard !isFirstItemInRow else {
                // make sure the first item on a line is left aligned
                currentItemAttributes.leftAlignFrame(with: sectionInset)
                return currentItemAttributes
            }
            
            var frame = currentItemAttributes.frame
            frame.origin.x = previousFrameRightPoint + evaluatedMinimumInteritemSpacing(at: indexPath.section)
            currentItemAttributes.frame = frame
            
            return currentItemAttributes
            
        }
        return nil
    }
    
    func evaluatedMinimumInteritemSpacing(at sectionIndex: Int) -> CGFloat {
        
        if let delegate = collectionView?.delegate as? UICollectionViewDelegateFlowLayout, let collection = collectionView {
            let inteitemSpacing = delegate.collectionView?(collection, layout: self, minimumInteritemSpacingForSectionAt: sectionIndex)
            if let inteitemSpacing = inteitemSpacing {
                return inteitemSpacing
            }
        }
        return minimumInteritemSpacing
    }
    
    func evaluatedSectionInsetForItem(at index: Int) -> UIEdgeInsets {
        
        if let delegate = collectionView?.delegate as? UICollectionViewDelegateFlowLayout, let collection = collectionView {
            let insetForSection = delegate.collectionView?(collection, layout: self, insetForSectionAt: index)
            if let insetForSectionAt = insetForSection {
                return insetForSectionAt
            }
        }
        return sectionInset
    }
}

extension UICollectionViewLayoutAttributes {
    
    func leftAlignFrame(with sectionInset: UIEdgeInsets) {
        
        var tempFrame = frame
        tempFrame.origin.x = sectionInset.left
        frame = tempFrame
    }
}
