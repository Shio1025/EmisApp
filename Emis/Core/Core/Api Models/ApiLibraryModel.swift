//
//  ApiLibraryModel.swift
//  Core
//
//  Created by Shio Birbichadze on 01.09.23.
//

struct ApiLibraryModel: Codable {
    let content: [ApiBook]
    let totalElements: Int
    let totalPages: Int
}

struct ApiBook: Codable {
    let id: Int
    let title: String
    let author: String
    let genres: [String]
}

