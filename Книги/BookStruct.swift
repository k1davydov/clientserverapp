//
//  BookStruct.swift
//  Книги
//
//  Created by Kirill Davydov on 29.07.2020.
//  Copyright © 2020 Davydov. All rights reserved.
//

import UIKit

struct Response: Decodable {
    var items: Array<Book>?
}

struct Book: Decodable {
    var volumeInfo: VolumeInfo
}

struct VolumeInfo: Decodable {
    var title: String?
    var subtitle: String?
    var description: String?
    var imageLinks: ImageLinks
}

struct ImageLinks: Decodable {
    var thumbnail: String?
}
