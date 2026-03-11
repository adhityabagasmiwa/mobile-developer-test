//
//  MockGetCommentsUseCase.swift
//  SequisPicsumTests
//
//  Created by Adhitya Bagasmiwa Permana on 11/03/26.
//

import Combine
import Foundation
@testable import SequisPicsum

class MockGetCommentsUseCase: GetCommentsUseCase {
    var result: Result<[UserComment], Error> = .success([])
    var executeCalledCount = 0
    var lastRequest: GetCommentsRequest?
    
    override init(repository: CommentRepositoryProtocol = MockCommentRepositoryImpl()) {
        super.init(repository: repository)
    }
    
    override func execute(request: GetCommentsRequest) -> AnyPublisher<[UserComment], Error> {
        executeCalledCount += 1
        lastRequest = request
        return result.publisher.eraseToAnyPublisher()
    }
}
