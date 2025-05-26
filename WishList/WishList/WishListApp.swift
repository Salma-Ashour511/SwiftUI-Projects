//
//  WishListApp.swift
//  WishList
//
//  Created by V17SAshour1 on 26/05/2025.
//

import SwiftUI
import SwiftData

@main
struct WishListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for:  Wish.self)
        }
    }
}
