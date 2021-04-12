//
//  CalendarEvent.swift
//  onboarding
//
//  Created by Anastasia Holovash on 2021-04-12.
//

import UIKit

struct CalendarEvent {
  let name: String
  let start: Date
  let end: Date
  let asset: UIImage
}

struct Member: Hashable {
  let name: String
  let image: UIImage
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(name)
  }
}
