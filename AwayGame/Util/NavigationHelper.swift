//
//  NavigationHelper.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/10/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

func setupNavigation(controller: UINavigationController?, hidesBar: Bool) {
    guard let navigation = controller?.navigationBar else { return }
    controller?.isNavigationBarHidden = hidesBar
    navigation.tintColor = Theme.Color.white
    navigation.titleTextAttributes = [NSAttributedStringKey.font : Theme.Font.title, NSAttributedStringKey.foregroundColor : Theme.Color.white]
    navigation.isTranslucent = true
    navigation.barTintColor = Theme.Color.Green.primary
}
