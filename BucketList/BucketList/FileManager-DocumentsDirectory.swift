//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by ADEBOLA AKEREDOLU on 10/12/23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
