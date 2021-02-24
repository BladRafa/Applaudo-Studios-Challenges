//
//  ShowViewVM.swift
//  tvShowApp
//
//  Created by Walter Bladimir Rafael on 23/2/21.
//


import UIKit

protocol ShowViewVMRepresentable {
    // Output
    var showImageUrl: String { get }
    var name: String { get }
    var airdate: String { get }
    var rating: String { get }
    var description: String { get }
    
    // Input
    func showViewPressed()
    
    // Event
    var showSelected: () -> () { get }
}


class ShowViewVM: ShowViewVMRepresentable {
    // Output
    var showImageUrl: String = ""
    var name: String = ""
    var airdate: String = ""
    var rating: String = ""
    var description: String = ""
    
    // Data Model
    private var show: Show!
    
    // Event
    var showSelected: () -> () = { }
    
    init(show: Show) {
        self.show = show
        configureOutput()
    }
    
    private func configureOutput() {
        showImageUrl = "\(Constants.WS.baseURLImages.rawValue)\(show.posterPath ?? "")"
        name = show.name ?? ""
        airdate = show.firstAirDate?.dateFormat(formatIn: Constants.App.dateFormatIn, formatOut: Constants.App.dateFormatOut) ?? ""
        let avg = Int((show.voteAverage ?? 1) * 10)
        rating = "Rated: \(avg) %"
        description = show.overview ?? ""
    }
    
    func showViewPressed() {
        showSelected()
    }
}
