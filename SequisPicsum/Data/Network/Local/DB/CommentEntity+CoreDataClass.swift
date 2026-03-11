//
//  CommentEntity+CoreDataClass.swift
//  SequisPicsum
//
//  Created by Adhitya Bagasmiwa Permana on 11/03/26.
//
//

import Foundation
import CoreData

@objc(CommentEntity)
class CommentEntity: NSManagedObject {
    func toDomain() -> UserComment {
        return UserComment(
            id: self.id ?? UUID(),
            imageId: self.imageId ?? "",
            authorInitial: self.authorInitial ?? "",
            authorFullName: self.authorFullName ?? "",
            text: self.text ?? "",
            createdAt: self.createdAt ?? Date()
        )
    }
}
