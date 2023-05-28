//
//  TimerInvestSellBuyView.swift
//  TradingViewTest
//
//  Created by Dmitrii Tikhomirov on 5/23/23.
//

import UIKit

final class TimerInvestSellBuyView: UIView {

  let currency = ChangeCurrencyButton(with: "EUR/USD")

  let timer = TimerView()
  let investment = InvestmentView()
  let sell = SellButton()
  let buy = BuyButton()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupView()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension TimerInvestSellBuyView {
  func setupView() {
    addSubview(currency)
    addSubview(timer)
    addSubview(investment)
    addSubview(sell)
    addSubview(buy)
  }

  func setupConstraints() {
    currency.translatesAutoresizingMaskIntoConstraints = false
    timer.translatesAutoresizingMaskIntoConstraints = false
    investment.translatesAutoresizingMaskIntoConstraints = false
    sell.translatesAutoresizingMaskIntoConstraints = false
    buy.translatesAutoresizingMaskIntoConstraints = false

    let spacing = CGFloat(10)
    let screenWidth = UIScreen.main.bounds.size.width
    let padding = (screenWidth - screenWidth * 0.84) / 2

    NSLayoutConstraint.activate([
      currency.topAnchor.constraint(equalTo: topAnchor, constant: spacing),
      currency.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      currency.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
      currency.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.257),

      timer.topAnchor.constraint(equalTo: currency.bottomAnchor, constant: spacing),
      timer.leadingAnchor.constraint(equalTo: currency.leadingAnchor),
      timer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.405),
      timer.heightAnchor.constraint(equalTo: currency.heightAnchor),

      investment.topAnchor.constraint(equalTo: currency.bottomAnchor, constant: spacing),
      investment.trailingAnchor.constraint(equalTo: currency.trailingAnchor),
      investment.widthAnchor.constraint(equalTo: timer.widthAnchor),
      investment.heightAnchor.constraint(equalTo: timer.heightAnchor),

      sell.topAnchor.constraint(equalTo: timer.bottomAnchor, constant: spacing),
      sell.leadingAnchor.constraint(equalTo: currency.leadingAnchor),
      sell.widthAnchor.constraint(equalTo: timer.widthAnchor),
      sell.heightAnchor.constraint(equalTo: timer.heightAnchor),

      buy.topAnchor.constraint(equalTo: investment.bottomAnchor, constant: spacing),
      buy.trailingAnchor.constraint(equalTo: currency.trailingAnchor),
      buy.widthAnchor.constraint(equalTo: timer.widthAnchor),
      buy.heightAnchor.constraint(equalTo: timer.heightAnchor),
    ])
  }
}
