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
    @IBOutlet weak var heartButton: UIButton!

    var episode: Episode?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupData()
    }

    @IBAction func tocarCorazon(_ sender: UIButton) {
        guard let episode = episode else { return }

        model.toogleEpisodeFavorite(id: episode.id)
        let isEpisodeFavorite = model.isEpisodeFavorite(id: episode.id)

        UIView.animate(withDuration: 1) {
            self.setImageHeartButton(isEpisodeFavorite: isEpisodeFavorite)
            sender.transform = CGAffineTransform(scaleX: -5, y: -5)
            sender.transform = CGAffineTransform.identity
        }
    }

    // MARK: - Private funtions

    private func setupData() {
        guard let episode = episode else { return }

        let isEpisodeFavorite = model.isEpisodeFavorite(id: episode.id)
        setImageHeartButton(isEpisodeFavorite: isEpisodeFavorite)

        nameLabel.text = episode.name
        episodeLabel.text = "\(episode.number)"
        seasonLabel.text = "\(episode.season)"
        airdateLable.text = "\(episode.airdate)"
        summaryTextView.text = episode.summary
            .replacingOccurrences(of: "<p>", with: "")
            .replacingOccurrences(of: "</p>", with: "")

        avatar.isHidden = true
        if let imageCache = loadImageCache(imageName: "\(episode.id)", imageFormat: .jpg) {
            setImageAvatar(image: imageCache)
        } else {
            getImageNetwork(url: episode.image.medium) { [weak self] image in
                self?.setImageAvatar(image: image)
                saveImageCache(image: image, imageName: "\(episode.id)", imageFormat: .jpg)
            }
        }
    }

    private func setImageAvatar(image: UIImage) {
        avatar.image = image
        avatar.layer.cornerRadius = 8
        avatar.isHidden = false
    }

    private func setImageHeartButton(isEpisodeFavorite: Bool) {
        heartButton.setImage(isEpisodeFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
    }

}
