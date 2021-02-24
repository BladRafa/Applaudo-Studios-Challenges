//
//  String.swift
//  tvShowApp
//
//  Created by Walter Bladimir Rafael on 22/2/21.
//

import UIKit

extension String {
    
    func dateFormat(formatIn:String, formatOut:String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = formatIn
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = formatOut
        if let date = dateFormatterGet.date(from: self) {
            return dateFormatterPrint.string(from: date)
        }
        return ""
    }
    
    func toDate() -> Date {
        let formatString = DateFormatter.dateFormat(fromTemplate: self, options: 0, locale: Locale.current)!
        let format12hours = formatString.contains("a")
        var format:String = Constants.App.dateFormatInSession24
        if format12hours {
            format = Constants.App.dateFormatInSession12
        }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "UTC")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else {
            preconditionFailure("Take a look to your format")
        }
        return date
    }
}
