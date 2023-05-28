//
//  ViewController.swift
//  TradingViewTest
//
//  Created by Dmitrii Tikhomirov on 5/17/23.
//

import UIKit
import WebKit
import UserNotifications

final class TradingViewController: UIViewController {

  var webView: WKWebView!
  var activityIndicator: UIActivityIndicatorView!

  var timer: Timer?

  private let currencyVC = CurrencyViewController()
  private let balanceView = BalanceView()
  private let sellBuyView = TimerInvestSellBuyView()

  private let tradeViewTitle: UILabel = {
    let titleView = UILabel()
    titleView.text = "Trade"
    titleView.font = .interBold22
    titleView.textColor = .textWhite
    titleView.textAlignment = .center
    return titleView
  }()

  var time: TimeInterval = 0 {
    didSet {
      updateTimerLabel()
    }
  }

  var bill: Int = 0 {
    didSet {
      updateInvest()
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    currencyVC.currencyPairSelected = { [weak self] symbolFirst, symbolSecond, interval in
      guard let self = self else { return }

      sellBuyView.currency.label.text = "\(symbolFirst)/\(symbolSecond)"

      self.webView.stopLoading()
      self.loadHtml(with: symbolFirst + symbolSecond, and: interval)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    requestUserAuthorization()
    setupView()
    makeConstraints()
    setupKeyboardHiding()
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

}

extension TradingViewController {

  func setupView() {
    view.backgroundColor = UIColor.backgroundTradeView

    navigationItem.titleView = tradeViewTitle
    navigationController?.tabBarItem.title = "Trade"
    
    view.addSubview(balanceView)

    webView = WKWebView()
    webView.navigationDelegate = self
    webView.scrollView.bounces = false
    view.addSubview(webView)

    // Create and configure the activity indicator
    activityIndicator = UIActivityIndicatorView(style: .medium)
    activityIndicator.center = webView.center
    activityIndicator.hidesWhenStopped = true

    // Load the URL from htmlString
    loadHtml(with: "EURUSD", and: "30")

    view.addSubview(activityIndicator)

    sellBuyView.currency.addTarget(self, action: #selector(navigateToCurrencyViewController), for: .touchUpInside)

    view.addSubview(sellBuyView)

    // Tap gesture recognizer to dismiss the keyboard
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    view.addGestureRecognizer(tapGesture)

    sellBuyView.timer.timerTextField.delegate = self
    sellBuyView.investment.investTextField.delegate = self

    sellBuyView.timer.minusButton.addTarget(self, action: #selector(decrementTime), for: .touchUpInside)
    sellBuyView.timer.plusButton.addTarget(self, action: #selector(incrementTime), for: .touchUpInside)

    sellBuyView.investment.minusButton.addTarget(self, action: #selector(decrementBill), for: .touchUpInside)
    sellBuyView.investment.plusButton.addTarget(self, action: #selector(incrementBill), for: .touchUpInside)

    sellBuyView.sell.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
    sellBuyView.buy.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
  }

  func makeConstraints() {
    balanceView.translatesAutoresizingMaskIntoConstraints = false
    webView.translatesAutoresizingMaskIntoConstraints = false
    sellBuyView.translatesAutoresizingMaskIntoConstraints = false

    let spacing = CGFloat(10)

    NSLayoutConstraint.activate([
      balanceView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      balanceView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      balanceView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.84),
      balanceView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.086),


      webView.topAnchor.constraint(equalTo: balanceView.bottomAnchor, constant: spacing),
      webView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      webView.heightAnchor.constraint(equalTo: webView.widthAnchor, multiplier: 0.84),

      sellBuyView.topAnchor.constraint(equalTo: webView.bottomAnchor),
      sellBuyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      sellBuyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      sellBuyView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.28)
    ])
  }

  @objc func navigateToCurrencyViewController() {
    navigationController?.pushViewController(currencyVC, animated: true)
  }
}

//MARK: - Navigation WebView & HTML
extension TradingViewController: WKNavigationDelegate {

  func loadHtml(with symbol: String, and interval: String) {
    let htmlContent = Resources.HTMLContent.tradingViewWidget(symbol, interval)
    let modifiedHTMLString = htmlContent.getHTMLString()
    webView.loadHTMLString(modifiedHTMLString, baseURL: nil)
  }

  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    activityIndicator.startAnimating()
  }

  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    activityIndicator.stopAnimating()
  }

  func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    activityIndicator.stopAnimating()
    showAlert(with: "Error", message: error.localizedDescription)
  }

}

// MARK: - Timer Button Actions
extension TradingViewController {

  @objc private func decrementTime() {
    time -= 1
    updateTimerLabel()
  }

  @objc private func incrementTime() {
    time += 1
    updateTimerLabel()
  }

  private func updateTimerLabel() {
    if time >= 0 {
      let minutes = Int(time) / 60
      let seconds = Int(time) % 60
      let formattedTime = String(format: "%02d:%02d", minutes, seconds)
      sellBuyView.timer.timerTextField.text = formattedTime
    } else {
      time = 0
    }
  }

  // MARK: - Invest Button Actions
  @objc private func decrementBill() {
    bill -= 100
    updateInvest()
  }

  @objc private func incrementBill() {
    bill += 100
    updateInvest()
  }

  private func updateInvest() {
    guard let balance = Int(balanceView.balanceLabel.text?.replacingOccurrences(of: " ", with: "") ?? "0") else { return }

    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    numberFormatter.groupingSeparator = ","
    numberFormatter.usesGroupingSeparator = true

    if bill > balance {
      bill = balance
    } else if bill < 0 {
      bill = 0
    } else {
      guard let formattedString = numberFormatter.string(from: NSNumber(value: bill)) else { return }
      sellBuyView.investment.investTextField.text = "$" + formattedString
    }
  }

  @objc private func startTimer() {
    if bill > 0 {
      guard let balance = Int(balanceView.balanceLabel.text?.replacingOccurrences(of: " ", with: "") ?? "0")
      else { return }
      var result = ""
      if Bool.random() {
        result = "\(balance + Int(Double(bill) * 1.7))"
      } else {
        result = "\(balance - bill)"
      }
      balanceView.updateBalanceValue(result)
      bill = 0
      showAlert(with: "Operation Complete", message: "SuccessFully")
      if time > 0 {
        sellBuyView.sell.isEnabled = false
        sellBuyView.buy.isEnabled = false
        sellBuyView.timer.plusButton.isEnabled = false
        sellBuyView.timer.minusButton.isEnabled = false
        sellBuyView.timer.timerTextField.isEnabled = false
        sellBuyView.investment.minusButton.isEnabled = false
        sellBuyView.investment.plusButton.isEnabled = false
        sellBuyView.investment.investTextField.isEnabled = false

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
      }
    }
  }

  @objc private func updateTime() {
    if time > 0 {
      time -= 1
      updateTimerLabel()
    } else {
      time = 0
      timer?.invalidate()
      showAlert(with: "Timer Done", message: "Time is 00:00")
      sellBuyView.sell.isEnabled = true
      sellBuyView.buy.isEnabled = true
      sellBuyView.timer.plusButton.isEnabled = true
      sellBuyView.timer.minusButton.isEnabled = true
      sellBuyView.timer.timerTextField.isEnabled = true
      sellBuyView.investment.minusButton.isEnabled = true
      sellBuyView.investment.plusButton.isEnabled = true
      sellBuyView.investment.investTextField.isEnabled = true
    }
  }

}

//MARK: - Alerts
extension TradingViewController {

  func requestUserAuthorization() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
      if granted {
        // User granted authorization, you can now send notifications
        self.sendPushNotification()
      } else {
        // User denied authorization or there was an error
        print("Notification authorization denied or error occurred.")
      }
    }
  }

  func sendPushNotification() {
    let content = UNMutableNotificationContent()
    content.title = "Notification Title"
    content.body = "Notifications may include alerts, sounds, and icon badges. These can be configured in Settings."
    content.sound = .default

    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

    let request = UNNotificationRequest(identifier: "notificationIdentifier", content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request) { error in
      if let error = error {
        print("Error sending notification: \(error.localizedDescription)")
      } else {
        print("Notification sent successfully")
      }
    }
  }

  private func showAlert(with title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }

}

//MARK: - Keyboard
extension TradingViewController {

  // Register for keyboard notifications
  private func setupKeyboardHiding() {
    NotificationCenter.default.addObserver(
      self, selector: #selector(keyboardWillShow),
      name: UIResponder.keyboardWillShowNotification, object: nil
    )

    NotificationCenter.default.addObserver(
      self, selector: #selector(keyboardWillHide),
      name: UIResponder.keyboardWillHideNotification, object: nil
    )
  }

  @objc func keyboardWillShow(sender: NSNotification) {
    guard let userInfo = sender.userInfo,
          let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
//          let currentTextField = UIResponder.currentFirst() as? UITextField

    // Check if the top of keyboard is above the bottom of currently focused textbox
//    let keyboardTopY = keyboardFrame.cgRectValue.origin.y
//    let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
//    let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
    let sellBuyViewMaxY = sellBuyView.frame.maxY
    let viewHeight = view.frame.height
    let keyboardHeight = keyboardFrame.cgRectValue.height
    let visibleHeight = viewHeight - keyboardHeight

    // If textFieldBottomY is bellow keyboard bottom - bump the frame up
    if sellBuyViewMaxY > visibleHeight {
      let offset = sellBuyViewMaxY - visibleHeight
      UIView.animate(withDuration: 0.3) {
        self.sellBuyView.backgroundColor = UIColor.backgroundKeyboard
        self.sellBuyView.transform = CGAffineTransform(translationX: 0, y: -offset)
      }
    }
  }

  @objc func keyboardWillHide(sender: NSNotification) {
    guard let userInfo = sender.userInfo,
          let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

    let offset = sellBuyView.frame.maxY - (view.frame.height - keyboardFrame.cgRectValue.height)
    UIView.animate(withDuration: 0.3) {
      self.sellBuyView.transform = CGAffineTransform(translationX: 0, y: offset)
    }
  }

  @objc func dismissKeyboard() {
    view.endEditing(true)
  }

}

//MARK: - TextFieldDelegate
extension TradingViewController: UITextFieldDelegate {

//  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//    activeTextField = textField
//    return true
//  }
//
//  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//    activeTextField = nil
//    return true
//  }
//
//  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//    textField.resignFirstResponder()
//    return true
//  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    if textField === sellBuyView.timer.timerTextField {

      if let text = textField.text {
        let components = text.components(separatedBy: ":")
        if components.count == 2, let minutes = Int(components[0]), let seconds = Int(components[1]) {
          time = TimeInterval(minutes * 60 + seconds)
        }
      }

    } else if textField === sellBuyView.investment.investTextField {

      guard let string = textField.text else { return }
      bill = Int(string) ?? 0
    }
  }

  func textField(
    _ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

      if textField === sellBuyView.timer.timerTextField {
        textField.keyboardType = UIKeyboardType.numbersAndPunctuation
        let allowedCharacters = CharacterSet(charactersIn: "0123456789:")
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)

      } else if textField === sellBuyView.investment.investTextField {
        textField.keyboardType = UIKeyboardType.numberPad
        let allowedCharacters = CharacterSet(charactersIn: "$0123456789")
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
      }

      return true
    }
}
