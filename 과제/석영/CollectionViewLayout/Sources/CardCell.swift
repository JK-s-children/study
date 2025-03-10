//
//  CardCell.swift
//  CollectionViewLayout
//
//  Created by jung on 3/10/25.
//

import UIKit

final class CardCell: UICollectionViewCell {
  // MARK: - UI Components
  private let label = UILabel()
  
  // MARK: - Initazliers
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    configureUI()
  }
  
  // MARK: - Apply Method
  override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    super.apply(layoutAttributes)
    
    guard let circularLayoutAttributes = layoutAttributes as? CardCollectionViewLayoutAttributes else { return }
    
    self.layer.anchorPoint = circularLayoutAttributes.anchorPoint
    self.center.y += (circularLayoutAttributes.anchorPoint.y - 0.5) * CGRectGetHeight(self.bounds)
  }
  
  // MARK: - Configure Method
  func configure(with model: CardPresentationModel) {
    self.backgroundColor = model.color
    self.label.text = model.title
  }
}

// MARK: - UI Setting
private extension CardCell {
  func configureUI() {
    contentView.addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])
  }
}
