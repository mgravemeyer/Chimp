//
//  Contact.swift
//  Chimp
//
//  Created by Maximilian Gravemeyer on 02.09.20.
//

import Foundation

struct Contact: Identifiable, Hashable {
    internal let id = UUID()
    private(set) var name: String
}
