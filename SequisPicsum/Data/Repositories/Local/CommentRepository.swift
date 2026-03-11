//
//  CommentRepository.swift
//  SequisPicsum
//
//  Created by Adhitya Bagasmiwa Permana on 11/03/26.
//

import Foundation
import CoreData
import Combine

class CommentRepositoryImpl: CommentRepositoryProtocol {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    private func saveContext() throws {
        if context.hasChanges {
            try context.save()
        }
    }
    
    func save(to comment: SaveCommentRequest) -> AnyPublisher<Void, any Error> {
        return Future<Void, Error> { [weak self] promise in
            guard let self = self else { return }
            
            self.context.perform {
                let entity = CommentEntity(context: self.context)
                entity.id = comment.id
                entity.imageId = comment.imageId
                entity.authorInitial = comment.authorInitial
                entity.authorFullName = comment.authorFullName
                entity.text = comment.text
                entity.createdAt = comment.createdAt
                
                do {
                    try self.saveContext()
                    promise(.success(()))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func getComments(imageId: String) -> AnyPublisher<[UserComment], any Error> {
        return Future<[UserComment], Error> { [weak self] promise in
            guard let self = self else { return }
            
            self.context.perform {
                let fetchRequest: NSFetchRequest<CommentEntity> = CommentEntity.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "imageId == %@", imageId)
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
                
                do {
                    let results = try self.context.fetch(fetchRequest)
                    let comments = results.map { $0.toDomain() }
                    promise(.success(comments))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func delete(commentId: UUID, imageId: String) -> AnyPublisher<Void, any Error> {
        return Future<Void, Error> { [weak self] promise in
            guard let self = self else { return }
            
            self.context.perform {
                let fetchRequest: NSFetchRequest<CommentEntity> = CommentEntity.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %@ AND imageId == %@", commentId as CVarArg, imageId)
                
                do {
                    if let entityToDelete = try self.context.fetch(fetchRequest).first {
                        self.context.delete(entityToDelete)
                        try self.saveContext()
                    }
                    promise(.success(()))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
