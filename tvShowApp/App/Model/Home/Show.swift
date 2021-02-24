//
//  Show.swift
//  tvShowApp
//
//  Created by Walter Bladimir Rafael on 22/2/21.
//

import Foundation


struct Show: Codable {
    
    var name: String? = ""
    var firstAirDate: String? = ""
    var backdropPath: String? = ""
    var id: Int? = 0
    var voteAverage: Double? = 0.0
    var overview: String? = ""
    var posterPath: String? = ""
    var cast: [Cast]?
    var detail: Detail?
    
    init(attributes: [String: Any]) {
        self.name = attributes["name"] as? String ?? ""
        self.firstAirDate = attributes["first_air_date"] as? String ?? ""
        self.backdropPath = attributes["backdrop_path"] as? String ?? ""
        self.id = attributes["id"] as? Int ?? -1
        self.voteAverage = attributes["vote_average"] as? Double ?? 0.0
        self.overview = attributes["overview"] as? String ?? ""
        self.posterPath = attributes["poster_path"] as? String ?? ""
        if let casts = attributes["cast"] as? [[String:Any]] {
            var c = [Cast]()
            casts.forEach({
                c.append(Cast(attributes: $0))
            })
            self.cast = c
        }
        if let detail = attributes["detail"] as? [String:Any] {
            self.detail = Detail(attributes: detail)
        }
    }
}

enum ShowType: String {
    case popular = "popular"
    case toprated = "top_rated"
    case ontv = "on_the_air"
    case airingtoday = "airing_today"
    
    static func allShowType() -> [ShowType] {
        return [.popular, .toprated, .ontv, .airingtoday]
    }
    
    func displayText() -> String {
        switch self {
        case .popular:
            return "Most Popular"
        case .toprated:
            return "Top Rated"
        case .ontv:
            return "On TV"
        case .airingtoday:
            return "Airing Today"
        }
    }
}


struct ShowResponse {
    
    var page: Int?
    var totalResults: Int?
    var totalPages: Int?
    var results: [Show]?
    
    init(attributes: [String: Any]) {
        self.page = attributes["page"] as? Int
        self.totalResults = attributes["total_results"] as? Int
        self.totalPages = attributes["total_pages"] as? Int
        self.results = attributes["results"] as? [Show]
    }
}


struct Cast: Codable {
    
    var name: String? = ""
    var profile_path: String? = ""
    
    init(attributes: [String: Any]) {
        self.name = attributes["name"] as? String ?? ""
        self.profile_path = attributes["profile_path"] as? String ?? ""
    }
}


struct Detail: Codable {

    var created_by: [Creator]?
    var seasons: [Season]?
    var status: String? = ""
    
    init(attributes: [String: Any]) {
        self.status = attributes["status"] as? String ?? ""
        if let creators = attributes["created_by"] as? [[String:Any]] {
            var creatorsBy = [Creator]()
            creators.forEach({
                creatorsBy.append(Creator(attributes: $0 as [String:Any]))
            })
            self.created_by = creatorsBy
        }
        if let seasons = attributes["seasons"] as? [[String:Any]] {
            var seasonsShow = [Season]()
            seasons.forEach({
                seasonsShow.append(Season(attributes: $0 as [String:Any]))
            })
            self.seasons = seasonsShow
        }
    }
}

struct Creator: Codable {
    var name: String? = ""
    
    init(attributes: [String: Any]) {
        self.name = attributes["name"] as? String ?? ""
    }
}


struct Season: Codable {
    
    var name: String = ""
    var poster_path: String = ""
    var overview: String = ""
    var air_date: String = ""
    var episode_count: Int = -1
    var season_number: Int = -1
    
    init(attributes: [String: Any]) {
        self.name = attributes["name"] as? String ?? ""
        self.poster_path = attributes["poster_path"] as? String ?? ""
        self.overview = attributes["overview"] as? String ?? ""
        self.air_date = attributes["air_date"] as? String ?? ""
        self.episode_count = attributes["episode_count"] as? Int ?? -1
        self.season_number = attributes["season_number"] as? Int ?? -1
    }
}
