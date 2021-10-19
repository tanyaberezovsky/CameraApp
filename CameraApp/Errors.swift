//
//  Errors.swift
//  CameraApp
//
//  Created by Tanya Berezovsky on 18/10/2021.
//

import Foundation

enum CustomErrors: Error {
    case failedToSavePhoto
    case failedToSaveVideo
    case failedToSaveThumbnail
    case fileIsEmpty
    case unknown
}

extension CustomErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .failedToSavePhoto:
            return NSLocalizedString("Failed to save photo.", comment: "error")
        case .failedToSaveVideo:
            return NSLocalizedString("Failed to save video.", comment: "error")
        case .failedToSaveThumbnail:
            return NSLocalizedString("Failed to save thumbnail.", comment: "error")
        case .fileIsEmpty:
            return NSLocalizedString("File is empty.", comment: "error")
        case .unknown:
            return NSLocalizedString("unknown error.", comment: "error")
        }
    }
}
