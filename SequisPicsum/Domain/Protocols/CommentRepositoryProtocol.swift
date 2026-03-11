//
//  CommentRepositoryProtocol.swift
//  SequisPicsum
//
//  Created by Adhitya Bagasmiwa Permana on 11/03/26.
//

import Foundation
import Combine

protocol CommentRepositoryProtocol: AnyObject {
    func save(to comment: SaveCommentRequest) -> AnyPublisher<Void, Error>
    func getComments(imageId: String) -> AnyPublisher<[UserComment], Error>
    func delete(commentId: UUID, imageId: String) -> AnyPublisher<Void, Error>
}
