//
//  CollectionViewCell1.swift
//  onboarding
//
//  Created by Anastasia Holovash on 2021-04-13.
//

import UIKit

final class CollectionViewCell1: UICollectionViewCell, BindableCell {
  
  struct  Props {
    let name: String
    let descriptionTest: String
    let image: UIImage
  }
  
  private let label = UILabel()
  private let categoryLabel = UILabel()
  private let imageView = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = nil
    label.text = nil
  }
  
  func render(props: Props) {
    label.text = props.name
    categoryLabel.text = props.descriptionTest
    imageView.image = props.image
  }
  
  private func setup() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    label.translatesAutoresizingMaskIntoConstraints = false
    categoryLabel.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(imageView)
    contentView.addSubview(label)
    contentView.addSubview(categoryLabel)
    
    label.font = .systemFont(ofSize: 20, weight: .light)
    label.adjustsFontForContentSizeCategory = true
    
    categoryLabel.font = .systemFont(ofSize: 13, weight: .light)
    categoryLabel.adjustsFontForContentSizeCategory = true
    categoryLabel.textColor = .secondaryLabel
    
    imageView.layer.cornerRadius = 4
    imageView.backgroundColor = UIColor.orange
    
    let spacing: CGFloat = 10
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: contentView.topAnchor),
      label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      
      categoryLabel.topAnchor.constraint(equalTo: label.bottomAnchor),
      categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      imageView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: spacing),
      imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    ])
  }
}

import SwiftUI
struct CollectionViewCell1Provider: PreviewProvider {
  static var previews: some View {
    ViewRepresentable(CollectionViewCell1()) {
      $0.render(props: CollectionViewCell1.Props(name: "Some",
                                                 descriptionTest: "some description test",
                                                 image: UIImage()))
    }
    .previewLayout(.fixed(width: 327, height: 250))
  }
}
