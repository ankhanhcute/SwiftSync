//
//  ContentView.swift
//  SwiftSyncMac
//
//  Created by Truong Phan An Khanh on 10/1/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var noteText = "Learning Swift!"
    @
    
    var body: some View {
        
        NavigationSplitView {
            // Left sidebar
            List {
                Label("My Notes", systemImage: "note.text")
                Text(noteText)
            }
            .navigationTitle("SwiftSync")
            .frame(minWidth: 200)
            
        } detail: {
            
            //Right editor
            VStack(alignment: .leading, spacing: 15) {
                
                Text("My first note")
                    .font(.title)
                    .bold()
                TextEditor(text: $noteText)
                    .font(.body)
                
                Text("Demo only, not save yet")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .frame(minWidth: 450, minHeight: 400)
        }
    }
}
#Preview {
    ContentView()
}

