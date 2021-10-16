//
//  String+Extension.swift
//  CameraApp
//
//  Created by Tanya Berezovsky on 16/10/2021.
//

import Foundation

extension String {
    public func appedTimestamp() -> String {
        let timestamp = NSDate().timeIntervalSince1970
        return "\(self)_\(timestamp)"
    }
}
