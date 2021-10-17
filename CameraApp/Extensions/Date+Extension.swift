//
//  String+Extension.swift
//  CameraApp
//
//  Created by Tanya Berezovsky on 16/10/2021.
//

import Foundation

public extension Date {
     func toString(formatter: DateFormatter) -> String {
            return formatter.string(from: self)
    }
}

public extension DateFormatter {
    static let long: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        return dateFormatter
    }()
}
