//
//  Bindable.swift
//  Wendy
//
//  Created by Volodymyr Bondar on 02.02.2021.
//  Copyright © 2021 Uptech Team. All rights reserved.
//

protocol Bindable {
  associatedtype Props

  func render(props: Props)
}
