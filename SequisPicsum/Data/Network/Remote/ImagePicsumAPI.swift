//
//  ImagePicsumAPI.swift
//  SequisPicsum
//
//  Created by Adhitya Bagasmiwa Permana on 10/03/26.
//

import Foundation
import Moya

enum ImagePicsumAPI {
    case getImages(request: GetImagesRequest)
}

enum ImagePicsumPath: String {
    case list = "/list"
    
    var value: String {
        return self.rawValue
    }
}

extension ImagePicsumAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://picsum.photos/v2") else {
            return URL(string: "")!
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getImages:
            return ImagePicsumPath.list.value
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getImages:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getImages(let request):
            return .requestParameters(
                parameters: ["page": request.page ?? 1, "limit": request.limit ?? 10],
                encoding: URLEncoding.queryString
            )
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
