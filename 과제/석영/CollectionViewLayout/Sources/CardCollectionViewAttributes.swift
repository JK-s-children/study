//
//  CardCollectionViewAttributes.swift
//  CollectionViewLayout
//
//  Created by jung on 3/10/25.
//

import UIKit

final class CardCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
  var anchorPoint = CGPoint(x: 0.5, y: 0.5)
  var angle: CGFloat = 0 {
    didSet {
      zIndex = Int(angle * 1000000)
      transform = CGAffineTransformMakeRotation(angle)
    }
  }
  
  override func copy(with zone: NSZone? = nil) -> Any {
    let copiedAttributes = super.copy(with: zone)
    
    guard let copiedCircularAttributes : CardCollectionViewLayoutAttributes = copiedAttributes as? CardCollectionViewLayoutAttributes else {
      return copiedAttributes
    }
    
    copiedCircularAttributes.anchorPoint = self.anchorPoint
    copiedCircularAttributes.angle = self.angle
    return copiedCircularAttributes
  }
}
