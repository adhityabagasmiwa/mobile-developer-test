//
//  AppCoordinatorView.swift
//  SequisPicsum
//
//  Created by Adhitya Bagasmiwa Permana on 10/03/26.
//

import SwiftUI

struct AppCoordinatorView: View {
    @StateObject private var coordinator = AppCoordinator()
    @StateObject private var splashViewModel = SplashViewModel()
    private let container: DependencyContainerProtocol
    
    init(container: DependencyContainerProtocol) {
        self.container = container
    }
    
    var body: some View {
        Group {
            if !splashViewModel.isFinished {
                SplashView(viewModel: splashViewModel)
                    .transition(.opacity)
            } else {
                NavigationStack(path: $coordinator.path) {
                    build(.imageList)
                        .navigationDestination(for: AppRoute.self) { build($0) }
                }
                .environmentObject(coordinator)
            }
        }
    }
    
    @ViewBuilder
    func build(_ route: AppRoute) -> some View {
        switch route {
        case .splash:
            SplashView(viewModel: splashViewModel)
        case .imageList:
            ImageListView(
                viewModel: ImageListViewModel(
                    coordinator: coordinator,
                    getImagesUseCase: container.getImagesPicsumUseCase
                )
            )
        case .imageDetail(let image):
            ImageDetailView(
                viewModel: ImageDetailViewModel(
                    image: image,
                    coordinator: coordinator,
                    saveCommentUseCase: container.saveCommentsUseCase,
                    getCommentsUseCase: container.getCommentsUseCase,
                    deleteCommentUseCase: container.deleteCommentUseCase
                )
            )
        }
    }
}
