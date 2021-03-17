//
//  FavoritosTableViewController.swift
//  BigBangTheory
//
//  Created by Jorge on 04/03/2021.
//

import UIKit

final class FavoritesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        NotificationCenter.default.addObserver(forName: .toggleFavorite, object: nil, queue: .main) { _ in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                self.tableView.reloadData()
//            }
//        }

        tableView.refreshControl = UIRefreshControl(frame: view.frame)
        tableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }

    @objc func refreshData() {
        tableView.refreshControl?.beginRefreshing()
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.getNumEpisodesFavorites()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellFavorite", for: indexPath)

        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }


}
