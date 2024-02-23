//
//  HiziBiziApp.swift
//  HiziBizi
//
//  Created by Rakibul Nasib on 27/11/23.
//

import SwiftUI
import FirebaseCore

@main
struct HiziBiziApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
