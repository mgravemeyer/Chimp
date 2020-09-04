//
//  Contact.swift
//  Chimp
//
//  Created by Maximilian Gravemeyer on 02.09.20.
//

import Foundation

struct Contact: Identifiable, Hashable {
    internal let id = UUID()
    private(set) var firstname: String
    private(set) var lastname: String
}
