//
//  DependencyContainer.swift
//  SequisPicsum
//
//  Created by Adhitya Bagasmiwa Permana on 10/03/26.
//

import Foundation
import Moya

protocol DependencyContainerProtocol: AnyObject {
    var getImagesPicsumUseCase: GetImagesPicsumUseCase { get }
    var saveCommentsUseCase: SaveCommentUseCase { get }
    var getCommentsUseCase: GetCommentsUseCase { get }
    var deleteCommentUseCase: DeleteCommentUseCase { get }
}

final class DependencyContainer: DependencyContainerProtocol {
    private let imagesPicsumProvider = MoyaProvider<ImagePicsumAPI>()
    private let context = CoreDataStack.shared.context

    // MARK: Data Layer
    private lazy var imagesPicsumRepository: ImagePicsumRepositoryProtocol = {
        ImagePicsumRepositoryImpl(provider: imagesPicsumProvider)
    }()
    private lazy var commentRepository: CommentRepositoryProtocol = {
        CommentRepositoryImpl(context: context)
    }()
    
    // MARK: Domain Layer
    var getImagesPicsumUseCase: GetImagesPicsumUseCase {
        GetImagesPicsumUseCase(repository: imagesPicsumRepository)
    }
    var saveCommentsUseCase: SaveCommentUseCase {
        SaveCommentUseCase(repository: commentRepository)
    }
    var getCommentsUseCase: GetCommentsUseCase {
        GetCommentsUseCase(repository: commentRepository)
    }
    var deleteCommentUseCase: DeleteCommentUseCase {
        DeleteCommentUseCase(repository: commentRepository)
    }
}
