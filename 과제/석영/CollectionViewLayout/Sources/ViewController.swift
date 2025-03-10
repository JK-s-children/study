//
//  ViewController.swift
//  CollectionViewLayout
//
//  Created by jung on 3/10/25.
//

import UIKit

final class ViewController: UIViewController {
  private let models: [CardPresentationModel] = [
    .init(id: UUID().uuidString, title: "1", color: .red),
    .init(id: UUID().uuidString, title: "2", color: .blue),
    .init(id: UUID().uuidString, title: "3", color: .brown),
    .init(id: UUID().uuidString, title: "4", color: .cyan),
    .init(id: UUID().uuidString, title: "5", color: .yellow),
    .init(id: UUID().uuidString, title: "6", color: .green),
    .init(id: UUID().uuidString, title: "7", color: .gray),
    .init(id: UUID().uuidString, title: "8", color: .magenta),
    .init(id: UUID().uuidString, title: "9", color: .orange),
    .init(id: UUID().uuidString, title: "10", color: .purple)
  ]
  
  // MARK: - UI Components
  private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CardCollectionViewLayout())
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.register(CardCell.self, forCellWithReuseIdentifier: "Cell")
    collectionView.dataSource = self
    
    configureUI()
  }
}

// MARK: - UI Methods
private extension ViewController {
  func configureUI() {
    view.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return models.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CardCell else {
      return UICollectionViewCell()
    }
    cell.configure(with: models[indexPath.row])
    return cell
  }
}
