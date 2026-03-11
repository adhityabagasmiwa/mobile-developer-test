//
//  MockGetImagesPicsumUseCase.swift
//  SequisPicsumTests
//
//  Created by Adhitya Bagasmiwa Permana on 11/03/26.
//

import Combine
import Foundation
@testable import SequisPicsum

class MockGetImagesPicsumUseCase: GetImagesPicsumUseCase {
    var result: Result<[ImagePicsum], Error> = .success([])
    var executeCalledCount = 0
    var lastRequest: GetImagesRequest?
    
    override init(repository: ImagePicsumRepositoryProtocol = MockImagePicsumRepositoryImpl()) {
        super.init(repository: repository)
    }
    
    override func execute(request: GetImagesRequest) -> AnyPublisher<[ImagePicsum], Error> {
        executeCalledCount += 1
        lastRequest = request
        return result.publisher.eraseToAnyPublisher()
    }
}
