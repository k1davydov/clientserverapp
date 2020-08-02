//
//  BookRepository.swift
//  Книги
//
//  Created by Yulia Zatonskaya on 02.08.2020.
//  Copyright © 2020 Davydov. All rights reserved.
//

import Foundation

class BookRepository {

    var books: Array<Book>? = Array()

    func requestBookWithQuery (query: String) -> Array<Book>? {
        let str = "https://www.googleapis.com/books/v1/volumes?q="
        guard let url = URL(string: str + query) else {return books}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            guard error == nil else {return}

            do {
                self.books = try JSONDecoder().decode(Response.self, from: data).items
            } catch let error {
                print(error)
            }
            return(self.books)
        } .resume()
    }
}
