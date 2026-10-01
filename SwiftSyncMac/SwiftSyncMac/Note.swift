//
//  Note.swift
//  SwiftSyncMac
//
//  Created by Truong Phan An Khanh on 10/1/26.
//

import Foundation

struct Note: Codable, Identifiable {
    let id: UUID
    var text: String
    var modifiedAt: Date
}

