//
//  RoundForm.swift
//  TradingViewTest
//
//  Created by Dmitrii Tikhomirov on 5/19/23.
//

import UIKit

final class BalanceView: UIView {
  
  private let stackView: UIStackView = {
    let view = UIStackView()
    view.axis = .vertical
    view.alignment = .center
    view.distribution = .fillEqually
    return view
  }()

  private let topLabel: UILabel = {
    let label = UILabel()
    label.text = "Balance"
    label.font = .interMedium12
    label.textColor = .textSilver
    label.textAlignment = .center
    return label
  }()

  var balanceLabel: UILabel = {
    let label = UILabel()
    label.text = "10 000"
    label.font = .sfProText16
    label.textColor = .textWhite
    label.textAlignment = .center
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupView()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension BalanceView {
  func setupView() {
    addSubview(stackView)
    stackView.addArrangedSubview(topLabel)
    stackView.addArrangedSubview(balanceLabel)
    backgroundColor = UIColor.backgroundButton
    layer.cornerRadius = 12
    clipsToBounds = true
  }

  func setupConstraints() {
    stackView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      stackView.widthAnchor.constraint(equalTo: widthAnchor),
      stackView.heightAnchor.constraint(equalTo: heightAnchor)
    ])
  }

  func updateBalanceValue(_ value: String) {
    balanceLabel.text = value
    balanceLabel.setNeedsLayout()
    balanceLabel.layoutIfNeeded()
  }
}
