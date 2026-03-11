//
//  GetCommentsUseCase.swift
//  SequisPicsum
//
//  Created by Adhitya Bagasmiwa Permana on 11/03/26.
//
//

import Foundation
import Combine

class GetCommentsUseCase: BaseUseCase<[UserComment], GetCommentsRequest> {
    private let repository: CommentRepositoryProtocol
    
    init(repository: CommentRepositoryProtocol) {
        self.repository = repository
    }
    
    override func getData(request: GetCommentsRequest?) -> AnyPublisher<[UserComment], Error> {
        return repository.getComments(imageId: request?.imageId ?? "")
    }
}
