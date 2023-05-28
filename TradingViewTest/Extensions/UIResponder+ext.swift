//
//  UIResponder+ext.swift
//  TradingViewTest
//
//  Created by Dmitrii Tikhomirov on 5/27/23.
//

import UIKit

extension UIResponder {

  private struct Static {
    static weak var responder: UIResponder?
  }

  /// Finds the current first responder
  /// - Returns: the current UIResponder if it exist
  static func currentFirst() -> UIResponder? {
    Static.responder = nil
    UIApplication.shared.sendAction(#selector(UIResponder.trap), to: nil, from: nil, for: nil)
    return Static.responder
  }

  @objc private func trap() {
    Static.responder = self
  }

}
