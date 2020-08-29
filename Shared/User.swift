//
//  User.swift
//  Chimp (iOS)
//
//  Created by Maximilian Gravemeyer on 29.08.20.
//

import Foundation
import Combine

struct User: Identifiable {
    let id = UUID()
    var email: String
    var password: String
}
