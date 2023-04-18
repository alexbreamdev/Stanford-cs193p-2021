//
//  ContentView.swift
//  Memorize
//
//  Created by Oleksii Leshchenko on 16.04.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var emojis: Array<String> = ["✈️", "🚅", "🛳️", "🚀", "🚞", "🛫", "🚆", "⛵️", "🚐", "🚑", "🚒", "🚙"]
    @State private var emojiCount = 4
    
    var body: some View {
        // MARK: - ViewBuilder combines list of views in one view and returns it in tuple view
        
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))], spacing: 8) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
                .foregroundColor(.red)
            }
            
            Spacer()
            
            HStack {
                remove
                Spacer()
                add
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    
    // MARK: - Subviews
    private var remove: some View {
        Button {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
                .font(.largeTitle)
        }
    }
    
    private var add: some View {
        Button {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        } label: {
            Image(systemName: "plus.circle")
                .font(.largeTitle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 14")
            ContentView()
                .previewDisplayName("Dark Mode")
                .preferredColorScheme(.dark)
        }
    }
}

struct CardView: View {
    var content: String
    @State private var isFaceUp: Bool = true
    @State private var degree: Double = 0
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape
                    .fill()
                    .foregroundColor(.primary)
                    .colorInvert()
                // stroke vs strokeBorder
                // stroke loses half of width while in another container
                shape.strokeBorder(lineWidth: 3)
                
                Text(content)
                    .font(.largeTitle)
                
            } else {
                shape.fill()
            }
        }
        .rotation3DEffect(.degrees(degree), axis: (x: 0, y: 1, z: 0), anchor: .center)
        .onTapGesture {
            withAnimation {
                isFaceUp.toggle()
                degree = degree == 0 ? 180 : 0
            }
        }
    }
}
