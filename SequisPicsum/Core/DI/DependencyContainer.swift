//
//  DependencyContainer.swift
//  SequisPicsum
//
//  Created by Adhitya Bagasmiwa Permana on 10/03/26.
//

import Foundation
import Moya

protocol DependencyContainerProtocol: AnyObject {
    var getImagesPicsumUseCase: GetImagesPicsumUseCase { get }
}

final class DependencyContainer: DependencyContainerProtocol {
    private let imagesPicsumProvider = MoyaProvider<ImagePicsumAPI>()

    // MARK: Data Layer
    private lazy var imagesPicsumRepository: ImagePicsumRepositoryProtocol = {
        ImagePicsumRepositoryImpl(provider: imagesPicsumProvider)
    }()
    
    // MARK: Domain Layer
    var getImagesPicsumUseCase: GetImagesPicsumUseCase {
        GetImagesPicsumUseCase(repository: imagesPicsumRepository)
    }
}
