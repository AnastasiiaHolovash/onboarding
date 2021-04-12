//
//  ViewController.swift
//  onboarding
//
//  Created by Anastasia Holovash on 2021-04-12.
//

import UIKit

class CalendarEventViewController: UIViewController {
  
  private let descriptionView = DescriptionView()
  private let eventNameLabel = UILabel()
  private lazy var dataSource = makeDataSource()
  private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())

  var height: NSLayoutConstraint?
  let members = [Member(name: "Fhjknk kmjnkfn", image: UIImage(named: "avatarImage") ?? UIImage()),
                 Member(name: "Ymjnkfn", image: UIImage(named: "avatarImage") ?? UIImage()),
                 Member(name: "Fhjknk1", image: UIImage(named: "avatarImage") ?? UIImage()),
                 Member(name: "Ymjnkfn2", image: UIImage(named: "avatarImage") ?? UIImage()),
                 Member(name: "Fhjkndwcdsffsddfsk3", image: UIImage(named: "avatarImage") ?? UIImage()),
                 Member(name: "Foj kmjnkfn", image: UIImage(named: "avatarImage") ?? UIImage()),
]

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    setupCollectionView()
    eventNameLabel.text = "Breakfast Group Meal"
    dataSource.applyItems(members)

  }


  private func setupUI() {
    view.backgroundColor = Asset.systemLight.color
    
    let eventNameStackView = UIStackView()
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
    
    descriptionView.render(props: DescriptionView.Props(avatarImage: UIImage(named: "avatarImage") ?? UIImage(),
                                                        userName: "Name Surname",
                                                        userRole: "Therapist",
                                                        meetingDescription: "Lorem ipsum! \nDolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.\nDolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor."))
    
    view.addSubview(eventNameStackView, constraints: [
      eventNameStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      eventNameStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
      eventNameStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
    ])
    view.addSubview(descriptionView, constraints: [
      descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
      descriptionView.topAnchor.constraint(equalTo: eventNameStackView.bottomAnchor, constant: 24),
    ])
  }
  
  private func setupCollectionView() {
    collectionView.backgroundColor = Asset.systemLight.color

    collectionView.register(cell: MemberCollectionViewCell.self)    

    
    view.addSubview(collectionView, constraints: [
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
      collectionView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 24),
    ])
    
    let heightValue = MemberCollectionViewCell.calculateCollectionHeight(with: members, width: view.frame.width - 48)
    print("height:", heightValue)
    height = collectionView.heightAnchor.constraint(equalToConstant: heightValue)
    height?.isActive = true
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
