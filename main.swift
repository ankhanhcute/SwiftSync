import Foundation 
// 1. Define the Note model
// Codeable is use for encoded and decoded in here 
struct Note: Codable, Identifiable {
    let id: UUID
    var text: String 
    var modifiedAt: Date
}

// 2. Define where we should store our notes
let fileURL = URL(fileURLWithPath: "notes.json")
// 3. Prepare our JSON encoder and decoder.
// create an encoder for json
let encoder = JSONEncoder()
encoder.outputFormatting = [.prettyPrinted] // formate it to be readable
encoder.dateEncodingStrategy = .iso8601 // use a standard date format

let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601

do {
    // 4. Create an empty array of notes.
    var notes: [Note] = []
    // 5. Load existing notes if the file exists.
    if FileManager.default.fileExists(atPath: fileURL.path) {
        let data = try Data(contentsOf: fileURL)

        if let savedNotes = try? decoder.decode(
            [Note].self,
            from: data
        ) {
            notes = savedNotes
        } else {
            //Support the single note from our previous lesson
            let oldNote = try decoder.decode(
                Note.self,
                from: data
            )
            notes = [oldNote]
        }
        print("Loaded \(notes.count) existing notes.")
    }
    // 6. we will create the new note 
    let newNote = Note(
        id: UUID(),
        text: "learning data persistence!",
        modifiedAt: Date()
    )
    // 7. Add the new note to our array 
    notes.append(newNote)
    // 8. Save the updated collection 
    let jsonData = try encoder.encode(notes)
    try jsonData.write(to: fileURL, options: .atomic)

    // 9. We will display all the notes
    for note in notes {
        print("Note: \(note.text)")
    }
    print("Total notes: \(notes.count)")
} catch {
    print("Error: \(error)")
}