//
//  FavoritesCollectionViewController.swift
//  BigBangTheory
//
//  Created by Jorge on 19/03/2021.
//

import UIKit

final class FavoritesCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(forName: .toggleFavorite, object: nil, queue: .main) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.collectionView.reloadData()
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.getNumEpisodesFavorites()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellFavorite", for: indexPath) as? FavoriteCollectionViewCell else {
            return UICollectionViewCell()
        }

        if let episode = model.getEpisodeFavorite(index: indexPath.row) {
            cell.nameEpisodeLabel.text = episode.name

            if let imageCache = loadImageCache(imageName: "\(episode.id)", imageFormat: .jpg) {
                cell.avatar.image = imageCache
            } else {
                getImageNetwork(url: episode.image.medium) { image in
                    cell.avatar.image = image
                    saveImageCache(image: image, imageName: "\(episode.id)", imageFormat: .jpg)
                }
            }
        }

        return cell
    }

}
