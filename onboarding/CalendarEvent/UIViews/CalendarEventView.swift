//
//  CalendarEventView.swift
//  onboarding
//
//  Created by Anastasia Holovash on 2021-04-13.
//

import UIKit

final class CalendarEventView: UIView {
  
  struct Props {
    let calendarEvent: CalendarEvent
    let description: DescriptionView.Props
    let members: [Member]
  }
  
  private let eventNameStackView = UIStackView()
  private let descriptionView = DescriptionView()
  private let informationView = InformationView()
  private let stackView = UIStackView()
  private let eventNameLabel = UILabel()
  private let joinCallButton = UIButton()
  private let layerView = UIView()
  
  private lazy var dataSource = makeDataSource()
  private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
  private var members: [Member] = []
  private var collectionViewHeight: NSLayoutConstraint?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
    setupCollectionView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    layerView.setGradientBackground(colorTop: UIColor.white.withAlphaComponent(0),
                                    colorBottom: Asset.systemLight.color)
    
    print(rect)
    let heightValue = MemberCollectionViewCell.calculateCollectionHeight(with: members, width: rect.width - 48)
    print("height:", heightValue)
    
    collectionViewHeight?.constant = heightValue
    collectionViewHeight?.isActive = true
  }
  
  func render(props: Props) {
    eventNameLabel.text = props.calendarEvent.name
    descriptionView.render(props: props.description)
    members = props.members
    dataSource.applyItems(members)
  }
  
  private func setupUI() {
    backgroundColor = Asset.systemLight.color
    setupScrollView()
    setupEventName()
    setupJoinCallButton()
    
    stackView.addArrangedSubview(descriptionView)
    stackView.addArrangedSubview(collectionView)
    stackView.addArrangedSubview(informationView)
    
    let emptyView = UIView()
    emptyView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    stackView.addArrangedSubview(emptyView)
  }
  
  private func setupScrollView() {
    let scrollView = UIScrollView()
    scrollView.backgroundColor = .clear
    scrollView.showsVerticalScrollIndicator = false
    scrollView.alwaysBounceVertical = false
    
    addSubview(scrollView, constraints: [
      scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
      scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
      scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])

    scrollView.addSubview(stackView, withEdgeInsets: .zero)
    stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.spacing = 24
  }
  
  private func setupEventName() {
    eventNameStackView.axis = .horizontal
    eventNameStackView.spacing = 16
    
    let imageStackView =  UIStackView()
    imageStackView.axis = .vertical
    let threePersonTemplateImageView = UIImageView(image: Asset.threePersonTemplate.image)
    threePersonTemplateImageView.contentMode = .scaleAspectFit
    threePersonTemplateImageView.tintColor = Asset.mainNightBlue.color
    threePersonTemplateImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
    threePersonTemplateImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
    let topEmptyView = UIView()
    topEmptyView.heightAnchor.constraint(equalToConstant: 3).isActive = true
    imageStackView.addArrangedSubview(topEmptyView)
    imageStackView.addArrangedSubview(threePersonTemplateImageView)
    imageStackView.addArrangedSubview(UIView())
    
    eventNameLabel.textColor = Asset.mainNightBlue.color
    eventNameLabel.textAlignment = .left
    eventNameLabel.numberOfLines = 0
    eventNameLabel.font = .systemFont(ofSize: 32, weight: .bold)
    
    eventNameStackView.addArrangedSubview(imageStackView)
    eventNameStackView.addArrangedSubview(eventNameLabel)
    stackView.addArrangedSubview(eventNameStackView)
  }
  
  private func setupJoinCallButton() {
    addSubview(layerView, constraints: [
      layerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      layerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      layerView.bottomAnchor.constraint(equalTo: bottomAnchor),
      layerView.heightAnchor.constraint(equalToConstant: 180)
    ])
    layerView.isUserInteractionEnabled = false
    
    joinCallButton.backgroundColor = Asset.mainSage.color
    joinCallButton.setTitleColor(Asset.systemLight.color, for: .normal)
    joinCallButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
    joinCallButton.setTitle("Join group call", for: .normal)
    joinCallButton.rounded(32)
    addSubview(joinCallButton, constraints: [
      joinCallButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
      joinCallButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
      joinCallButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 6),
      joinCallButton.heightAnchor.constraint(equalToConstant: 64)
    ])
  }
  
  private func setupCollectionView() {
    collectionView.backgroundColor = Asset.systemLight.color
    collectionView.register(cell: MemberCollectionViewCell.self)
    collectionViewHeight = collectionView.heightAnchor.constraint(equalToConstant: 0)
  }
  
  private func createLayout() -> UICollectionViewFlowLayout {
    let layout = LeftAlignmentFlowLayout()
    layout.estimatedItemSize = CGSize(width: 100, height: 40)
    layout.scrollDirection = .vertical
    return layout
  }
  
  private func makeDataSource() -> UICollectionViewDiffableDataSource<SingleSection, Member> {
    UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: MemberCollectionViewCell.cellProvider)
  }
}
