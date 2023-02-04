//
//  Movie.swift
//  Movie Zone
//
//  Created by Monish Chaudhari on 04/02/23.
//

import Foundation

/*
 "Title": "Harry Potter and the Deathly Hallows: Part 2",
 "Year": "2011",
 "imdbID": "tt1201607",
 "Type": "movie",
 "Poster": "https://m.media-amazon.com/images/M/MV5BMGVmMWNiMDktYjQ0Mi00MWIxLTk0N2UtN2ZlYTdkN2IzNDNlXkEyXkFqcGdeQXVyODE5NzE3OTE@._V1_SX300.jpg"
 */

struct MovieSearchAPIResponse: Codable {
    var Search: [Movie]?
    var totalResults: String?
    var Response: String?
    var Error: String?
}

struct Movie: Codable {
    var Title: String?
    var Year: String?
    var Rated: String?
    var Released: String?
    var Runtime: String?
    var Genre: String?
    var Director: String?
    var Writer: String?
    var Actors: String?
    var Plot: String?
    var Language: String?
    var Country: String?
    var Awards: String?
    var Poster: String?
    var Ratings: [Ratings]?
    var Metascore: String?
    var imdbRating: String?
    var imdbVotes: String?
    var imdbID: String?
    var `Type`: String?
    var DVD: String?
    var BoxOffice: String?
    var Production: String?
    var Website: String?
    var Response: String?
}

struct Ratings: Codable {
        var Source: String?
        var Value: String?
}
