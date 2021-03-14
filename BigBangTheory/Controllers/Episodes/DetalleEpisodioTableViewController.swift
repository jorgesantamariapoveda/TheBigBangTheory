//
//  DetalleEpisodioTableViewController.swift
//  BigBangTheory
//
//  Created by Jorge on 04/03/2021.
//

import UIKit

final class DetalleEpisodioTableViewController: UITableViewController {

    var episode: Episode?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }

}
