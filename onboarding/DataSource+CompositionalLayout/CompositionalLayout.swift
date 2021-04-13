//
//  CompositionalLayout.swift
//  onboarding
//
//  Created by Anastasia Holovash on 2021-04-13.
//

import UIKit

class DistinctSectionsViewController: UIViewController {
  
  enum SectionLayoutKind: Int, CaseIterable {
    case grig, list3, list5
  }
  
  private var dataSource: UICollectionViewDiffableDataSource<SectionLayoutKind, Int>?
  private lazy var collectionView: UICollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureHierarchy()
    configureDataSource()
  }
}

extension DistinctSectionsViewController {
  func createLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                        layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      
      guard let sectionLayoutKind = SectionLayoutKind(rawValue: sectionIndex) else {
        return nil
      }
      let section: NSCollectionLayoutSection
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                            heightDimension: .fractionalHeight(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.96), heightDimension: .fractionalWidth(0.6))
      let group: NSCollectionLayoutGroup
      
      switch sectionLayoutKind {
      case .grig:
        group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
      case .list3:
        group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
      case .list5:
        group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 2)
      }
      section = NSCollectionLayoutSection(group: group)
      section.interGroupSpacing = 10
      section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
      section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
      return section
    }
    return layout
  }
}

extension DistinctSectionsViewController {
  func configureHierarchy() {
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.backgroundColor = .systemBackground
    view.addSubview(collectionView)
    collectionView.delegate = self
  }
  
  func configureDataSource() {
    
    let collectionViewCell1 = UICollectionView.CellRegistration<CollectionViewCell1, Int> { (cell, indexPath, identifier) in
      cell.render(props: CollectionViewCell1.Props(name: "Name\(identifier)",
                                                   descriptionTest: "Some description test \(identifier)",
                                                   image: UIImage()))
    }
    let collectionViewCell2 = UICollectionView.CellRegistration<CollectionViewCell2, Int> { (cell, indexPath, identifier) in
      cell.render(props: CollectionViewCell2.Props(name: "Name\(identifier)",
                                                   descriptionTest: "Some description test \(identifier)",
                                                   image: UIImage()))
    }
    let collectionViewCell3 = UICollectionView.CellRegistration<CollectionViewCell3, Int> { (cell, indexPath, identifier) in
      cell.render(props: CollectionViewCell3.Props(name: "Name\(identifier)",
                                                   descriptionTest: "Some description test \(identifier)",
                                                   image: UIImage()))
    }
    dataSource = UICollectionViewDiffableDataSource<SectionLayoutKind, Int>(collectionView: collectionView) {
      (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
      switch SectionLayoutKind(rawValue: indexPath.section)! {
      case .grig:
        return collectionView.dequeueConfiguredReusableCell(using: collectionViewCell1, for: indexPath, item: identifier)
      case .list3:
        return collectionView.dequeueConfiguredReusableCell(using: collectionViewCell2, for: indexPath, item: identifier)
      case .list5:
        return collectionView.dequeueConfiguredReusableCell(using: collectionViewCell3, for: indexPath, item: identifier)
      }
    }
    
    // initial data
    let itemsPerSection = 12
    var snapshot = NSDiffableDataSourceSnapshot<SectionLayoutKind, Int>()
    SectionLayoutKind.allCases.forEach {
      snapshot.appendSections([$0])
      let itemOffset = $0.rawValue * itemsPerSection
      let itemUpperbound = itemOffset + itemsPerSection
      snapshot.appendItems(Array(itemOffset..<itemUpperbound))
    }
    dataSource?.apply(snapshot, animatingDifferences: false)
  }
}

extension DistinctSectionsViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
  }
}
