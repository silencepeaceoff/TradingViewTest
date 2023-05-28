//
//  CurrencyButton.swift
//  TradingViewTest
//
//  Created by Dmitrii Tikhomirov on 5/21/23.
//
import UIKit

class CurrencyButton: UIButton {
  override var isSelected: Bool {
    didSet {
      backgroundColor = isSelected ? .seaGreen3 : .backgroundButton
    }
  }

  override var isHighlighted: Bool {
    didSet {
      backgroundColor = isSelected ? .seaGreen3 : .backgroundButton
    }
  }

  init(with title: String) {
    super.init(frame: .zero)

    setTitle(title, for: .normal)
    titleLabel?.font = UIFont.sfProtextSemibold14
    setTitleColor(.textWhite, for: .normal)
    backgroundColor = .backgroundButton

    layer.cornerRadius = 12
    clipsToBounds = true
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
