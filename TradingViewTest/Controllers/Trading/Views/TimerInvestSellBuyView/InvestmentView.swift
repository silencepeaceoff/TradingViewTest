//
//  Investment.swift
//  TradingViewTest
//
//  Created by Dmitrii Tikhomirov on 5/20/23.
//

import UIKit

final class InvestmentView: UIView {

  private let stackView: UIStackView = {
    let view = UIStackView()
    view.axis = .vertical
    view.alignment = .center
    view.distribution = .fillEqually
    return view
  }()

  private let investTitle: UILabel = {
    let label = UILabel()
    label.text = "Investment"
    label.font = .interMedium12
    label.textColor = .textSilver
    label.textAlignment = .center
    return label
  }()

  let investTextField: UITextField = {
    let label = UITextField()
    label.text = "$0"
    label.font = .sfProText16
    label.textColor = .textWhite
    label.textAlignment = .center
    label.keyboardType = .numberPad
    return label
  }()

  let plusButton: UIButton = {
    var button = UIButton()
    button.setImage(UIImage.circlePlus, for: .normal)
    button.tintColor = .textSilver
    button.contentMode = .scaleAspectFit
    button.contentMode = .center
    button.clipsToBounds = true
    return button
  }()

  let minusButton: UIButton = {
    var button = UIButton()
    button.setImage(UIImage.circleMinus, for: .normal)
    button.tintColor = .textSilver
    button.contentMode = .scaleAspectFit
    button.contentMode = .center
    button.clipsToBounds = true
    return button
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

extension InvestmentView {
  func setupView() {
    addSubview(stackView)
    stackView.addArrangedSubview(investTitle)
    stackView.addArrangedSubview(investTextField)
    addSubview(plusButton)
    addSubview(minusButton)
    backgroundColor = UIColor.backgroundButton
    layer.cornerRadius = 12
    clipsToBounds = true
  }

  func setupConstraints() {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    plusButton.translatesAutoresizingMaskIntoConstraints = false
    minusButton.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      stackView.widthAnchor.constraint(equalTo: widthAnchor),
      stackView.heightAnchor.constraint(equalTo: heightAnchor),

      plusButton.centerYAnchor.constraint(equalTo: investTextField.centerYAnchor),
      plusButton.centerXAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -19),

      minusButton.centerYAnchor.constraint(equalTo: investTextField.centerYAnchor),
      minusButton.centerXAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 19)
    ])
  }
}
