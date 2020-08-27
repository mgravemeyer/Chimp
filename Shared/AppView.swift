//
//  ChimpAppView.swift
//  Chimp
//
//  Created by Maximilian Gravemeyer on 27.08.20.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        NavigationView {
            List {
                Text("Placeholder Section Header")
                Group {
                    NavigationLink(destination: TodayView()) {
                        Label("Today", systemImage: "scribble")
                    }
                    NavigationLink(destination: Text("Placeholder")) {
                        Label("Placeholder", systemImage: "scribble")
                    }
                }
                Spacer()
                Text("Placeholder Section Header 2")
                Group {
                    NavigationLink(destination: Text("Placeholder")) {
                        Label("Placeholder", systemImage: "scribble")
                    }
                    NavigationLink(destination: Text("Placeholder")) {
                        Label("Placeholder", systemImage: "scribble")
                    }
                }
            }
            TodayView()
            .listStyle(SidebarListStyle())
        }.toolbar {
            // FIXME: Adding toolbaritem {} to specifiy alignemtn. Doesnt work in Xcode-beta 5 and 6.
            Button(action: toggleSidebar) {
                Label("Collapse Sidebar", systemImage: "sidebar.left")
            }
        }
        // TODO: implement toolbar (not working with xcode beta 5)
        .frame(minWidth: 600, minHeight: 300)
    }
}

func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
}
