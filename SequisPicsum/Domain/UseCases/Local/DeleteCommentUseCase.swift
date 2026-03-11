//
//  DeleteCommentUseCase.swift
//  SequisPicsum
//
//  Created by Adhitya Bagasmiwa Permana on 11/03/26.
//
//

import Foundation
import Combine

class DeleteCommentUseCase: BaseUseCase<Void, DeleteCommentRequest> {
    private let repository: CommentRepositoryProtocol
    
    init(repository: CommentRepositoryProtocol) {
        self.repository = repository
    }
    
    override func getData(request: DeleteCommentRequest?) -> AnyPublisher<Void, Error> {
        return repository.delete(commentId: request?.commentId ?? UUID(), imageId: request?.imageId ?? "")
    }
}
