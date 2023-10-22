//
//  FileManager-Decodable.swift
//  BucketList
//
//  Created by ADEBOLA AKEREDOLU on 10/11/23.
//

import Foundation

extension FileManager {
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        return paths[0]
    }

    func decode(_ file: String) -> String {
        let url = getDocumentsDirectory().appendingPathComponent(file)
        guard let content = try? String(contentsOf: url) else {
            return ""
        }
        return content
    }
}
