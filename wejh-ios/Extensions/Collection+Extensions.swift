//
//  Collection+Extensions.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/10.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//


extension Collection where Index == Int {
  func chunked(by chunkSize: Int) -> [[Element]] {
    stride(from: startIndex, to: endIndex, by: chunkSize).map {
      Array(self[$0..<Swift.min($0 + chunkSize, count)])
    }
  }
}
