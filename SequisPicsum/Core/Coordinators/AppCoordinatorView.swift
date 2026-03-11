//
//  AppCoordinatorView.swift
//  SequisPicsum
//
//  Created by Adhitya Bagasmiwa Permana on 10/03/26.
//

import SwiftUI

struct AppCoordinatorView: View {
    @StateObject private var coordinator = AppCoordinator()
    private let container: DependencyContainerProtocol
    
    @State private var showSplash = true
    
    init(container: DependencyContainerProtocol) {
        self.container = container
    }
    
    var body: some View {
        Group {
            if showSplash {
                SplashView()
                    .transition(.opacity)
            } else {
                NavigationStack(path: $coordinator.path) {
                    build(.imageList)
                        .navigationDestination(for: AppRoute.self) { build($0) }
                }
                .environmentObject(coordinator)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    showSplash = false
                }
            }
        }
    }
    
    @ViewBuilder
    func build(_ route: AppRoute) -> some View {
        switch route {
        case .splash:
            SplashView()
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
