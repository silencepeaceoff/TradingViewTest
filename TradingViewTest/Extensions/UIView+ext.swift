//
//  UIView+ext.swift
//  TradingViewTest
//
//  Created by Dmitrii Tikhomirov on 5/18/23.
//

import UIKit

extension UIView {
  func addBottomBorder(with color: UIColor, width: CGFloat) {
    let separator = UIView()
    separator.backgroundColor = color
    separator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    separator.frame = CGRect(x: 0,
                             y: frame.height - width,
                             width: frame.width,
                             height: width)
    addSubview(separator)
  }

  func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: bounds,
                            byRoundingCorners: corners,
                            cornerRadii: CGSize(width: radius, height: radius))

    let borderLayer = CAShapeLayer()
    borderLayer.frame = bounds
    borderLayer.path = path.cgPath
    layer.mask = borderLayer
  }

  func makeSystem(_ button: UIButton) {
    button.addTarget(self, action: #selector(handleIn), for: [
      .touchDown,
      .touchDragInside
    ])

    button.addTarget(self, action: #selector(handleOut), for: [
      .touchDragOutside,
      .touchUpInside,
      .touchUpOutside,
      .touchDragExit,
      .touchCancel
    ])
  }

  @objc func handleIn() {
    UIView.animate(withDuration: 0.15, animations: { self.alpha = 0.55 })
  }

  @objc func handleOut() {
    UIView.animate(withDuration: 0.15, animations: { self.alpha = 1 })
  }
}
