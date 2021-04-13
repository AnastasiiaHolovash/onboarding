//
//  DescriptionView.swift
//  onboarding
//
//  Created by Anastasia Holovash on 2021-04-12.
//

import UIKit

final class DescriptionView: UIView {
  
  struct Props {
    let avatarImage: UIImage
    let userName: String
    let userRole: String
    let meetingDescription: String
  }
  
  private let mainStackView = UIStackView()
  private let eventMemberStackView = UIStackView()
  private let avatarImageView = UIImageView()
  private let nameLabel = UILabel()
  private let roleLabel = UILabel()
  private let descriptionLabel = UILabel()
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonSetup()
  }
  
  func render(props: Props) {
    avatarImageView.image = props.avatarImage
    nameLabel.text = props.userName
    roleLabel.text = props.userRole
    descriptionLabel.text = props.meetingDescription
  }
  
  private func commonSetup() {
    backgroundColor = .white
    rounded(16)
    setupMainStackView()
    setupEventMemberStack()
    setupAvatarImageView()
    setupLabelsStackView()
    setupDescriptionLabel()
  }
  
  private func setupMainStackView() {
    mainStackView.axis = .vertical
    mainStackView.spacing = 24
    
    addSubview(mainStackView, withEdgeInsets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
  }
  
  private func setupEventMemberStack() {
    eventMemberStackView.axis = .horizontal
    eventMemberStackView.spacing = 8
    
    mainStackView.addArrangedSubview(eventMemberStackView)
  }
  
  private func setupAvatarImageView() {
    avatarImageView.clipsToBounds = true
    avatarImageView.rounded(20)
    avatarImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    avatarImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
    
    eventMemberStackView.addArrangedSubview(avatarImageView)
  }
  
  private func setupLabelsStackView() {
    nameLabel.textAlignment = .left
    nameLabel.textColor = Asset.mainNightBlue.color
    nameLabel.font = .systemFont(ofSize: 15, weight: .bold)
    nameLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
    
    roleLabel.textColor = Asset.mainNightBlue.color
    roleLabel.textAlignment = .left
    roleLabel.font = .systemFont(ofSize: 12, weight: .regular)
    
    let labelsStackView = UIStackView(arrangedSubviews: [nameLabel, roleLabel])
    labelsStackView.axis = .vertical
    labelsStackView.spacing = 2
    
    eventMemberStackView.addArrangedSubview(labelsStackView)
  }
  
  private func setupDescriptionLabel() {
    descriptionLabel.textColor = Asset.mainNightBlue.color
    descriptionLabel.textAlignment = .left
    descriptionLabel.numberOfLines = 0
    descriptionLabel.font = .systemFont(ofSize: 17, weight: .regular)
        
    mainStackView.addArrangedSubview(descriptionLabel)
  }
}

import SwiftUI
struct DescriptionViewProvider: PreviewProvider {
  static var previews: some View {
    ViewRepresentable(DescriptionView()) {
      $0.render(props: DescriptionView.Props(avatarImage: UIImage(named: "avatarImage") ?? UIImage(),
                                             userName: "Name Surname",
                                             userRole: "Therapist",
                                             meetingDescription: "Lorem ipsum! \nDolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor."))
    }
    .previewLayout(.fixed(width: 327, height: 168))
  }
}

