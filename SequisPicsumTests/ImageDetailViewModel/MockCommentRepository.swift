//
//  MockCommentRepository.swift
//  SequisPicsumTests
//
//  Created by Adhitya Bagasmiwa Permana on 11/03/26.
//

import Combine
import Foundation
@testable import SequisPicsum

class MockCommentRepositoryImpl: CommentRepositoryProtocol {
    var saveResult: Result<Void, Error> = .success(())
    var getCommentsResult: Result<[UserComment], Error> = .success([])
    var deleteResult: Result<Void, Error> = .success(())
    
    var saveCalledCount = 0
    var getCommentsCalledCount = 0
    var deleteCalledCount = 0
    
    var lastSaveRequest: SaveCommentRequest?
    var lastGetCommentsImageId: String?
    var lastDeleteCommentId: UUID?
    var lastDeleteImageId: String?
    
    func save(to comment: SaveCommentRequest) -> AnyPublisher<Void, Error> {
        saveCalledCount += 1
        lastSaveRequest = comment
        return saveResult.publisher.eraseToAnyPublisher()
    }
    
    func getComments(imageId: String) -> AnyPublisher<[UserComment], Error> {
        getCommentsCalledCount += 1
        lastGetCommentsImageId = imageId
        return getCommentsResult.publisher.eraseToAnyPublisher()
    }
    
    func delete(commentId: UUID, imageId: String) -> AnyPublisher<Void, Error> {
        deleteCalledCount += 1
        lastDeleteCommentId = commentId
        lastDeleteImageId = imageId
        return deleteResult.publisher.eraseToAnyPublisher()
    }
}
