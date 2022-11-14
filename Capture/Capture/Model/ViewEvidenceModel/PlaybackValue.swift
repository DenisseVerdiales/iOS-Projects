//
//  PlaybackValue.swift
//  Capture
//
//  Created by Consultant on 9/26/22.
//

import Foundation

struct PlaybackValue: Identifiable {
  let value: Double
  let label: String

  var id: String {
    return "\(label)-\(value)"
  }
}
