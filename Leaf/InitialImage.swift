//
//  InitialImage.swift
//  Leaf
//
//  Created by Mohamed Atallah on 15/10/2025.
//

import SwiftUI

struct InitialImage: View {
    let text: String
    
    var body: some View {
        Text(initials(from: text))
            .foregroundStyle(.white)
            .font(.title)
            .fontWeight(.semibold)
            .frame(width: 90, height: 90)
            .background(
                Circle()
                    .foregroundStyle(.green)
                    .opacity(0.8)
            )
    }
    
    private func initials(from text: String) -> String {
        var inital = ""
        let initialArray = text.components(separatedBy: " ")
        if let firstWrod = initialArray.first {
            if let firstChar = firstWrod.first {
                inital.append(firstChar)
            }
        }
        
        if let lastWord = initialArray.last {
            if let firstChar = lastWord.first {
                inital.append(firstChar)
            }
        }
        
        return inital
    }
}

#Preview {
    InitialImage(text: "Salma Mostafa")
}
