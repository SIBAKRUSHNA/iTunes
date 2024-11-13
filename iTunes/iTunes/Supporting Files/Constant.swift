//
//  Constant.swift
//  iTunes
//
//  Created by Siba Krushna on 12/11/24.
//

import Foundation


enum ContentType: String, CaseIterable {
    // Music Entities
    case musicArtist
    case musicTrack
    case album
    case musicVideo
    case mix
    case song
    case allTrack
    
    // Podcast Entities
    case podcastAuthor
    case podcast
    
    // Movie Entities
    case movieArtist
    case movie
    case shortFilmArtist
    case shortFilm
    case tvEpisode
    case tvSeason
    
    // Audiobook Entities
    case audiobookAuthor
    case audiobook
    
    // Software Entities
    case software
    case iPadSoftware
    case macSoftware
    
    // eBook Entities
    case ebook
    
    // General Entities
    case allArtist
}

// Network error
enum APIError: LocalizedError {
    case badURL
    case requestFailed(Error)
    case serverError(Int)
    case decodingError
    case unknown

    var errorDescription: String? {
        switch self {
        case .badURL:
            return "The URL is invalid."
        case .requestFailed(let error):
            return "Request failed with error: \(error.localizedDescription)"
        case .serverError(let statusCode):
            return "Server error occurred with status code: \(statusCode)"
        case .decodingError:
            return "Failed to decode the response from the server."
        case .unknown:
            return "An unknown error occurred."
        }
    }
}
