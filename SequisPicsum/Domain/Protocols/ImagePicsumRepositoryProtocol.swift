//
//  ImagePicsumRepositoryProtocol.swift
//  SequisPicsum
//
//  Created by Adhitya Bagasmiwa Permana on 10/03/26.
//

import Combine

protocol ImagePicsumRepositoryProtocol: AnyObject {
    func getImages(request: GetImagesRequest) -> AnyPublisher<[ImagePicsum], Error>
}
