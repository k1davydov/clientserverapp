//
//  Utils.swift
//  Книги
//
//  Created by Yulia Zatonskaya on 02.08.2020.
//  Copyright © 2020 Davydov. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellTitle.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.cellTitle[indexPath.row]
        cell.detailTextLabel?.text = self.cellSubTitle[indexPath.row]
        return cell
    }
}
