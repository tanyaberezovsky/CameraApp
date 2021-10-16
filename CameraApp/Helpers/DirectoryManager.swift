//
//  MediaDirectory.swift
//  CameraApp
//
//  Created by Tanya Berezovsky on 16/10/2021.
//

import Foundation

protocol DirectoryManagerProtocol {
    func filePath(_ filename: String, _ fileExtension: String) -> URL
}

struct DirectoryManager {
    private var rootDir: URL
    
    init(rootDir: URL = Constants.mediaRootDir) {
        self.rootDir = rootDir
    }
}

extension DirectoryManager: DirectoryManagerProtocol {
    
    func filePath(_ filename: String, _ fileExtension: String) -> URL {
        let fileFullName = "\(filename).\(fileExtension)"
        return rootDir.appendingPathComponent(fileFullName)
    }
}

