//
//  FileManager-DocumentsDirectory.swift
//  Meetup
//
//  Created by ADEBOLA AKEREDOLU on 10/15/23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
