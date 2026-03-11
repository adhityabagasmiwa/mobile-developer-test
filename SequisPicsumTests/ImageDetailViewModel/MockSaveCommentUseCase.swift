//
//  MockSaveCommentUseCase.swift
//  SequisPicsumTests
//
//  Created by Adhitya Bagasmiwa Permana on 11/03/26.
//

import Combine
import Foundation
@testable import SequisPicsum

class MockSaveCommentUseCase: SaveCommentUseCase {
    var result: Result<Void, Error> = .success(())
    var executeCalledCount = 0
    var lastRequest: SaveCommentRequest?
    
    override init(repository: CommentRepositoryProtocol = MockCommentRepositoryImpl()) {
        super.init(repository: repository)
    }
    
    override func execute(request: SaveCommentRequest) -> AnyPublisher<Void, Error> {
        executeCalledCount += 1
        lastRequest = request
        return result.publisher.eraseToAnyPublisher()
    }
}
