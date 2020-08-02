//
//  ViewController.swift
//  Книги
//
//  Created by Yulia Zatonskaya on 29.07.2020.
//  Copyright © 2020 Davydov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var books: Array<Book>? = Array()
    var cellTitle: Array<String> = []
    var cellSubTitle: Array<String> = []

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchCell: UITextField!
    @IBOutlet weak var search: UIButton!
    @IBOutlet weak var progressView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        progressView.startAnimating()
        progressView.isHidden = true
        self.tableView.dataSource = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "segue" else {return}
        guard let destination = segue.destination as? DescriptionViewController else {return}
        let indexPath = tableView?.indexPathForSelectedRow
        destination.book = self.books?[indexPath!.row]
    }

    @IBAction func searchButton(_ sender: Any) {
        progressView.isHidden = false
        tableView.isHidden = true
        let str = "https://www.googleapis.com/books/v1/volumes?q="
        let stringText = searchCell.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let url = URL(string: str + stringText) else {return}
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {return}
                guard error == nil else {return}

                do {
                    self.books = try JSONDecoder().decode(Response.self, from: data).items
                    self.cellTitle.removeAll()
                    print(data)
                    self.cellSubTitle.removeAll()
                    self.books?.forEach { book in
                        if (book.volumeInfo.title != nil) {
                            self.cellTitle.append(book.volumeInfo.title!)
                        }
                        if (book.volumeInfo.subtitle != nil){
                            self.cellSubTitle.append(book.volumeInfo.subtitle!)
                        } else {
                            self.cellSubTitle.append("")
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.progressView.isHidden = true
                        self.tableView.isHidden = false
                    }
                } catch let error {
                    print(error)
                }
            } .resume()
        }
    }
}



