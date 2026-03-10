//
//  ImageListViewModel.swift
//  SequisPicsum
//
//  Created by Adhitya Bagasmiwa Permana on 10/03/26.
//

import Foundation
import Combine
 
class ImageListViewModel: ObservableObject {
    @Published var images: [ImagePicsum] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var currentPage: Int = 1
    private var canLoadMore: Bool = true
    private var cancellables: Set<AnyCancellable> = []
    
    private let coordinator: AppCoordinator
    private let getImagesUseCase: GetImagesPicsumUseCase
    
    init(coordinator: AppCoordinator, getImagesUseCase: GetImagesPicsumUseCase) {
        self.coordinator = coordinator
        self.getImagesUseCase = getImagesUseCase
    }
}

extension ImageListViewModel {
    private func resetPagination() {
        currentPage = 1
        images = []
        canLoadMore = true
        errorMessage = nil
    }
    
    func getImages(isRefresh: Bool = false) {
        if isRefresh { resetPagination() }
        
        guard !isLoading && canLoadMore else { return }
        isLoading = true
        
        let request = GetImagesRequest(page: currentPage, limit: 10)
        
        getImagesUseCase.execute(request: request)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] domainImages in
                if domainImages.isEmpty {
                    self?.canLoadMore = false
                } else {
                    self?.images.append(contentsOf: domainImages)
                    self?.currentPage += 1
                }
            }
            .store(in: &cancellables)
    }
}
