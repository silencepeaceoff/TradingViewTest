//
//  Timer.swift
//  TradingViewTest
//
//  Created by Dmitrii Tikhomirov on 5/20/23.
//

import UIKit

final class TimerView: UIView {
  
  private let stackView: UIStackView = {
    let view = UIStackView()
    view.axis = .vertical
    view.alignment = .center
    view.distribution = .fillEqually
    return view
  }()

  private let timerTitle: UILabel = {
    let label = UILabel()
    label.text = "Timer"
    label.font = .interMedium12
    label.textColor = .textSilver
    label.textAlignment = .center
    return label
  }()

  let timerTextField: UITextField = {
    let field = UITextField()
    field.text = "00:00"
    field.font = .sfProText16
    field.textColor = .textWhite
    field.textAlignment = .center
    field.keyboardType = .numberPad
    return field
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

extension TimerView {
  func setupView() {
    addSubview(stackView)
    stackView.addArrangedSubview(timerTitle)
    stackView.addArrangedSubview(timerTextField)
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

      plusButton.centerYAnchor.constraint(equalTo: timerTextField.centerYAnchor),
      plusButton.centerXAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -19),

      minusButton.centerYAnchor.constraint(equalTo: timerTextField.centerYAnchor),
      minusButton.centerXAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 19)
    ])
  }
}
