//
//  MockAppCoordinator.swift
//  SequisPicsumTests
//
//  Created by Adhitya Bagasmiwa Permana on 11/03/26.
//

import Testing
@testable import SequisPicsum

class MockAppCoordinator: AppCoordinator {
    var pushedRoute: AppRoute?
    
    override func push(_ route: AppRoute) {
        pushedRoute = route
        super.push(route)
    }
}
