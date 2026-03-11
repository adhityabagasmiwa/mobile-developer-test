//
//  BaseUseCase.swift
//  SequisPicsum
//
//  Created by Adhitya Bagasmiwa Permana on 10/03/26.
//

import Combine

class BaseUseCase<DOMAIN, REQUEST> {
    
    func execute(request: REQUEST) -> AnyPublisher<DOMAIN, Error> {
        getData(request: request)
            .handleEvents(receiveCompletion: { completion in
                #if DEBUG
                if case let .failure(error) = completion {
                    print("execute failed:", error)
                }
                #endif
            })
            .eraseToAnyPublisher()
    }
    
    func execute() -> AnyPublisher<DOMAIN, Error> {
        getData(request: nil)
            .handleEvents(receiveCompletion: { completion in
                #if DEBUG
                if case let .failure(error) = completion {
                    print("execute failed:", error)
                }
                #endif
            })
            .eraseToAnyPublisher()
    }

    /// Override this in subclasses
    func getData(request: REQUEST?) -> AnyPublisher<DOMAIN, Error> {
        fatalError("subclasses must override getData(request:)")
    }
}
