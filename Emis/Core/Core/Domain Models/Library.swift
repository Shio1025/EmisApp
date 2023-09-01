//
//  Library.swift
//  Core
//
//  Created by Shio Birbichadze on 01.09.23.
//

public struct Library {
    public let content: [Book]
    public let totalElements: Int
    public let totalPages: Int
    
   public init(content: [Book], totalElements: Int, totalPages: Int) {
        self.content = content
        self.totalElements = totalElements
        self.totalPages = totalPages
    }
    
    init(with model: ApiLibraryModel) {
        self.content = model.content.map { Book(with: $0) }
        self.totalElements = model.totalElements
        self.totalPages = model.totalPages
     }
}

public struct Book {
    public init(id: Int,title: String, author: String, genres: [String]) {
        self.title = title
        self.author = author
        self.genres = genres
        self.id = id
    }
    
    public let id: Int
    public let title: String
    public let author: String
    let genres: [String]
    
    init(with model: ApiBook) {
        self.title = model.title
        self.author = model.author
        self.genres = model.genres
        self.id = model.id
    }
    
    public var genre: String {
        genres.joined(separator: ", ")
    }
}
