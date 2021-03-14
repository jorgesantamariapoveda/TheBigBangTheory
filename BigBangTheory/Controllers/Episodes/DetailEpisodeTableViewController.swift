//
//  DetalleEpisodioTableViewController.swift
//  BigBangTheory
//
//  Created by Jorge on 04/03/2021.
//

import UIKit

final class DetailEpisodeTableViewController: UITableViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var airdateLable: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!

    var episode: Episode?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupData()
    }

    // MARK: - Private functions

    private func setupData() {
        guard let episode = episode else { return }

        nameLabel.text = episode.name
        episodeLabel.text = "\(episode.number)"
        seasonLabel.text = "\(episode.season)"
        airdateLable.text = "\(episode.airdate)"
        summaryTextView.text = episode.summary
            .replacingOccurrences(of: "<p>", with: "")
            .replacingOccurrences(of: "</p>", with: "")
        avatar.isHidden = true

        getImageNetwork(url: episode.image.medium) { [weak self] image in
            self?.avatar.layer.cornerRadius = 8
            self?.avatar.image = image
            self?.avatar.isHidden = false
        }
    }

}
