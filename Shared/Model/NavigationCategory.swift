//
//  NavigationCategory.swift
//  Chimp
//
//  Created by Maximilian Gravemeyer on 13.11.20.
//

import Foundation

struct NavigationCategory: Identifiable, Hashable {
    let id = UUID()
    let symbol: String
    let name: String
    var notification: Int
}
