//
//  ModelBigBang.swift
//  BigBangTheory
//
//  Created by Jorge on 04/03/2021.
//

import Foundation

// MARK: - API response
struct BigBang: Codable {
    let _embedded: Embedded
}

struct Embedded: Codable {
    let episodes: [Episode]
}

struct Episode: Codable {
    let id: Int
    let name: String
    let season: Int
    let number: Int
    let image: Image
}

struct Image: Codable {
    let medium: String
}

// MARK: - Model

struct BigBangModel {

    var episodes: [Episode]

    lazy var numSeasons:Int = {
        var seasons = [Int]()
        episodes.forEach { (episode) in
            if seasons.firstIndex(of: episode.season) == nil {
                seasons.append(episode.season)
            }
        }
        return seasons.count
    }()

    init() {
        guard let ruta = Bundle.main.url(forResource: "BigBang", withExtension: "json") else {
            episodes = []
            return
        }
        do {
            let json = try Data(contentsOf: ruta)
            let responseJson = try JSONDecoder().decode(BigBang.self, from: json)
            episodes = responseJson._embedded.episodes
        } catch {
            print("Error en la carga \(error)")
            episodes = []
        }
    }

    func numEpisodesBySeason(season: Int) -> Int {
        episodes.filter { $0.season == season }.count
    }

    func nameEpisode(season: Int, episode: Int) -> String {
        let episode = episodes.filter { $0.season == season && $0.number == episode }
        if let episode = episode.first {
            return episode.name
        }
        return ""
    }

}
