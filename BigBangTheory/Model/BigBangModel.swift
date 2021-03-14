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
    let airdate: String
    let image: Image
    let summary: String
}

struct Image: Codable {
    let medium: URL
}

// MARK: - Model

struct BigBangModel {

    private var episodes: [Episode]
    private var numSeasons: Int?

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

    mutating func getNumSeasons() -> Int {
        if let numSeasons = numSeasons {
            return numSeasons
        } else {
            var seasons = [Int]()
            episodes.forEach { (episode) in
                if seasons.firstIndex(of: episode.season) == nil {
                    seasons.append(episode.season)
                }
            }
            numSeasons = seasons.count
            return seasons.count
        }
    }

    func getNumEpisodesBySeason(season: Int) -> Int {
        episodes.filter { $0.season == season }.count
    }

    func getNameEpisode(season: Int, episode: Int) -> String {
        if let episode = getEpisode(season: season, episode: episode) {
            return episode.name
        }
        return ""
    }

    func getEpisode(season: Int, episode: Int) -> Episode? {
        let episode = episodes.filter { $0.season == season && $0.number == episode }
        if let episode = episode.first {
            return episode
        }
        return nil
    }

}
