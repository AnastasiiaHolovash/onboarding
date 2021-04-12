//
//  UICollectionViewDiffableDataSourceExtensions.swift
//  Wendy
//
//  Created by Volodymyr Bondar on 02.02.2021.
//  Copyright © 2021 Uptech Team. All rights reserved.
//

import UIKit

extension UICollectionViewDiffableDataSource where SectionIdentifierType == SingleSection {
  func applyItems(_ items: [ItemIdentifierType], completion: (() -> Void)? = nil) {
    var snapshot = NSDiffableDataSourceSnapshot<SingleSection, ItemIdentifierType>()
    snapshot.appendSections([.main])
    snapshot.appendItems(items, toSection: .main)
    apply(snapshot, completion: completion)
  }
}
