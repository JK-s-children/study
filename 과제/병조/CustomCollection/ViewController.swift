//
//  ViewController.swift
//  CustomCollection
//
//  Created on 3/1/25.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: Model
    
    private let messageManager = MessageManager()
    private var messages = [Message]()
    
    // MARK: View
    
    private lazy var messageCollectionView = {
        let messageCollectionView = MessageCollectionView()
        messageCollectionView.dataSource = self
        messageCollectionView.delegate = self
        view.addSubview(messageCollectionView)
        return messageCollectionView
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupSubviewsLayout()
        setupDataStream()
        messageManager.requestMessages()
    }
    
    // MARK: Data Stream
    
    private var messageTask: Task<Void, Never>?
    
    private func setupDataStream() {
        messageTask = Task {
            for await newMessages in messageManager.messagesStream {
                messages.append(contentsOf: newMessages)
                messageCollectionView.append(contentsOf: newMessages)
            }
        }
    }
}

// MARK: - MessageCollectionViewDataSource conformance

extension ViewController: MessageCollectionViewDataSource {
    func numberOfMessage(_ messageCollectionView: MessageCollectionView) -> Int {
        messages.count
    }
    
    func messageCollectionView(
        _ messageCollectionView: MessageCollectionView,
        messageAt indexPath: IndexPath
    ) -> Message {
        messages[indexPath.row]
    }
}

// MARK: - MessageCollectionViewDelegate conformance

extension ViewController: MessageCollectionViewDelegate {
    func messageCollectionView(
        _ messageCollectionView: MessageCollectionView,
        didReachAppendablePoint offset: CGPoint
    ) {
        messageManager.requestMessages()
    }
}

// MARK: - Layout

fileprivate extension ViewController {
    func setupSubviewsLayout() {
        messageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            messageCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            messageCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            messageCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}
