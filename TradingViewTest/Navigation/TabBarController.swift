//
//  Tab.swift
//  TradingViewTest
//
//  Created by Dmitrii Tikhomirov on 5/18/23.
//

import UIKit

enum Tabs: Int, CaseIterable {
  case trade
  case top
}

var selectedTab: Int = 0

final class TabBarController: UITabBarController {

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    configureAppearance()
    switchTo(tab: .trade)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func switchTo(tab: Tabs) {
    selectedIndex = tab.rawValue
  }

  private func configureAppearance() {
    tabBar.backgroundColor = .backgroundNavBar
    tabBar.tintColor = UIColor.seaGreen3
    tabBar.barTintColor = UIColor.icon_slate_gray
    tabBar.layer.borderColor = UIColor.separator.cgColor
    tabBar.layer.borderWidth = 1
    tabBar.layer.masksToBounds = true

    let tradeController = TradingViewController()
    let topController = TopViewController()

    tradeController.tabBarItem = UITabBarItem(title: "Trade",
                                              image: UIImage.tradeIcon,
                                              tag: Tabs.trade.rawValue)

    selectedTab = 0

    let tradeNavigation = NavBarController(rootViewController: tradeController)

    topController.tabBarItem = UITabBarItem(title: "Top",
                                            image: UIImage.topIcon,
                                            tag: Tabs.top.rawValue)
    selectedTab = 1

    let topNavigation = NavBarController(rootViewController: topController)



    setViewControllers([
      tradeNavigation, topNavigation
    ], animated: false)
  }

}
