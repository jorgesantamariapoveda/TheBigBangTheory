//
//  ModelBigBang.swift
//  BigBangTheory
//
//  Created by Jorge on 04/03/2021.
//

import Foundation

// MARK: - BigBang
struct BigBang: Codable {
    let id: Int
    let url: String
    let name, type, language: String
    let genres: [String]
    let status: String
    let runtime: Int
    let premiered: String
    let officialSite: String
//    let schedule: Schedule
//    let rating: Rating
    let weight: Int
//    let network: Network
//    let webChannel: NSNull
//    let externals: Externals
//    let image: Image
    let summary: String
    let updated: Int
//    let links: BigBangLinks
//    let embedded: Embedded
}

// MARK: - Embedded
struct Embedded {
    let episodes: [Episode]
}

// MARK: - Episode
struct Episode {
    let id: Int
    let url: String
    let name: String
    let season, number: Int
    let type: TypeEnum
    let airdate: String
    let airtime: Time
    let airstamp: Date
    let runtime: Int
    let image: Image
    let summary: String
    let links: EpisodeLinks
}

enum Time {
    case the2000
    case the2030
    case the2031
    case the2100
    case the2130
}

// MARK: - Image
struct Image {
    let medium, original: String
}

// MARK: - EpisodeLinks
struct EpisodeLinks {
    let linksSelf: Previousepisode
}

// MARK: - Previousepisode
struct Previousepisode {
    let href: String
}

enum TypeEnum {
    case regular
}

// MARK: - Externals
struct Externals {
    let tvrage, thetvdb: Int
    let imdb: String
}

// MARK: - BigBangLinks
struct BigBangLinks {
    let linksSelf, previousepisode: Previousepisode
}

// MARK: - Network
struct Network {
    let id: Int
    let name: String
    let country: Country
}

// MARK: - Country
struct Country {
    let name, code, timezone: String
}

// MARK: - Rating
struct Rating {
    let average: Double
}

// MARK: - Schedule
struct Schedule {
    let time: Time
    let days: [String]
}
