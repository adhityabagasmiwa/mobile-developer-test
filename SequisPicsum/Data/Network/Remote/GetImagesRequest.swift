//
//  GetImagesRequest.swift
//  SequisPicsum
//
//  Created by Adhitya Bagasmiwa Permana on 10/03/26.
//

import Foundation

struct GetImagesRequest {
    let page: Int?
    let limit: Int?
    
    init(page: Int? = nil, limit: Int? = nil) {
        self.page = page
        self.limit = limit
    }
}
