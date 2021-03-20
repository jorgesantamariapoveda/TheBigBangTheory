//
//  FavoriteCollectionViewCell.swift
//  BigBangTheory
//
//  Created by Jorge on 19/03/2021.
//

import UIKit

final class FavoriteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameEpisodeLabel: UILabel!
    @IBOutlet weak var deleteFavoriteEpisodeButton: UIButton!

    var idEpisode: Int?

    @IBAction func deleteFavoriteEpisode(_ sender: UIButton) {
        if let id = idEpisode {
            model.toogleEpisodeFavorite(id: id)

            UIView.animate(withDuration: 1) {
                sender.transform = CGAffineTransform(scaleX: 5, y: 5)
                sender.transform = CGAffineTransform.identity
            }
        }
    }

}
