//
//  FileNameConverter.swift
//  CameraApp
//
//  Created by Tanya Berezovsky on 17/10/2021.
//

import Foundation

struct FileNameConverter {
    private var fileNameWithTimeStamp: String
     
    init(_ fileNameWithTimeStamp: String){
        self.fileNameWithTimeStamp = fileNameWithTimeStamp
    }
    
    public func description() -> String {
        return createdDate?.toString(formatter: .long) ?? ""
    }
    
    private var createdDate: Date? {
        
        guard let timeStamp = timeStamp else {
            return nil
        }
        return Date(timeIntervalSince1970: timeStamp)
    }
    
    private var timeStamp: TimeInterval? {
        
        var components = fileNameWithTimeStamp.components(separatedBy: ".")
        guard
            components.count > 1
        else {
            return nil
        }
        components.removeLast()
        
        guard let timeStamp = TimeInterval(components.joined(separator: ".")) else {
            return nil
        }
        return timeStamp
    }
}
