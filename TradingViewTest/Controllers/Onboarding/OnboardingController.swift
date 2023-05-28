//
//  OnboardingController.swift
//  TradingViewTest
//
//  Created by Dmitrii Tikhomirov on 5/17/23.
//

import UIKit

final class OnboardingViewController: UIViewController {

  private let background = Background()

  private var progressBar: UIProgressView = {
    let view = UIProgressView()
    // Corner radius for progress view
    view.layer.cornerRadius = 12
    view.clipsToBounds = true
    // Corner radius for inner view
    view.layer.sublayers![1].cornerRadius = 12
    view.subviews[1].clipsToBounds = true
    // Colors
    view.layer.backgroundColor = UIColor.progressbarBackground.cgColor
    view.progressTintColor = UIColor.progressbarTintColor
    return view
  }()

  private var percentLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.text = "0%"
    label.font = .interExtraBold16
    label.textColor = .textWhite
    label.textAlignment = .center
    return label
  }()

  private var timer: Timer?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    startLoading()
  }

  private func setupUI() {
    view.addSubview(background)
    background.translatesAutoresizingMaskIntoConstraints = false

    // Add progress bar
    progressBar.translatesAutoresizingMaskIntoConstraints = false
    percentLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(progressBar)
    view.addSubview(percentLabel)

    NSLayoutConstraint.activate([
      background.topAnchor.constraint(equalTo: view.topAnchor),
      background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      background.trailingAnchor.constraint(equalTo: view.trailingAnchor),

      progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      progressBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      progressBar.heightAnchor.constraint(equalToConstant: 24),
      progressBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),

      percentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      percentLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }

  private func startLoading() {
    var progress: Float = 0
    timer = Timer.scheduledTimer(withTimeInterval: 0.0005,
                                 repeats: true) { [weak self] timer in
      guard let self = self else { return }

      progress += 0.0005
      self.percentLabel.text = "\(Int(progress * 100))%"
      self.progressBar.setProgress(progress, animated: true)

      if progress >= 1.0 {
        timer.invalidate()
        self.finishLoading()
      }
    }
  }

  private func finishLoading() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
      let tabBarController = TabBarController()
      tabBarController.modalPresentationStyle = .fullScreen
      self?.present(tabBarController, animated: true)
    }
  }
}
