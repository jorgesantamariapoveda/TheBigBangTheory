//
//  FavoritesDiffableCollectionViewController.swift
//  BigBangTheory
//
//  Created by Jorge on 20/03/2021.
//

import UIKit

final class FavoritesDiffableCollectionViewController: UICollectionViewController {

    lazy var dataSource: UICollectionViewDiffableDataSource<Int,Int> = {
        UICollectionViewDiffableDataSource<Int,Int>(collectionView: self.collectionView,
                             cellProvider: { collectionView, indexPath, idFavorite in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellFavorite", for: indexPath) as? FavoriteCollectionViewCell else {
                return UICollectionViewCell()
            }

            if let episode = model.getEpisodeFavorite(index: indexPath.row) {
                cell.nameEpisodeLabel.text = episode.name
                cell.idEpisode = episode.id

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
        })
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupData()

        NotificationCenter.default.addObserver(forName: .toggleFavorite, object: nil, queue: .main) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.setupData()
            }
        }
    }

    // MARK: - Public functions

    public func setupData() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0])
        snapshot.appendItems(model.idEpisodesFavorites)
        dataSource.apply(snapshot)
    }

}
