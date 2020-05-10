//
//  DotsPatternView.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/10.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import UIKit

class DotsPatternView: UIView {

  struct Configuration {

    var dotsPerArea: (Double, Double)
    var colors: [UIColor]
    var radiusRange: (CGFloat, CGFloat)
    var maskAlphaRange: [CGFloat]

    static let `default` = {
      return Configuration(dotsPerArea: (0.001, 0.0015), colors: [
        UIColor(displayP3Red: 0.98, green: 0.85, blue: 0.43, alpha: 0.4),
        UIColor(displayP3Red: 0.56, green: 0.89, blue: 0.89, alpha: 0.4),
        UIColor(displayP3Red: 0.90, green: 0.53, blue: 0.69, alpha: 0.4)
      ], radiusRange: (3.0, 6.0), maskAlphaRange: [0.0, 1.0])
    }()

  }

  private let config: Configuration
  private let maskLayer = CAGradientLayer()

  init(frame: CGRect, configuration: Configuration) {
    self.config = configuration
    super.init(frame: frame)
    setupMaskLayer()
  }

  required init?(coder: NSCoder) {
    self.config = Configuration.default
    super.init(coder: coder)
    setupMaskLayer()
  }

  private func setupMaskLayer() {
    maskLayer.colors = config.maskAlphaRange.map {
      UIColor.black.withAlphaComponent($0).cgColor
    }
    layer.mask = maskLayer
  }

  override func draw(_ rect: CGRect) {
    let size = bounds.size

    let area: Double = Double(size.width) * Double(size.height)
    let dotsCountRange = (Int(Double(config.dotsPerArea.0 * area).rounded()), Int(Double(config.dotsPerArea.1 * area).rounded()))

    let dotCount = Int.random(in: dotsCountRange.0...dotsCountRange.1)

    for _ in 0..<dotCount {
      guard let color = config.colors.randomElement() else {
        return
      }
      color.setFill()

      let center = CGPoint(x: CGFloat.random(in: 0...size.width), y: CGFloat.random(in: 0...size.height))
      let radius = CGFloat.random(in: config.radiusRange.0...config.radiusRange.1)

      let dotPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
      dotPath.fill()
    }
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    maskLayer.frame = bounds
    setNeedsDisplay()
  }

}
