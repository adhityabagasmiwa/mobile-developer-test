//
//  GetImagesPicsumUseCase.swift
//  SequisPicsum
//
//  Created by Adhitya Bagasmiwa Permana on 10/03/26.
//

import Foundation
import Combine

class GetImagesPicsumUseCase: BaseUseCase<[ImagePicsum], GetImagesRequest> {
    let repository: ImagePicsumRepositoryProtocol
    
    init(repository: ImagePicsumRepositoryProtocol) {
        self.repository = repository
    }
    
    override func getData(request: GetImagesRequest?) -> AnyPublisher<[ImagePicsum], Error> {
        return repository.getImages(request: request ?? GetImagesRequest())
    }
}
