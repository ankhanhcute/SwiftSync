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

    menuLoop: while true {
        print("\nSwiftSync")
        print("1. View all notes")
        print("2. Add a new note")
        print("3. Edit a note")
        print("4. Delete a note")
        print("5. Exit")
        print("Choose an option:")

        let choice = readLine() ?? ""

        switch choice {
            case "1":
            //Display all the saved notes
                for note in notes {
                    print("Note: \(note.text)")
            }
                print("Total notes: \(notes.count)")
            case "2":
                // Ask the user to create the notes
                print("Enter your new note:")

                if let text = readLine(), !text.isEmpty {
                    let newNote = Note (
                        id: UUID(),
                        text: text,
                        modifiedAt: Date()
                    )
                    notes.append(newNote)
                    
                    let jsonData = try encoder.encode(notes)
                    try jsonData.write(
                        to: fileURL, 
                        options: .atomic
                    )
                    print("Note saved successfully!")
                } else {
                    print("Empty note. Nothing was save")
                }
            case "3":
                print("Editing is coming next!")
            case "4": 
                print("Deletion is coming next!")
            case "5":
                print("Goodbye!")
                break menuLoop
            default:
                print("Invalid option. Try again")
        }
    }
} catch {
    print("Error: \(error)")
}