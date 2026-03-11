//
//  SplashViewModel.swift
//  SequisPicsum
//
//  Created by Adhitya Bagasmiwa Permana on 11/03/26.
//

import Foundation
import Combine

class SplashViewModel: ObservableObject {
    @Published var isFinished = false
    
    func start() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.isFinished = true
        }
    }
}
