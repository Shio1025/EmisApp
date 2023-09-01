//
//  LibraryUseCase.swift
//  Core
//
//  Created by Shio Birbichadze on 01.09.23.
//

import Combine
import Resolver

public protocol LibraryUseCase {
    func getBooks(title: String,
                  author: String,
                  page: Int,
                  size: Int) -> AnyPublisher<Library, Error>
}

public class LibraryUseCaseImpl: LibraryUseCase {
    
    @Injected var LibraryGateway: LibraryGateway
    
    public func getBooks(title: String,
                         author: String,
                         page: Int,
                         size: Int) -> AnyPublisher<Library, Error> {
        LibraryGateway.getBooks(title: title,
                                author: author,
                                page: page,
                                size: size)
    }
}
