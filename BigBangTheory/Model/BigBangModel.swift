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
    private var idEpisodesFavorites:[Int] {
        didSet {
            saveFavorites()
        }
    }

    //MARK: - Public functions

    init() {
        guard let ruta = Bundle.main.url(forResource: "BigBang", withExtension: "json"),
              let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            episodes = []
            idEpisodesFavorites = []
            return
        }
        let fichero = documents.appendingPathComponent("FAVORITES").appendingPathExtension("json")
        do {
            let json = try Data(contentsOf: ruta)
            let responseJson = try JSONDecoder().decode(BigBang.self, from: json)
            episodes = responseJson._embedded.episodes
            let jsonFavorites = try Data(contentsOf: fichero)
            idEpisodesFavorites = try JSONDecoder().decode([Int].self, from: jsonFavorites)
        } catch {
            print("Error en la carga \(error)")
            episodes = []
            idEpisodesFavorites = []
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

    func getEpisode(season: Int, episode: Int) -> Episode? {
        let episode = episodes.filter { $0.season == season && $0.number == episode }
        if let episode = episode.first {
            return episode
        }
        return nil
    }

    func getEpisodeFavorite(index: Int) -> Episode? {
        if index < idEpisodesFavorites.count {
            let id = idEpisodesFavorites[index]
            return episodes.first() { $0.id == id }
        }
        return nil
    }

    func isEpisodeFavorite(id: Int) -> Bool {
        idEpisodesFavorites.firstIndex(of: id) != nil ? true : false
    }

    mutating func toogleEpisodeFavorite(id: Int) {
        if let index = idEpisodesFavorites.firstIndex(of: id) {
            idEpisodesFavorites.remove(at: index)
        } else {
            idEpisodesFavorites.append(id)
        }

        NotificationCenter.default.post(name: .toggleFavorite, object: nil)
    }

    func getNumEpisodesFavorites() -> Int {
        idEpisodesFavorites.count
    }

    //MARK: - Private functions

    private func saveFavorites() {
        guard let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        let fichero = documents.appendingPathComponent("FAVORITES").appendingPathExtension("json")
        DispatchQueue.global(qos: .background).async {
            do {
                let jsonData = try JSONEncoder().encode(idEpisodesFavorites)
                try jsonData.write(to: fichero, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Error in saveFavorites: \(error)")
            }
        }
    }

}
