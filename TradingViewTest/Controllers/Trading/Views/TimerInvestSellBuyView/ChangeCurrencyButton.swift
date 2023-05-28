//
//  CurrencyView.swift
//  TradingViewTest
//
//  Created by Dmitrii Tikhomirov on 5/20/23.
//

import UIKit

final class ChangeCurrencyButton: UIButton {

  let label: UILabel = {
    let label = UILabel()
    label.font = .sfProText16
    label.textColor = .textWhite
    label.textAlignment = .center
    return label
  }()

  let arrow: UIImageView = {
    var view = UIImageView()
    view.image = .arrowLeft
    view.tintColor = .textWhite
    view.contentMode = .scaleAspectFit
    view.contentMode = .center
    view.clipsToBounds = true
    return view
  }()

  init(with text: String) {
    super.init(frame: .zero)

    setupView()
    label.text = text
    setupConstraints()
    makeSystem(self)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension ChangeCurrencyButton {
  func setupView() {
    addSubview(label)
    addSubview(arrow)
    backgroundColor = UIColor.backgroundButton
    layer.cornerRadius = 12
    clipsToBounds = true
  }

  func setupConstraints() {
    label.translatesAutoresizingMaskIntoConstraints = false
    arrow.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: centerXAnchor),
      label.centerYAnchor.constraint(equalTo: centerYAnchor),

      arrow.centerYAnchor.constraint(equalTo: centerYAnchor),
      arrow.centerXAnchor.constraint(equalTo: trailingAnchor, constant: -19)
    ])
  }
}
