//
//  Buy.swift
//  TradingViewTest
//
//  Created by Dmitrii Tikhomirov on 5/21/23.
//

import UIKit

final class BuyButton: UIButton {

  private let label: UILabel = {
    let label = UILabel()
    label.text = "Buy"
    label.font = .interMedium24
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

extension BuyButton {
  func setupView() {
    addSubview(label)
    backgroundColor = UIColor.seaGreen3
    layer.cornerRadius = 12.0
    clipsToBounds = true
    makeSystem(self)
  }

  func setupConstraints() {
    label.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
      label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
    ])
  }
}
