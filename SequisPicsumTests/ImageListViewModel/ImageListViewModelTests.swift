//
//  ImageListViewModelTests.swift
//  SequisPicsumTests
//
//  Created by Adhitya Bagasmiwa Permana on 11/03/26.
//

import Testing
import Combine
import Foundation
@testable import SequisPicsum

@MainActor
struct ImageListViewModelTests {
    
    // MARK: - Tests
    @Test func test_init_initialState() async throws {
        let coordinator = MockAppCoordinator()
        let useCase = MockGetImagesPicsumUseCase()
        let sut = ImageListViewModel(coordinator: coordinator, getImagesUseCase: useCase)
        
        #expect(sut.images.isEmpty)
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage == nil)
    }
    
    @Test func test_getImages_success() async throws {
        // Given
        let coordinator = MockAppCoordinator()
        let useCase = MockGetImagesPicsumUseCase()
        let expectedImages = [
            ImagePicsum(id: "1", author: "Author 1"),
            ImagePicsum(id: "2", author: "Author 2")
        ]
        useCase.result = .success(expectedImages)
        let sut = ImageListViewModel(coordinator: coordinator, getImagesUseCase: useCase)
        
        // When
        sut.getImages()
        
        // Then
        #expect(sut.images == expectedImages)
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage == nil)
        #expect(useCase.executeCalledCount == 1)
        #expect(useCase.lastRequest?.page == 1)
    }
    
    @Test func test_getImages_failure() async throws {
        // Given
        let coordinator = MockAppCoordinator()
        let useCase = MockGetImagesPicsumUseCase()
        let expectedError = NSError(domain: "test", code: -1, userInfo: [NSLocalizedDescriptionKey: "fetch failed"])
        useCase.result = .failure(expectedError)
        let sut = ImageListViewModel(coordinator: coordinator, getImagesUseCase: useCase)
        
        // When
        sut.getImages()
        
        // Then
        #expect(sut.images.isEmpty)
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage == "fetch failed")
    }
    
    @Test func test_getImages_pagination() async throws {
        // Given
        let coordinator = MockAppCoordinator()
        let useCase = MockGetImagesPicsumUseCase()
        let sut = ImageListViewModel(coordinator: coordinator, getImagesUseCase: useCase)
        
        // First call
        useCase.result = .success([ImagePicsum(id: "1")])
        sut.getImages()
        #expect(sut.images.count == 1)
        #expect(useCase.lastRequest?.page == 1)
        
        // Second call (Pagination)
        useCase.result = .success([ImagePicsum(id: "2")])
        sut.getImages()
        
        // Then
        #expect(sut.images.count == 2)
        #expect(useCase.lastRequest?.page == 2)
    }
    
    @Test func test_getImages_refresh() async throws {
        // Given
        let coordinator = MockAppCoordinator()
        let useCase = MockGetImagesPicsumUseCase()
        let sut = ImageListViewModel(coordinator: coordinator, getImagesUseCase: useCase)
        
        // Load some images first
        useCase.result = .success([ImagePicsum(id: "1")])
        sut.getImages()
        #expect(sut.images.count == 1)
        
        // When refresh
        let refreshedImages = [ImagePicsum(id: "refreshed")]
        useCase.result = .success(refreshedImages)
        sut.getImages(isRefresh: true)
        
        // Then
        #expect(sut.images == refreshedImages)
        #expect(useCase.lastRequest?.page == 1)
    }
    
    @Test func test_navigateToDetail() async throws {
        // Given
        let coordinator = MockAppCoordinator()
        let useCase = MockGetImagesPicsumUseCase()
        let sut = ImageListViewModel(coordinator: coordinator, getImagesUseCase: useCase)
        let selectedImage = ImagePicsum(id: "1", author: "Test Author")
        
        // When
        sut.navigateToDetail(image: selectedImage)
        
        // Then
        if case .imageDetail(let image) = coordinator.pushedRoute {
            #expect(image == selectedImage)
        } else {
            Issue.record("Expected navigation to imageDetail")
        }
    }
}
