//
//  ImageDetailViewModelTests.swift
//  SequisPicsumTests
//
//  Created by Adhitya Bagasmiwa Permana on 11/03/26.
//

import Testing
import Combine
import Foundation
import SwiftUI
@testable import SequisPicsum

@MainActor
struct ImageDetailViewModelTests {
    
    // MARK: - Helpers
    private func createSUT(
        image: ImagePicsum = ImagePicsum(id: "1", author: "Test Author"),
        coordinator: MockAppCoordinator? = nil,
        saveCommentUseCase: MockSaveCommentUseCase? = nil,
        getCommentsUseCase: MockGetCommentsUseCase? = nil,
        deleteCommentUseCase: MockDeleteCommentUseCase? = nil
    ) -> (
        sut: ImageDetailViewModel,
        coordinator: MockAppCoordinator,
        saveUseCase: MockSaveCommentUseCase,
        getUseCase: MockGetCommentsUseCase,
        deleteUseCase: MockDeleteCommentUseCase
    ) {
        let coordinator = coordinator ?? MockAppCoordinator()
        let saveUseCase = saveCommentUseCase ?? MockSaveCommentUseCase()
        let getUseCase = getCommentsUseCase ?? MockGetCommentsUseCase()
        let deleteUseCase = deleteCommentUseCase ?? MockDeleteCommentUseCase()
        
        let sut = ImageDetailViewModel(
            image: image,
            coordinator: coordinator,
            saveCommentUseCase: saveUseCase,
            getCommentsUseCase: getUseCase,
            deleteCommentUseCase: deleteUseCase
        )
        return (sut, coordinator, saveUseCase, getUseCase, deleteUseCase)
    }
    
    // MARK: - Tests
    @Test func test_init_initialState() async throws {
        let expectedImage = ImagePicsum(id: "1", author: "Test Author")
        let (sut, _, _, _, _) = createSUT(image: expectedImage)
        
        #expect(sut.image == expectedImage)
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage == nil)
        #expect(sut.comments.isEmpty)
    }
    
    @Test func test_getComments_success() async throws {
        // Given
        let (sut, _, _, getUseCase, _) = createSUT()
        let expectedComments = [
            UserComment(id: UUID(), imageId: "1", text: "Comment 1"),
            UserComment(id: UUID(), imageId: "1", text: "Comment 2")
        ]
        getUseCase.result = .success(expectedComments)
        
        // When
        sut.getComments()
        
        // Then
        #expect(sut.comments.count == 2)
        #expect(sut.comments[0].text == "Comment 1")
        #expect(sut.isLoading == false)
        #expect(getUseCase.executeCalledCount == 1)
        #expect(getUseCase.lastRequest?.imageId == "1")
    }
    
    @Test func test_getComments_failure() async throws {
        // Given
        let (sut, _, _, getUseCase, _) = createSUT()
        let expectedError = NSError(domain: "test", code: -1, userInfo: [NSLocalizedDescriptionKey: "fetch failed"])
        getUseCase.result = .failure(expectedError)
        
        // When
        sut.getComments()
        
        // Then
        #expect(sut.comments.isEmpty)
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage == "fetch failed")
    }
    
    @Test func test_addComment_success() async throws {
        // Given
        let (sut, _, saveUseCase, _, _) = createSUT()
        saveUseCase.result = .success(())
        
        // When
        sut.addComment()
        
        // Then
        #expect(sut.comments.count == 1)
        #expect(sut.errorMessage == nil)
        #expect(saveUseCase.executeCalledCount == 1)
        #expect(saveUseCase.lastRequest?.imageId == "1")
    }
    
    @Test func test_addComment_failure() async throws {
        // Given
        let (sut, _, saveUseCase, _, _) = createSUT()
        let expectedError = NSError(domain: "test", code: -1, userInfo: [NSLocalizedDescriptionKey: "save failed"])
        saveUseCase.result = .failure(expectedError)
        
        // When
        sut.addComment()
        
        // Then
        #expect(sut.errorMessage == "save failed")
        #expect(sut.comments.isEmpty)
    }
    
    @Test func test_deleteComment_success() async throws {
        // Given
        let (sut, _, _, _, deleteUseCase) = createSUT()
        let commentToDelete = UserComment(id: UUID(), imageId: "1", text: "To Delete")
        sut.comments = [commentToDelete]
        deleteUseCase.result = .success(())
        
        // When
        sut.deleteComment(comment: commentToDelete)
        
        // Then
        #expect(sut.comments.isEmpty)
        #expect(sut.errorMessage == nil)
        #expect(deleteUseCase.executeCalledCount == 1)
        #expect(deleteUseCase.lastRequest?.commentId == commentToDelete.id)
    }
    
    @Test func test_deleteComment_failure() async throws {
        // Given
        let (sut, _, _, _, deleteUseCase) = createSUT()
        let commentToDelete = UserComment(id: UUID(), imageId: "1", text: "To Delete")
        sut.comments = [commentToDelete]
        let expectedError = NSError(domain: "test", code: -1, userInfo: [NSLocalizedDescriptionKey: "delete failed"])
        deleteUseCase.result = .failure(expectedError)
        
        // When
        sut.deleteComment(comment: commentToDelete)
        
        // Then
        #expect(sut.comments.count == 1)
        #expect(sut.errorMessage == "delete failed")
    }
}
