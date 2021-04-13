//
//  MemberCollectionViewCell.swift
//  onboarding
//
//  Created by Anastasia Holovash on 2021-04-12.
//

import UIKit

final class MemberCollectionViewCell: UICollectionViewCell, BindableCell {
  
  static func calculateCollectionHeight(with members: [Member], width: CGFloat) -> CGFloat {
    
    print(width)

    var currentWidth: CGFloat = 0.0
    
    return members.reduce(members.count > 0 ? 40.0 : 0) {
      let value = $1.name.width(with: 40, font: UIFont.systemFont(ofSize: 15, weight: .bold)) + 40 + 8
      currentWidth += value
      print("currentWidth: \(currentWidth), value: \(value)")
      if currentWidth + 10 >= width {
        currentWidth = value
        print("+50")
        return $0 + 50
      }
      return $0
    }
  }
  
  private let label = UILabel()
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
  
  func render(props: Member) {
    label.text = props.name
    imageView.image = props.image
  }
  
  private func setup() {
    backgroundColor = Asset.systemLight.color
    
    let memberStackView = UIStackView()
    memberStackView.axis = .horizontal
    memberStackView.spacing = 8
    
    imageView.clipsToBounds = true
    imageView.rounded(20)
    imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
    
    label.textAlignment = .left
    label.textColor = Asset.mainNightBlue.color
    label.font = .systemFont(ofSize: 15, weight: .bold)
    
    memberStackView.addArrangedSubview(imageView)
    memberStackView.addArrangedSubview(label)
    
    contentView.addSubview(memberStackView, withEdgeInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
  }
}
