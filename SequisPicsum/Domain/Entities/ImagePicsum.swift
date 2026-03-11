//
//  ImagePicsum.swift
//  SequisPicsum
//
//  Created by Adhitya Bagasmiwa Permana on 10/03/26.
//

import Foundation

struct ImagePicsum: Identifiable, Equatable, Hashable {
    let id: String?
    let author: String?
    let url: URL?
    let downloadUrl: URL?
    
    init(id: String? = nil, author: String? = nil, url: URL? = nil, downloadUrl: URL? = nil) {
        self.id = id
        self.author = author
        self.url = url
        self.downloadUrl = downloadUrl
    }
}
