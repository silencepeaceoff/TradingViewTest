//
//  Background.swift
//  TradingViewTest
//
//  Created by Dmitrii Tikhomirov on 5/17/23.
//

import UIKit
import CoreImage

final class Background: UIView {

  private let backgroundView: UIImageView = {
    let iconView = UIImageView()
    iconView.image = UIImage.backgroundImage
    iconView.clipsToBounds = true
    iconView.contentMode = .scaleToFill
    return iconView
  }()

  private let blurEffectView: UIVisualEffectView = {
    let blurEffect = UIBlurEffect(style: .systemChromeMaterialDark)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    return blurEffectView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension Background {

  func setupView() {
    addSubview(backgroundView)
    addSubview(blurEffectView)

    backgroundView.translatesAutoresizingMaskIntoConstraints = false
    blurEffectView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      backgroundView.topAnchor.constraint(equalTo: topAnchor),
      backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
      backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
      backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),

      blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
      blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
      blurEffectView.topAnchor.constraint(equalTo: topAnchor),
      blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

//  func applyBlur(withRadius radius: CGFloat, to image: UIImage) -> UIImage? {
//      guard let ciImage = CIImage(image: image) else {
//          return nil
//      }
//
//      let filter = CIFilter(name: "CIGaussianBlur")
//      filter?.setValue(ciImage, forKey: kCIInputImageKey)
//      filter?.setValue(radius, forKey: kCIInputRadiusKey)
//
//      guard let outputCIImage = filter?.outputImage else {
//          return nil
//      }
//
//      let context = CIContext(options: nil)
//      guard let outputCGImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else {
//          return nil
//      }
//
//      let outputImage = UIImage(cgImage: outputCGImage)
//      return outputImage
//  }
}
