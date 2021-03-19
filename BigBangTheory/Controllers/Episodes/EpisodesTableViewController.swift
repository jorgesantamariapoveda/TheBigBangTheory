//
//  TemporadasTableViewController.swift
//  BigBangTheory
//
//  Created by Jorge on 03/03/2021.
//

import UIKit

var model = BigBangModel()

final class EpisodesTableViewController: UITableViewController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = false

        tabBarController?.delegate = self
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

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let episode = model.getEpisode(season: indexPath.section + 1, episode: indexPath.row + 1) else {
            return nil
        }

        let actionFavorite = UIContextualAction(style: .normal, title: "Favorite") { action, view, handler in
            model.toogleEpisodeFavorite(id: episode.id)
            handler(true)
        }

        if model.isEpisodeFavorite(id: episode.id) {
            actionFavorite.image = UIImage(systemName: "heart")
            actionFavorite.backgroundColor = .red
        } else {
            actionFavorite.image = UIImage(systemName: "heart.fill")
            actionFavorite.backgroundColor = .blue
        }

        return UISwipeActionsConfiguration(actions: [actionFavorite])
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

    // MARK: - UITabBarControllerDelegate

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let navigation = viewController as? UINavigationController,
           let top = navigation.topViewController as? FavoritesCollectionViewController {
            top.collectionView.reloadData()
        }
    }
}
