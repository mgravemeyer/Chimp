//
//  Reducer.swift
//  Chimp
//
//  Created by Maximilian Gravemeyer on 02.09.20.
//

import Foundation
import Combine
import SwiftUI

class AppState: ObservableObject {
    @Published var contactsState = ContactsState()
}
