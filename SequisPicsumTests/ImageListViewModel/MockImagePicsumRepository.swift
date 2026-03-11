//
//  MockImagePicsumRepository.swift
//  SequisPicsumTests
//
//  Created by Adhitya Bagasmiwa Permana on 11/03/26.
//

import Combine
import Foundation
@testable import SequisPicsum

class MockImagePicsumRepositoryImpl: ImagePicsumRepositoryProtocol {
    var result: Result<[ImagePicsum], Error> = .success([])
    var getImagesCalledCount = 0
    var lastRequest: GetImagesRequest?
    
    func getImages(request: GetImagesRequest) -> AnyPublisher<[ImagePicsum], Error> {
        getImagesCalledCount += 1
        lastRequest = request
        return result.publisher.eraseToAnyPublisher()
    }
}
