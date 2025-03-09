//
//  MessageCollectionViewCell.swift
//  CustomCollection
//
//  Created on 3/7/25.
//

import UIKit

final class MessageCollectionViewCell: UICollectionViewCell {
    
    // MARK: Static value
    
    static let identifier = "\(MessageCollectionViewCell.self)"
    
    // MARK: Subviews
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        contentView.addSubview(label)
        return label
    }()
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviewsLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupSubviewsLayout()
    }
    
    // MARK: Configuration
    
    func configure(with message: Message) {
        contentView.backgroundColor = UIColor(message.backgroundColor)
        label.text = message.content
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        contentView.backgroundColor = .systemBackground
        label.text?.removeAll()
    }
}

// MARK: - Layout

fileprivate extension MessageCollectionViewCell {
    func setupSubviewsLayout() {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.padding),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metrics.padding),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.padding),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.padding),
        ])
    }
    
    enum Metrics {
        static let padding = 5.0
    }
}
