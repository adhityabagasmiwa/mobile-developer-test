//
//  MockDeleteCommentUseCase.swift
//  SequisPicsumTests
//
//  Created by Adhitya Bagasmiwa Permana on 11/03/26.
//

import Combine
import Foundation
@testable import SequisPicsum

class MockDeleteCommentUseCase: DeleteCommentUseCase {
    var result: Result<Void, Error> = .success(())
    var executeCalledCount = 0
    var lastRequest: DeleteCommentRequest?
    
    override init(repository: CommentRepositoryProtocol = MockCommentRepositoryImpl()) {
        super.init(repository: repository)
    }
    
    override func execute(request: DeleteCommentRequest) -> AnyPublisher<Void, Error> {
        executeCalledCount += 1
        lastRequest = request
        return result.publisher.eraseToAnyPublisher()
    }
}
