//
//  MessageCollectionViewLayout.swift
//  CustomCollection
//
//  Created on 3/4/25.
//

import UIKit

final class MessageCollectionViewLayout: UICollectionViewLayout {
    private var contentSize = CGSize.zero
    private var layoutAttributesList = [UICollectionViewLayoutAttributes]()
    
    // MARK: Customization
    
    override var collectionViewContentSize: CGSize {
        contentSize
    }
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView else { return }
        
        contentSize.width = collectionView.bounds.width
        contentSize.height = max(
            collectionView.bounds.height + 1,
            layoutAttributesList.reduce(0, { $0 + $1.size.height })
        )
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        layoutAttributesList[indexPath.item]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        layoutAttributesList.filter({ $0.frame.intersects(rect) })
    }
    
    // MARK: Invalidation
    
    func append(contentsOf messages: [Message]) {
        guard let collectionView else { return }
        
        let messageCell = MessageCollectionViewCell()
        var lastOffsetY = layoutAttributesList.last?.frame.maxY ?? .zero
        for message in messages {
            let indexPath = IndexPath(item: layoutAttributesList.endIndex, section: .zero)
            let fittingSize = fittingSize(of: messageCell, for: message, in: collectionView)
            let layoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            layoutAttributes.frame = CGRect(origin: CGPoint(x: .zero, y: lastOffsetY), size: fittingSize)
            layoutAttributesList.append(layoutAttributes)
            lastOffsetY += fittingSize.height
        }
        invalidateLayout()
        collectionView.reloadData()
    }
    
    private func fittingSize(
        of cell: MessageCollectionViewCell,
        for message: Message,
        in collectionView: UICollectionView
    ) -> CGSize {
        cell.configure(with: message)
        let targetSize = CGSize(width: collectionView.bounds.width, height: UIView.layoutFittingCompressedSize.height)
        let fittingSize = cell.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        return fittingSize
    }
}
