//
//  CardCollectionViewLayout.swift
//  CollectionViewLayout
//
//  Created by jung on 3/10/25.
//

import UIKit

final class CardCollectionViewLayout: UICollectionViewLayout {
  let itemSize = CGSize(width: 133, height: 173)
  
  var radius: CGFloat = 500 {
    didSet { invalidateLayout() }
  }
  
  private var anglePerItem: CGFloat {
    return atan(itemSize.width / radius)
  }
  
  private var angleAtExtreme: CGFloat {
    guard let collectionView else { return .zero }
    
    let itemCount = collectionView.numberOfItems(inSection: 0)
    
    return itemCount > 0 ? -CGFloat(itemCount - 1) * anglePerItem : 0
  }
  
  private var angle: CGFloat {
    guard let collectionView else { return .zero }
    
    return angleAtExtreme * collectionView.contentOffset.x / (collectionViewContentSize.width - collectionView.bounds.width)
  }
  
  /// LayoutAttributes를 캐싱하기 위한 프로퍼티
  private var attributesList = [CardCollectionViewLayoutAttributes]()
  
  override var collectionViewContentSize: CGSize {
    guard let collectionView else { return .zero }
    
    return CGSize(
      width: itemSize.width * CGFloat(collectionView.numberOfItems(inSection: 0)),
      height: collectionView.bounds.height
    )
  }
  
  override class var layoutAttributesClass: AnyClass {
    return CardCollectionViewLayoutAttributes.self
  }
  
  override func prepare() {
    super.prepare()
    guard let collectionView else { return }
    
    let centerX = collectionView.contentOffset.x + (collectionView.bounds.width / 2.0)
    let anchorPointY = ((itemSize.height / 2.0) + radius) / itemSize.height
    
    let (startIndex, endIndex) = visibleIndexRange()
    
    attributesList = (startIndex...endIndex).map { index -> CardCollectionViewLayoutAttributes in
      let indexPath = IndexPath(row: index, section: 0)
      let attributes = CardCollectionViewLayoutAttributes(forCellWith: indexPath)
      attributes.size = self.itemSize
      
      attributes.center = CGPoint(x: centerX, y: collectionView.bounds.midY)
      attributes.anchorPoint = CGPoint(x: 0.5, y: anchorPointY)
      attributes.angle = self.angle + (self.anglePerItem * CGFloat(index))
      
      return attributes
    }
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    return attributesList
  }
  
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
}

// MARK: - Private Method
private extension CardCollectionViewLayout {
  /// 화면에 보이는 Cell의 Index범위를 리턴합니다.
  func visibleIndexRange() -> (startIndex: Int, endIndex: Int) {
    guard let collectionView else { return (0, 0) }
    
    let theta = atan2(CGRectGetWidth(collectionView.bounds) / 2.0,
                      radius + (itemSize.height / 2.0) - (CGRectGetHeight(collectionView.bounds) / 2.0))
    
    var startIndex = 0
    var endIndex = collectionView.numberOfItems(inSection: 0) - 1
    
    if (angle < -theta) {
      startIndex = Int(floor((-theta - angle) / anglePerItem))
    }
    
    endIndex = min(endIndex, Int(ceil((theta - angle) / anglePerItem)))
    
    if (endIndex < startIndex) {
      endIndex = 0
      startIndex = 0
    }
    
    return (startIndex, endIndex)
  }
}
