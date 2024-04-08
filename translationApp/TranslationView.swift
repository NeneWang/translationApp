//
//  TranslationView.swift
//  translationApp
//
//  Created by Nene Wang  on 4/6/24.
//

import Foundation
import SwiftUI

struct TranslationView: View {
    
    @State private var sourceLanguageIndex = 0
    @State private var targetLanguageIndex = 1
    @State private var inputText = ""
    @State private var outputText = ""
    @State private var history: [Translation] = []
    
    @State private var inputCount = 0
    @State private var outputCount = 0
    
    let language = ["English", "German", "Spanish", "Italian", "Rusia", "Arabic"]
    
    var body: some View {
        VStack{
            ZStack{
                Color("color")
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    HStack{
                        
                        Spacer()
                        Text("Text Translation")
                            .font(.system(size: 25))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }
                    VStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 373, height: 1)
                            .background(.white.opacity(0.33))
                    }
                    HStack{
                        
                        Picker("Source Language", selection: $sourceLanguageIndex){
                            ForEach(0..<language.count, id: \.self){
                                index in
                                Text(language[index])
                            }
                            
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding()
                        
                        Image(systemName: "arrow.left.arrow.right")
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                        
                        Picker("target Language", selection: $targetLanguageIndex){
                            ForEach(0..<language.count, id: \.self){
                                index in
                                Text(language[index])
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding()
                    }
                    VStack{
                        ZStack{
                            Rectangle()
                                .frame(width: 373, height: 208)
                                .background(Color(red: 0.14, green: 0.15, blue: 0.15))
                                .cornerRadius(22)
                            VStack{
                                Rectangle().frame(width: 373, height: 1)
                                
                                HStack{
                                    Text("\(inputCount)/500")
                                        .font(Font.custom("Inter", size: 20))
                                        .foregroundColor(.white.opacity(0.43))
                                        .offset(x: -90, y: 60)
                                    Button{
                                        
                                    } label: {
                                        Image(systemName: "pencil.line")
                                            .frame(width: 18, height: 18)
                                            .foregroundColor(.white)
                                            .offset(x: 90, y: 60)
                                    }
                                    
                                }
                                
                                TextField("Enter Text", text: $inputText)
                                    .font(Font.custom("Inter", size: 17))
                                    .foregroundColor(.white)
                                    .offset(x: 45, y: -65)
                            }
                        }
                        Button("Translation", action: translationText)
                            .padding()
                    }
                    VStack{
                        Text("Translation From English")
                            .font(
                                Font.custom("Inter", size: 17)
                                    
                            )
                        ZStack{
                            Rectangle()
                                .frame(width: 373, height: 208)
                                .background(Color(red: 0.14, green: 0.15, blue: 0.15))
                                .cornerRadius(22)
                            VStack{
                                Rectangle().frame(width: 373, height: 1)
                                
                                HStack{
                                    Text("\(outputCount)/500")
                                        .font(Font.custom("Inter", size: 20))
                                        .foregroundColor(.white.opacity(0.43))
                                        .offset(x: -90, y: 60)
                                    Button{
                                        
                                    } label: {
                                        Image(systemName: "pencil.line")
                                            .frame(width: 18, height: 18)
                                            .foregroundColor(.white)
                                            .offset(x: 90, y: 60)
                                    }
                                    
                                }
                                
                                TextField("Enter Text", text: $outputText)
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .offset(x: 45, y: -65)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func translationText(){
        let sourceLanguage = language[sourceLanguageIndex]
        let targetLanguage = language[targetLanguageIndex]
        
        translationWithAPI(inputText: inputText, sourceLanguage: sourceLanguage, targetLanguage: targetLanguage)
        
    }
    
    func translationWithAPI(inputText: String, sourceLanguage: String, targetLanguage: String){
        inputCount = inputText.count
        
        
        loadHistory()
        let translations = [
            "Hello": ["German": "Hallo", "Spanish": "Hola"],
            "How Are You": ["German": "Wie geht es dir", "Spanish": "Cómo estás"],
            "Airplane": ["German": "Flugzeug", "Spanish": "Avión"],
            "Goodbye": ["German": "Auf Wiedersehen", "Spanish": "Adiós"],
            "Thank You": ["German": "Danke", "Spanish": "Gracias"]
        ]
        
        if let translation = translations[inputText]?[targetLanguage]{
            outputText = translation
            addToHistory(originalText: inputText, translated: translation)
            outputCount = outputText.count
        }else{
            outputText = "Translation not found."
            outputCount = outputText.count
        }
        
    }
    
    
    private func addToHistory(originalText: String, translated: String) {
        let newTranslation = Translation(originalText: originalText, translatedText: translated)
        history.append(newTranslation)
        
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
}


#Preview {
    TranslationView()
}




