//
//  NoteStore.swift
//  SwiftSyncMac
//
//  Created by Truong Phan An Khanh on 10/1/26.
//

import Foundation

struct NoteStore {
    private let fileURL: URL //storing the location of our JSON file as a property
    //private mean only the code inside NoteStores can directrly access this property. Keep our storage implementation seperate from the rest of the application
    
    // an initializer prepares a new instance of notestore use it to create the folder in macOS application support directly and show where our notes should be save
    //throws mean its will report error if the folder cannot find
    init() throws {
        let directory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0].appendingPathComponent("SwiftSyncMac", isDirectory: true)
        
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true
        )
        
        fileURL = directory.appendingPathComponent("notes.json")
        
    }
    // reads files and return array of notes, if the file doesnt exists return an empty array
    func load() throws -> [Note] {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return []
        }
        let data = try Data(contentsOf: fileURL)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return try decoder.decode([Note].self, from: data)
    }
    // takes an array of notes, converts it into JSON and writes it into the disks
    func save(_ notes: [Note]) throws {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = [ .prettyPrinted]
        
        let data = try encoder.encode(notes)
        try data.write(to: fileURL, options: .atomic)
    }
}
