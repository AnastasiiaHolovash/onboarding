//
//  MainNavigationController.swift
//  onboarding
//
//  Created by Anastasia Holovash on 2021-04-12.
//

import UIKit

final class MainNavigationController: UINavigationController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  func setup() {
//    view.backgroundColor = Asset.systemLight.color
//    setViewControllers([CalendarEventViewController()], animated: true)
//    navigationBar.barTintColor = Asset.systemLight.color
    
    setViewControllers([DistinctSectionsViewController()], animated: true)
  }
}
