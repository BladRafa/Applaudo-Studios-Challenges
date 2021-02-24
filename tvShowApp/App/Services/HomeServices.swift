//
//  HomeServices.swift
//  tvShowApp
//
//  Created by Walter Bladimir Rafael on 22/2/21.
//

import UIKit

struct TVShowsWS {
    
    func getTVShows(completion: @escaping ([Show]?, _ error: Error?)->()) {
        
        let url = Constants.WS.baseURL.rawValue + Constants.WS.version.rawValue + Constants.WS.tvShows.rawValue + AppData.sharedData.showTypeSelected.rawValue + Constants.WS.apiKey.rawValue
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil, error)
                return
            }
            
            var results = data["results"] as! [[String : Any]]
            var resultsCast:[[String : Any]] = [[String : Any]]()
            var resultsDetail:[[String : Any]] = [[String : Any]]()
            var dataReceivedCount = 0
            
            for show in results {
                self.getTVShowsDetail(id: "\(show["id"] ?? "")", completion: { (detail, error) in
                    
                    guard error == nil else {
                        completion(nil, error)
                        return
                    }
                    // Adding response to our detail array
                    resultsDetail.append(detail!)
                    
                    self.getTVShowsCast(id: "\(show["id"] ?? "")", completion: { (cast, error) in
                        
                        guard error == nil else {
                            completion(nil, error)
                            return
                        }
                        // Adding response to our cast array
                        resultsCast.append(cast!)
                        
                        // Increment our counter for general requests
                        dataReceivedCount+=1
                        
                        // Validate if complements (Casts & Details) of each show are completed
                        guard dataReceivedCount == results.count else { return }
                        
                        // Assign complements to respective Show
                        var index = 0
                        for show in results {
                            resultsCast.forEach({ (_ cast) in
                                if show["id"] as! Int == cast["id"] as! Int {
                                    results[index]["cast"] = cast["cast"]
                                    resultsDetail.forEach({ (_ detail) in
                                        if show["id"] as! Int == detail["id"] as! Int {
                                            results[index]["detail"] = detail
                                        }
                                    })
                                }
                            })
                            index+=1
                        }
                        // Return show array
                        completion(self.showsListFrom(results: results), nil)
                    })
                })
            }
        }
    }
    
    func getTVShowsDetail(id:String,completion: @escaping ([String:Any]?,_ error: Error?)->()) {
        
        let url = Constants.WS.baseURL.rawValue + Constants.WS.version.rawValue + Constants.WS.tvShows.rawValue + id + Constants.WS.apiKey.rawValue
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(data,nil)
        }
    }
    
    func getTVShowsCast(id:String,completion: @escaping ([String:Any]?,_ error: Error?)->()) {
        
        let url = Constants.WS.baseURL.rawValue + Constants.WS.version.rawValue + Constants.WS.tvShows.rawValue + id + Constants.WS.tvCast.rawValue + Constants.WS.apiKey.rawValue
        RequestManager.sharedService.requestAPI(url: url, parameter: nil, httpMethodType: .GET) { (response, error) in
            
            guard let data = response else {
                completion(nil,error)
                return
            }
            completion(data,nil)
        }
    }
    
    private func showsListFrom(results: [[String: Any]]) -> [Show] {
        var shows = [Show]()
        for show in results {
            shows.append(Show(attributes: show))
        }
        return shows
    }
}



