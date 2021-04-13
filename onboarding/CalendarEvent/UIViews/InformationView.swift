//
//  InformationView.swift
//  onboarding
//
//  Created by Anastasia Holovash on 2021-04-13.
//

import UIKit

final class InformationView: UIView {
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonSetup()
  }
  
  private func commonSetup() {
    backgroundColor = Asset.systemLightGray.color
    rounded(16)
    setupMainStackView()
  }
  
  private func setupMainStackView() {
    let mainStackView = UIStackView()
    mainStackView.axis = .vertical
    mainStackView.spacing = 24
    
    addSubview(mainStackView, withEdgeInsets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
    
    [
      ("Ask everything you want",
       "Make all the necessary preparations so that the food was ready before the meeting."),
      ("Turn on your frontal camera",
       "Position your smartphone so that you and your food are visible.")
    ].forEach { (title: String, text: String) in
      let vStack = UIStackView()
      vStack.axis = .vertical
      vStack.spacing = 8
      vStack.alignment = .leading
      
      let titleLabel = UILabel()
      titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
      titleLabel.textColor = Asset.mainNightBlue.color
      titleLabel.text = title
      
      let textLabel = UILabel()
      textLabel.numberOfLines = 0
      textLabel.font = .systemFont(ofSize: 15, weight: .regular)
      textLabel.textColor = Asset.systemDarkGray.color
      textLabel.text = text
      
      vStack.addArrangedSubview(titleLabel)
      vStack.addArrangedSubview(textLabel)
      mainStackView.addArrangedSubview(vStack)
    }
  }
}

import SwiftUI
struct InformationViewProvider: PreviewProvider {
  static var previews: some View {
    ViewRepresentable(InformationView())
    .previewLayout(.fixed(width: 327, height: 202))
  }
}

