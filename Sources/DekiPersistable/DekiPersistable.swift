// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public protocol DekiPersistable: Codable {
    func save(fileName: String?) async throws
    static func load(fileName: String?) async throws -> Self
    static func delete(fileName: String?) async throws
}

public extension DekiPersistable {
    func save(fileName: String? = nil) async throws {
        let fileName = fileName ?? String(describing: type(of: self))
        let url = URL.urlOnDocumentsDirectory(fileName: fileName)
        let encoded = try JSONEncoder().encode(self)
        try encoded.write(to: url)
    }
    
    static func load(fileName: String? = nil) async throws -> Self {
        let fileName = fileName ?? String(describing: Self.self)
        let url = URL.urlOnDocumentsDirectory(fileName: fileName)
        let data = try Data(contentsOf: url)
        let decoded = try JSONDecoder().decode(Self.self, from: data)
        return decoded
    }
    
    static func delete(fileName: String? = nil) async throws {
        let fileName = fileName ?? String(describing: Self.self)
        let url = URL.urlOnDocumentsDirectory(fileName: fileName)
        try FileManager.default.removeItem(at: url)
    }
}

extension URL {
    static func urlOnDocumentsDirectory(fileName: String) -> URL {
        if #available(iOS 16.0, *) {
            return URL.documentsDirectory.appendingPathExtension(fileName)
        } else {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            return documentsDirectory.appendingPathExtension(fileName)
        }
    }
}
