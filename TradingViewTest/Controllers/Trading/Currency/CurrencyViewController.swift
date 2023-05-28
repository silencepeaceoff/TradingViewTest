//
//  CurrencyViewController.swift
//  TradingViewTest
//
//  Created by Dmitrii Tikhomirov on 5/21/23.
//

import UIKit

final class CurrencyViewController: UIViewController {

  var currencyPairSelected: ((String, String, String) -> Void)?

  private let tradeViewTitle: UILabel = {
    let titleView = UILabel()
    titleView.text = "Currency Pair"
    titleView.font = .interBold22
    titleView.textColor = .textWhite
    titleView.textAlignment = .center
    return titleView
  }()

  private lazy var currencyButtons: [CurrencyButton] = [
    CurrencyButton(with: "EUR / USD"),
    CurrencyButton(with: "EUR / RUB"),
    CurrencyButton(with: "EUR / CNY"),
    CurrencyButton(with: "EUR / GBP"),

    CurrencyButton(with: "USD / EUR"),
    CurrencyButton(with: "USD / RUB"),
    CurrencyButton(with: "USD / CNY"),
    CurrencyButton(with: "USD / GBP"),

    CurrencyButton(with: "GBP / EUR"),
    CurrencyButton(with: "GBP / RUB"),
    CurrencyButton(with: "GBP / CNY"),
    CurrencyButton(with: "GBP / USD"),

    CurrencyButton(with: "RUB / USD"),
    CurrencyButton(with: "RUB / EUR"),
    CurrencyButton(with: "RUB / GBP"),
    CurrencyButton(with: "RUB / CNY")
  ]

  override func viewDidLoad() {
    super.viewDidLoad()

    setupView()
    setupConstraints()
  }

  func setupView() {
    view.backgroundColor = .backgroundTradeView
    navigationItem.titleView = tradeViewTitle
    navigationController?.navigationBar.tintColor = .textWhite
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      image: .arrowBack, style: .plain, target: self, action: #selector(backButtonTapped)
    )

    currencyButtons.forEach { button in
      button.addTarget(self, action: #selector(currencyButtonTapped(_:)), for: .touchUpInside)
      view.addSubview(button)
    }
  }

  func setupConstraints() {
    currencyButtons.forEach { button in
      button.translatesAutoresizingMaskIntoConstraints = false
    }

    let padding = view.frame.width / 10
    let spacing = CGFloat(16)

    NSLayoutConstraint.activate([
      // Left column
      currencyButtons[0].topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
      currencyButtons[0].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      currencyButtons[0].heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08),
      currencyButtons[0].widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.37),

      currencyButtons[1].topAnchor.constraint(equalTo: currencyButtons[0].bottomAnchor, constant: spacing),
      currencyButtons[1].leadingAnchor.constraint(equalTo: currencyButtons[0].leadingAnchor),
      currencyButtons[1].heightAnchor.constraint(equalTo: currencyButtons[0].heightAnchor),
      currencyButtons[1].widthAnchor.constraint(equalTo: currencyButtons[0].widthAnchor),

      currencyButtons[2].topAnchor.constraint(equalTo: currencyButtons[1].bottomAnchor, constant: spacing),
      currencyButtons[2].leadingAnchor.constraint(equalTo: currencyButtons[0].leadingAnchor),
      currencyButtons[2].heightAnchor.constraint(equalTo: currencyButtons[0].heightAnchor),
      currencyButtons[2].widthAnchor.constraint(equalTo: currencyButtons[0].widthAnchor),

      currencyButtons[3].topAnchor.constraint(equalTo: currencyButtons[2].bottomAnchor, constant: spacing),
      currencyButtons[3].leadingAnchor.constraint(equalTo: currencyButtons[0].leadingAnchor),
      currencyButtons[3].heightAnchor.constraint(equalTo: currencyButtons[0].heightAnchor),
      currencyButtons[3].widthAnchor.constraint(equalTo: currencyButtons[0].widthAnchor),

      currencyButtons[4].topAnchor.constraint(equalTo: currencyButtons[3].bottomAnchor, constant: spacing),
      currencyButtons[4].leadingAnchor.constraint(equalTo: currencyButtons[0].leadingAnchor),
      currencyButtons[4].heightAnchor.constraint(equalTo: currencyButtons[0].heightAnchor),
      currencyButtons[4].widthAnchor.constraint(equalTo: currencyButtons[0].widthAnchor),

      currencyButtons[5].topAnchor.constraint(equalTo: currencyButtons[4].bottomAnchor, constant: spacing),
      currencyButtons[5].leadingAnchor.constraint(equalTo: currencyButtons[0].leadingAnchor),
      currencyButtons[5].heightAnchor.constraint(equalTo: currencyButtons[0].heightAnchor),
      currencyButtons[5].widthAnchor.constraint(equalTo: currencyButtons[0].widthAnchor),

      currencyButtons[6].topAnchor.constraint(equalTo: currencyButtons[5].bottomAnchor, constant: spacing),
      currencyButtons[6].leadingAnchor.constraint(equalTo: currencyButtons[0].leadingAnchor),
      currencyButtons[6].heightAnchor.constraint(equalTo: currencyButtons[0].heightAnchor),
      currencyButtons[6].widthAnchor.constraint(equalTo: currencyButtons[0].widthAnchor),

      currencyButtons[7].topAnchor.constraint(equalTo: currencyButtons[6].bottomAnchor, constant: spacing),
      currencyButtons[7].leadingAnchor.constraint(equalTo: currencyButtons[0].leadingAnchor),
      currencyButtons[7].heightAnchor.constraint(equalTo: currencyButtons[0].heightAnchor),
      currencyButtons[7].widthAnchor.constraint(equalTo: currencyButtons[0].widthAnchor),

      // Right column
      currencyButtons[8].topAnchor.constraint(equalTo: currencyButtons[0].topAnchor),
      currencyButtons[8].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      currencyButtons[8].heightAnchor.constraint(equalTo: currencyButtons[0].heightAnchor),
      currencyButtons[8].widthAnchor.constraint(equalTo: currencyButtons[0].widthAnchor),

      currencyButtons[9].topAnchor.constraint(equalTo: currencyButtons[8].bottomAnchor, constant: spacing),
      currencyButtons[9].trailingAnchor.constraint(equalTo: currencyButtons[8].trailingAnchor),
      currencyButtons[9].heightAnchor.constraint(equalTo: currencyButtons[0].heightAnchor),
      currencyButtons[9].widthAnchor.constraint(equalTo: currencyButtons[0].widthAnchor),

      currencyButtons[10].topAnchor.constraint(equalTo: currencyButtons[9].bottomAnchor, constant: spacing),
      currencyButtons[10].trailingAnchor.constraint(equalTo: currencyButtons[8].trailingAnchor),
      currencyButtons[10].heightAnchor.constraint(equalTo: currencyButtons[0].heightAnchor),
      currencyButtons[10].widthAnchor.constraint(equalTo: currencyButtons[0].widthAnchor),

      currencyButtons[11].topAnchor.constraint(equalTo: currencyButtons[10].bottomAnchor, constant: spacing),
      currencyButtons[11].trailingAnchor.constraint(equalTo: currencyButtons[8].trailingAnchor),
      currencyButtons[11].heightAnchor.constraint(equalTo: currencyButtons[0].heightAnchor),
      currencyButtons[11].widthAnchor.constraint(equalTo: currencyButtons[0].widthAnchor),

      currencyButtons[12].topAnchor.constraint(equalTo: currencyButtons[11].bottomAnchor, constant: spacing),
      currencyButtons[12].trailingAnchor.constraint(equalTo: currencyButtons[8].trailingAnchor),
      currencyButtons[12].heightAnchor.constraint(equalTo: currencyButtons[0].heightAnchor),
      currencyButtons[12].widthAnchor.constraint(equalTo: currencyButtons[0].widthAnchor),

      currencyButtons[13].topAnchor.constraint(equalTo: currencyButtons[12].bottomAnchor, constant: spacing),
      currencyButtons[13].trailingAnchor.constraint(equalTo: currencyButtons[8].trailingAnchor),
      currencyButtons[13].heightAnchor.constraint(equalTo: currencyButtons[0].heightAnchor),
      currencyButtons[13].widthAnchor.constraint(equalTo: currencyButtons[0].widthAnchor),

      currencyButtons[14].topAnchor.constraint(equalTo: currencyButtons[13].bottomAnchor, constant: spacing),
      currencyButtons[14].trailingAnchor.constraint(equalTo: currencyButtons[8].trailingAnchor),
      currencyButtons[14].heightAnchor.constraint(equalTo: currencyButtons[0].heightAnchor),
      currencyButtons[14].widthAnchor.constraint(equalTo: currencyButtons[0].widthAnchor),

      currencyButtons[15].topAnchor.constraint(equalTo: currencyButtons[14].bottomAnchor, constant: spacing),
      currencyButtons[15].trailingAnchor.constraint(equalTo: currencyButtons[8].trailingAnchor),
      currencyButtons[15].heightAnchor.constraint(equalTo: currencyButtons[0].heightAnchor),
      currencyButtons[15].widthAnchor.constraint(equalTo: currencyButtons[0].widthAnchor)
    ])
  }

  @objc func currencyButtonTapped(_ sender: CurrencyButton) {
    // Get the previously selected button
    if let previousButton = view.subviews.compactMap({ $0 as? CurrencyButton }).first(where: { $0.isSelected }) {
      // Deselect the previously selected button and change its color back to gray
      previousButton.isSelected = false
      previousButton.backgroundColor = .backgroundButton
    }

    // Change the color to green and mark the button as selected
    sender.isSelected = true
    sender.backgroundColor = .seaGreen3

    let currencyPair = sender.titleLabel?.text ?? ""
    let components = currencyPair.components(separatedBy: " / ")
    guard components.count == 2 else { return }
    let symbolFirst = components[0]
    let symbolSecond = components[1]
    let interval = "30"

    currencyPairSelected?(symbolFirst, symbolSecond, interval)
    navigationController?.popViewController(animated: true)
  }

  @objc func backButtonTapped() {
    navigationController?.popToRootViewController(animated: true)
  }
}
