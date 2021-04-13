//
//  CollectionViewCell1.swift
//  onboarding
//
//  Created by Anastasia Holovash on 2021-04-13.
//

import UIKit

final class CollectionViewCell3: UICollectionViewCell, BindableCell {
  
  struct  Props {
    let name: String
    let descriptionTest: String
    let image: UIImage
  }
  
  private let label = UILabel()
  private let categoryLabel = UILabel()
  private let imageView = UIImageView()
  private let getButton = UIButton()
  
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
    let horisontalStackView = UIStackView()
    horisontalStackView.axis = .horizontal
    horisontalStackView.spacing = 10
    addSubview(horisontalStackView, withEdgeInsets: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
    
    imageView.clipsToBounds = true
    imageView.rounded(10)
    imageView.backgroundColor = UIColor.orange
    
    label.textAlignment = .left
    label.font = .systemFont(ofSize: 20, weight: .light)

    categoryLabel.textAlignment = .left
    categoryLabel.font = .systemFont(ofSize: 13, weight: .light)
    categoryLabel.textColor = .secondaryLabel
    
    let getButtonLabel = UILabel()
    getButtonLabel.font = .systemFont(ofSize: 8, weight: .light)
    getButtonLabel.textColor = .secondaryLabel
    getButtonLabel.text = "In-App Purcheses"
    
    getButton.rounded(13)
    getButton.backgroundColor = .systemGray5
    getButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
    getButton.setTitleColor(.systemBlue, for: .normal)
    getButton.setTitle("GET", for: .normal)
    
    let buttonStackView = UIStackView(arrangedSubviews: [getButton, getButtonLabel, UIView()])
    buttonStackView.axis = .horizontal
    buttonStackView.spacing = 5
    
    let labelsStackView = UIStackView(arrangedSubviews: [label, categoryLabel, buttonStackView])
    labelsStackView.axis = .vertical
    labelsStackView.spacing = 2

    NSLayoutConstraint.activate([
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
      categoryLabel.heightAnchor.constraint(equalToConstant: 18),
      getButton.heightAnchor.constraint(equalToConstant: 26),
      getButton.widthAnchor.constraint(equalToConstant: 70)
    ])
    
    horisontalStackView.addArrangedSubview(imageView)
    horisontalStackView.addArrangedSubview(labelsStackView)
//    horisontalStackView.addArrangedSubview(buttonStackView)
  }
}

import SwiftUI
struct CollectionViewCell3Provider: PreviewProvider {
  static var previews: some View {
    Group {
      ViewRepresentable(CollectionViewCell3()) {
        $0.render(props: CollectionViewCell3.Props(name: "Some",
                                                   descriptionTest: "some description test",
                                                   image: UIImage()))
      }
      .previewLayout(.fixed(width: 327, height: 100))
    }
  }
}
