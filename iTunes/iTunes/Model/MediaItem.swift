//
//  MediaItem.swift
//  iTunes
//
//  Created by Siba Krushna on 12/11/24.
//

import Foundation

// Media Entity (could be a song, movie, podcast, etc.)
struct MediaItem: Decodable, Hashable  {
    let resultCount: Int?
    let results: [Track]?
    enum CodingKeys: String, CodingKey {
        case resultCount
        case results
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // Decode the fields with optional fallback
        resultCount = try container.decodeIfPresent(Int.self, forKey: .resultCount)
        results = try container.decodeIfPresent([Track].self, forKey: .results) ?? []
    }
}

struct Track: Decodable, Hashable, Identifiable {
    var id = UUID() // To uniquely identify each item in SwiftUI
    let wrapperType: String?
    let kind: String?
    let collectionId: Int?
    let trackId: Int?
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let collectionCensoredName: String?
    let trackCensoredName: String?
    let collectionViewUrl: String?
    let trackViewUrl: String?
    let previewUrl: String?
    let artworkUrl30: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let collectionPrice: Double?
    let trackPrice: Double?
    let releaseDate: String?
    let country: String?
    let currency: String?
    let primaryGenreName: String?
    let longDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case wrapperType
        case kind
        case collectionId
        case trackId
        case artistName
        case collectionName
        case trackName
        case collectionCensoredName
        case trackCensoredName
        case collectionViewUrl
        case trackViewUrl
        case previewUrl
        case artworkUrl30
        case artworkUrl60
        case artworkUrl100
        case collectionPrice
        case trackPrice
        case releaseDate
        case country
        case currency
        case primaryGenreName
        case longDescription
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        wrapperType = try container.decodeIfPresent(String.self, forKey: .wrapperType)
        artistName = try container.decodeIfPresent(String.self, forKey: .artistName)
        trackName = try container.decodeIfPresent(String.self, forKey: .trackName)
        kind = try container.decodeIfPresent(String.self, forKey: .kind)
        collectionId = try container.decodeIfPresent(Int.self, forKey: .collectionId)
        trackId = try container.decodeIfPresent(Int.self, forKey: .trackId)
        collectionName = try container.decodeIfPresent(String.self, forKey: .collectionName)
        collectionCensoredName = try container.decodeIfPresent(String.self, forKey: .collectionCensoredName)
        trackCensoredName = try container.decodeIfPresent(String.self, forKey: .trackCensoredName)
        collectionViewUrl = try container.decodeIfPresent(String.self, forKey: .collectionViewUrl)
        trackViewUrl = try container.decodeIfPresent(String.self, forKey: .trackViewUrl)
        previewUrl = try container.decodeIfPresent(String.self, forKey: .previewUrl)
        artworkUrl30 = try container.decodeIfPresent(String.self, forKey: .artworkUrl30)
        artworkUrl60 = try container.decodeIfPresent(String.self, forKey: .artworkUrl60)
        artworkUrl100 = try container.decodeIfPresent(String.self, forKey: .artworkUrl100)
        collectionPrice = try container.decodeIfPresent(Double.self, forKey: .collectionPrice)
        trackPrice = try container.decodeIfPresent(Double.self, forKey: .trackPrice)
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        country = try container.decodeIfPresent(String.self, forKey: .country)
        currency = try container.decodeIfPresent(String.self, forKey: .currency)
        primaryGenreName = try container.decodeIfPresent(String.self, forKey: .primaryGenreName)
        longDescription = try container.decodeIfPresent(String.self, forKey: .longDescription)
    }
}
