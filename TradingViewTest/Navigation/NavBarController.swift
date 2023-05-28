//
//  NavBarController.swift
//  TradingViewTest
//
//  Created by Dmitrii Tikhomirov on 5/18/23.
//

import UIKit

final class NavBarController: UINavigationController {

  override func viewDidLoad() {
    super.viewDidLoad()

    configure()
  }
  
  private func configure() {
    if selectedTab == 0 {
      view.backgroundColor = .backgroundTradeView
      
    } else {
      view.backgroundColor = .backgroundTopView
      
    }
    navigationBar.isTranslucent = false
    navigationBar.standardAppearance.titleTextAttributes = [
      .foregroundColor: UIColor.icon_slate_gray,
      .font: UIFont.nunitosans_semibold_10
    ]

//    navigationBar.addBottomBorder(with: UIColor.separator, width: 1)
  }
}
