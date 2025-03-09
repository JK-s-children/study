//
//  MessageCollectionView.swift
//  CustomCollection
//
//  Created on 3/4/25.
//

import UIKit

@MainActor
protocol MessageCollectionViewDataSource: AnyObject {
    func numberOfMessage(_ messageCollectionView: MessageCollectionView) -> Int
    func messageCollectionView(
        _ messageCollectionView: MessageCollectionView,
        messageAt indexPath: IndexPath
    ) -> Message
}

@MainActor
protocol MessageCollectionViewDelegate: AnyObject {
    func messageCollectionView(_ messageCollectionView: MessageCollectionView, didReachAppendablePoint offset: CGPoint)
}

final class MessageCollectionView: UIView {
    
    // MARK: Property
    
    private var lastContentSize = CGSize.zero
    
    // MARK: Subviews
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: messageCollectionViewLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            MessageCollectionViewCell.self,
            forCellWithReuseIdentifier: MessageCollectionViewCell.identifier
        )
        addSubview(collectionView)
        return collectionView
    }()
    private let messageCollectionViewLayout = MessageCollectionViewLayout()
    
    // MARK: DataSource & Delegate
    
    weak var dataSource: MessageCollectionViewDataSource?
    weak var delegate: MessageCollectionViewDelegate?
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviewsLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupSubviewsLayout()
    }
    
    // MARK: Update data source
    
    func append(contentsOf messages: [Message]) {
        messageCollectionViewLayout.append(contentsOf: messages)
    }
}

// MARK: - UICollectionViewDataSource conformance

extension MessageCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource?.numberOfMessage(self) ?? .zero
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let message = dataSource?.messageCollectionView(self, messageAt: indexPath),
              let messageCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MessageCollectionViewCell.identifier,
                for: indexPath
              ) as? MessageCollectionViewCell
        else { return UICollectionViewCell() }
        
        messageCell.configure(with: message)
        return messageCell
    }
}

// MARK: - UICollectionViewDelegate conformance

extension MessageCollectionView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset
        let appendingOffsetY = scrollView.contentSize.height * Numerics.appendingRatio - scrollView.bounds.height
        
        let didReachAppendingOffsetY = appendingOffsetY <= currentOffset.y
        let isScrollingDown = scrollView.panGestureRecognizer.translation(in: scrollView).y < .zero
        let didContentSizeIncreased = lastContentSize.height < scrollView.contentSize.height
        
        if didReachAppendingOffsetY, isScrollingDown, didContentSizeIncreased {
            lastContentSize = scrollView.contentSize
            delegate?.messageCollectionView(self, didReachAppendablePoint: currentOffset)
        }
    }
    
    private enum Numerics {
        static let appendingRatio = 0.9
    }
}

// MARK: - Layout

fileprivate extension MessageCollectionView {
    func setupSubviewsLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
