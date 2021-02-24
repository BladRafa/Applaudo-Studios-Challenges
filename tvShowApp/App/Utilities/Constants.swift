//
//  constantes.swift
//  tvShowApp
//
//  Created by Walter Bladimir Rafael on 22/2/21.
//



import UIKit

struct Constants {
    
    
    enum WS: String {
        case baseURL = "https://api.themoviedb.org/"
        case baseURLImages = "https://image.tmdb.org/t/p/original"
        case version = "3"
        case apiKey = "?api_key=b68961af4d3d28cedac86118400870be"
        case token = "/authentication/token/new"
        case auth = "/authentication/token/validate_with_login"
        case tvShows = "/tv/"
        case tvCast = "/credits"
        case account = "/account/"
        case watchList = "watchlist"
    }
    
    
    
    enum ErrorCode: Int {
        case Internet = 0
        case noInternet = 1
    }
    
    enum HTTPStatusCodes: Int {
        case OK = 200
        case BadRequest = 400
        case Unauthorized = 401
        case Forbidden = 403
        case NotFound = 404
        case InternalServerError = 500
    }
    
    enum HTTPMethodType: Int {
        case POST = 0
        case GET = 1
    }
    
    enum HTTPMethod: String {
        case POST = "POST"
        case GET = "GET"
    }
    
    struct App {
        // View Controllers
        static let login = "login"
        static let home = "home"
        static let detail = "detail"
        
        // Predefinied Global Texts
        static let GeneralErrorText = "Something was wrong, please try again!"
        static let NoInternetText = "No internet connection!"
        static let SesionErrorText = "The session has expired!"
        static let backButton = ""
        static let msgWarning = "Warning!"
        static let msgError = "Error!"
        static let msgInfo = "Info!"
        static let CerrarTitleBtn = "Got it"
        static let CerrarTitleBtn2 = "Close"
        static let cerrarSesionText = "Do you want close your session?"
        static let storyBoardIdentifier = "Main"
        static let loading = "Loading ..."

        
        // Icons
        static let logoPlaceholder = "placeHolder"
        static let filterImage = "filterImage"
        static let refresh = "refresh"
        static let logoHeader = "logoHeader"
        
        // Extra App Values
        static let shadowOpacity = Float(0.5)
        static let cornerRadius = CGFloat(2.0)
        static let border = CGFloat(0)
        static let dateFormatIn = "yyyy-MM-dd"
        static let dateFormatOut = "MMM d, yyyy"
        static let dateFormatInSession12 = "yyyy-MM-dd hh:mm:ss 'UTC'"
        static let dateFormatInSession24 = "yyyy-MM-dd HH:mm:ss 'UTC'"
    
        // PersistanceKey
        static let shows = "shows"
        
        // Realm Database Version
        static let bdVersion = 1
    }

  

    struct Login {
        static let msgCredentials = "Username and password are required!"
    }
    
    struct Home {
        static let invalid = "Your session has expired, please log in again!"
    }
    
    struct Detail {
        static let saveFav = "Do you want mark as favorite this TV Show?"
    }
}

