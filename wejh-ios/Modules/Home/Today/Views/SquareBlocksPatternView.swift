//
//  SquareBlocksPatternView.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/9.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import UIKit

class SquareBlocksPatternView: UIView {

  struct Configuration {

    var blockWidth: CGFloat
    var minimumGutterWidth: CGFloat
    var cornerRadius: CGFloat
    var emptyBlockRatio: Double
    var colors: [UIColor]
    var highlightedAlpha: CGFloat
    var dimmedAlpha: CGFloat
    var highlightRateRange: (Double, Double)
    var maskAlphaRange: [CGFloat]

    static let `default` = {
      return Configuration(blockWidth: 12,
          minimumGutterWidth: 2,
          cornerRadius: 2,
          emptyBlockRatio: 0.5,
          colors: [
            UIColor(displayP3Red: 0.20, green: 0.32, blue: 0.62, alpha: 1.00),
            UIColor(displayP3Red: 0.48, green: 0.68, blue: 0.88, alpha: 1.00),
            UIColor(displayP3Red: 0.35, green: 0.44, blue: 0.63, alpha: 1.00)],
          highlightedAlpha: 0.2,
          dimmedAlpha: 0.05,
          highlightRateRange: (0.15, 0.6),
          maskAlphaRange: [0.0, 1.0])
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

    let rowCount = Int(Double((size.height + config.minimumGutterWidth) / (config.blockWidth + config.minimumGutterWidth)).rounded(.up))
    let columnCount = Int(Double((size.width + config.minimumGutterWidth) / (config.blockWidth + config.minimumGutterWidth)).rounded(.up))
    let gutterWidthH = (size.width - CGFloat(columnCount) * config.blockWidth) / CGFloat(columnCount - 1)
    let gutterWidthV = (size.height - CGFloat(rowCount) * config.blockWidth) / CGFloat(rowCount - 1)
    let gutterWidth = min(gutterWidthH, gutterWidthV)

    let blockWidthWithGutter = config.blockWidth + gutterWidth

    for row in 0..<rowCount {
      let currentHighlightedRate = config.highlightRateRange.0 + (config.highlightRateRange.1 - config.highlightRateRange.0) / Double(rowCount) * Double(row)

      for column in 0..<columnCount {
        guard let color = config.colors.randomElement() else {
          return
        }

        let isClear = Double.random(in: 0..<1) < config.emptyBlockRatio
        if isClear {
          continue
        }

        let isHighlighted = Double.random(in: 0..<1) < currentHighlightedRate

        let calculatedAlpha = isHighlighted ? config.highlightedAlpha : config.dimmedAlpha
        let colorWithAlpha = color.withAlphaComponent(calculatedAlpha)
        colorWithAlpha.setFill()

        let rect = CGRect(x: blockWidthWithGutter * CGFloat(column), y: blockWidthWithGutter * CGFloat(row), width: config.blockWidth, height: config.blockWidth)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize(width: config.cornerRadius, height: config.cornerRadius))
        path.fill()
      }
    }
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    maskLayer.frame = bounds
  }

}
