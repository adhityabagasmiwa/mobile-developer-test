//
//  SequisPicsumApp.swift
//  SequisPicsum
//
//  Created by Adhitya Bagasmiwa Permana on 10/03/26.
//

import SwiftUI

@main
struct SequisPicsumApp: App {
    private let container = DependencyContainer()
    
    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(container: container)
        }
    }
}
