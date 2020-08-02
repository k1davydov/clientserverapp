//
//  DescriptionViewController.swift
//  Книги
//
//  Created by Yulia Zatonskaya on 29.07.2020.
//  Copyright © 2020 Davydov. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {

    var book: Book?

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookDescription: UILabel!



    override func viewDidLoad() {
        super.viewDidLoad()
        bookTitle.numberOfLines = 0
        bookTitle.text = book?.volumeInfo.title
        bookDescription.numberOfLines = 0
        bookDescription.text = book?.volumeInfo.description
    
        let catPictureURL = URL(string: (book?.volumeInfo.imageLinks.thumbnail)!)!

        // Creating a session object with the default configuration.
        // You can read more about it here https://developer.apple.com/reference/foundation/urlsessionconfiguration
        let session = URLSession(configuration: .default)

        // Define a download task. The download task will download the contents of the URL as a Data object and then you can do what you wish with that data.
        let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
            // The download has finished.
            if let e = error {
                print("Error downloading cat picture: \(e)")
            } else {
                // No errors found.
                // It would be weird if we didn't have a response, so check for that too.
                if let res = response as? HTTPURLResponse {
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                        // Finally convert that Data into an image and do what you wish with it.
                        let image = UIImage(data: imageData)
                        // Do something with your image.
                        DispatchQueue.main.async {
                            self.bookImage.image = image
                                   }

                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }
        downloadPicTask.resume()
    }
}

