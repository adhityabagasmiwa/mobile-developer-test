//
//  SaveCommentUseCase.swift
//  SequisPicsum
//
//  Created by Adhitya Bagasmiwa Permana on 11/03/26.
//
//

import Foundation
import Combine

class SaveCommentUseCase: BaseUseCase<Void, SaveCommentRequest> {
    private let repository: CommentRepositoryProtocol
    
    init(repository: CommentRepositoryProtocol) {
        self.repository = repository
    }
    
    override func getData(request: SaveCommentRequest?) -> AnyPublisher<Void, Error> {
        return repository.save(to: request ?? SaveCommentRequest())
    }
}
