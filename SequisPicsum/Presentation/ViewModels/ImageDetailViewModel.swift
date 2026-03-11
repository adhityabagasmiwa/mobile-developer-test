//
//  ImageDetailViewModel.swift
//  SequisPicsum
//
//  Created by Adhitya Bagasmiwa Permana on 11/03/26.
//

import Foundation
import Combine
import SwiftUI

enum CommentError {
    case saveCommentFailed(message: String)
    case getCommentsFailed(message: String)
    case deleteCommentFailed(message: String, comment: UserComment)
    
    var value: String {
        switch self {
        case .saveCommentFailed(let message):
            return message
        case .getCommentsFailed(let message):
            return message
        case .deleteCommentFailed(let message, _):
            return message
        }
    }
}

class ImageDetailViewModel: ObservableObject {
    @Published var image: ImagePicsum
    @Published var isLoading: Bool = false
    @Published var errorMessage: CommentError?
    @Published var comments: [UserComment] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let coordinator: AppCoordinator
    private let saveCommentUseCase: SaveCommentUseCase
    private let getCommentsUseCase: GetCommentsUseCase
    private let deleteCommentUseCase: DeleteCommentUseCase
    
    init(
        image: ImagePicsum,
        coordinator: AppCoordinator,
        saveCommentUseCase: SaveCommentUseCase,
        getCommentsUseCase: GetCommentsUseCase,
        deleteCommentUseCase: DeleteCommentUseCase
    ) {
        self.image = image
        self.coordinator = coordinator
        self.saveCommentUseCase = saveCommentUseCase
        self.getCommentsUseCase = getCommentsUseCase
        self.deleteCommentUseCase = deleteCommentUseCase
    }
}

extension ImageDetailViewModel {
    func addComment() {
        let newComment = RandomTextGenerator.generateComment(for: image.id ?? "")
        let request = SaveCommentRequest(
            id: newComment.id,
            imageId: newComment.imageId,
            authorInitial: newComment.authorInitial,
            authorFullName: newComment.authorFullName,
            text: newComment.text,
            createdAt: newComment.createdAt
        )
        saveCommentUseCase.execute(request: request)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = .saveCommentFailed(message: error.localizedDescription)
                }
            } receiveValue: { [weak self] in
                withAnimation {
                    self?.comments.insert(newComment, at: .zero)
                }
            }
            .store(in: &cancellables)
    }
    
    func getComments() {
        isLoading = true
        
        getCommentsUseCase.execute(request: GetCommentsRequest(imageId: image.id ?? ""))
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = .getCommentsFailed(message: error.localizedDescription)
                }
            } receiveValue: { [weak self] domainComments in
                self?.comments.append(contentsOf: domainComments)
            }
            .store(in: &cancellables)
    }
    
    func deleteComment(comment: UserComment) {
        let request = DeleteCommentRequest(
            commentId: comment.id ?? UUID(),
            imageId: comment.imageId ?? ""
        )
        deleteCommentUseCase.execute(request: request)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = .deleteCommentFailed(message: error.localizedDescription, comment: comment)
                }
            } receiveValue: { [weak self] in
                self?.comments.removeAll { $0.id == comment.id }
            }
            .store(in: &cancellables)
    }
}
