//
//  ViewController.swift
//  onboarding
//
//  Created by Anastasia Holovash on 2021-04-12.
//

import UIKit

class CalendarEventViewController: UIViewController {
  
  let calendarEvent = CalendarEvent(name: "Breakfast Group Meal", start: Date(), end: Date(), asset: Asset.threePersonTemplate.image)
  let eventDescription = DescriptionView.Props(avatarImage: UIImage(named: "avatarImage") ?? UIImage(),
                                          userName: "Name Surname",
                                          userRole: "Therapist",
                                          meetingDescription: "Lorem ipsum! \nDolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.\nDolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.")
  
  let eventMembers = [Member(name: "Fhjknk kmjnkfn", image: UIImage(named: "avatarImage") ?? UIImage()),
                 Member(name: "Ymjnkfn", image: UIImage(named: "avatarImage") ?? UIImage()),
                 Member(name: "Fhjknk1", image: UIImage(named: "avatarImage") ?? UIImage()),
                 Member(name: "Ymjnkfn2", image: UIImage(named: "avatarImage") ?? UIImage()),
                 Member(name: "Fhjkndwcdsffsddfsk3", image: UIImage(named: "avatarImage") ?? UIImage()),
                 Member(name: "Foj kmjnkfn", image: UIImage(named: "avatarImage") ?? UIImage()),
  ]
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let mainView = CalendarEventView()
    mainView.render(props: CalendarEventView.Props(calendarEvent: calendarEvent,
                                                   description: eventDescription,
                                                   members: eventMembers))
    view = mainView
  }
}
