import SwiftUI


struct Translation: Identifiable, Codable {
    let id: UUID
    let originalText: String
    let translatedText: String

    init(id: UUID = UUID(), originalText: String, translatedText: String) {
        self.id = id
        self.originalText = originalText
        self.translatedText = translatedText
    }
}

struct HistoryView: View {
    @State private var history: [Translation] = []

    var body: some View {
        NavigationView {
            VStack {
                List(history) { translation in
                    VStack(alignment: .leading) {
                        Text("Original: \(translation.originalText)")
                            .fontWeight(.bold)
                        Text("Translated: \(translation.translatedText)")
                            .foregroundColor(.gray)
                    }
                }
                .navigationTitle("Translation History")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: clearHistory) {
                            Text("Clear All")
                        }
                    }
                }

//                Button("Add Dummy Translation") {
//                    let newTranslation = Translation(originalText: "Hello", translatedText: "Hola")
//                    history.append(newTranslation)
//                    saveHistory()
//                }
            }
        }
        .onAppear(perform: loadHistory)
    }

    private func saveHistory() {
        if let encoded = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(encoded, forKey: "TranslationHistory")
        }
    }

    private func loadHistory() {
        if let savedTranslations = UserDefaults.standard.data(forKey: "TranslationHistory"),
           let decodedTranslations = try? JSONDecoder().decode([Translation].self, from: savedTranslations) {
            history = decodedTranslations
        }
    }

    private func clearHistory() {
        history.removeAll()
        saveHistory()
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
