//
//  TemporadasTableViewController.swift
//  BigBangTheory
//
//  Created by Jorge on 03/03/2021.
//

import UIKit

final class EpisodesTableViewController: UITableViewController {

    var model = BigBangModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        model.getNumSeasons()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.getNumEpisodesBySeason(season: section + 1)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellEpisode", for: indexPath)
        if let episode = model.getEpisode(season: indexPath.section + 1, episode: indexPath.row + 1) {
            cell.textLabel?.text = episode.name
            cell.detailTextLabel?.text = "Airdate: \(episode.airdate)"
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Season \(section + 1)"
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailEpisode" {
            if let detailVC = segue.destination as? DetailEpisodeTableViewController,
               let indexPath = tableView.indexPathForSelectedRow,
               let episode = model.getEpisode(season: indexPath.section + 1, episode: indexPath.row + 1) {
                detailVC.episode = episode
            }
        }
    }
}
