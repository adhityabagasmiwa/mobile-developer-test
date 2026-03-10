//
//  ImagePicsumDTO.swift
//  SequisPicsum
//
//  Created by Adhitya Bagasmiwa Permana on 10/03/26.
//

import Foundation

struct ImagePicsumDTO: Decodable {
    var id: String?
    var author: String?
    var width: Int?
    var height: Int?
    var url: String?
    var downloadUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadUrl = "download_url"
    }
    
    func toDomain() -> ImagePicsum {
        return ImagePicsum(
            id: id ?? "",
            author: author ?? "",
            url: URL(string: url ?? ""),
            downloadUrl: URL(string: downloadUrl ?? "")
        )
    }
}
