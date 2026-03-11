//
//  SaveCommentRequest.swift
//  SequisPicsum
//
//  Created by Adhitya Bagasmiwa Permana on 11/03/26.
//

import Foundation

struct SaveCommentRequest {
    let id: UUID?
    let imageId: String?
    let authorInitial: String?
    let authorFullName: String?
    let text: String?
    let createdAt: Date?
    
    init(
        id: UUID? = nil,
        imageId: String? = nil,
        authorInitial: String? = nil,
        authorFullName: String? = nil,
        text: String? = nil,
        createdAt: Date? = nil
    ) {
        self.id = id
        self.imageId = imageId
        self.authorInitial = authorInitial
        self.authorFullName = authorFullName
        self.text = text
        self.createdAt = createdAt
    }
}
