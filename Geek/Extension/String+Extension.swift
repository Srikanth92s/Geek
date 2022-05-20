//
//  String+Extension.swift
//  Geek
//
//  Created by Srikanth S on 20/05/22.
//

import Foundation
extension String {
    func formatDate() -> String {
        let dateFormatterGet = DateFormatter()
              dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
              
              let dateFormatterPrint = DateFormatter()
              dateFormatterPrint.dateFormat = "E, d MMM yyyy HH:mm:ss"
              
              let date: Date? = dateFormatterGet.date(from: self)
              
              return dateFormatterPrint.string(from: date ?? Date())
    }
}
