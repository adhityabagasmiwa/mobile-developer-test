//
//  ImagePicsumRepository.swift
//  SequisPicsum
//
//  Created by Adhitya Bagasmiwa Permana on 10/03/26.
//

import Foundation
import Moya
import Combine
import CombineMoya

class ImagePicsumRepositoryImpl: ImagePicsumRepositoryProtocol {
    private let provider: MoyaProvider<ImagePicsumAPI>

    init(provider: MoyaProvider<ImagePicsumAPI> = MoyaProvider<ImagePicsumAPI>()) {
        self.provider = provider
    }
    
    func getImages(request: GetImagesRequest) -> AnyPublisher<[ImagePicsum], any Error> {
        return provider.requestPublisher(.getImages(request: request))
            .filterSuccessfulStatusCodes()
            .map([ImagePicsumDTO].self)
            .map { item in
                item.map { $0.toDomain() }
            }
            .mapError { $0 as Error }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
