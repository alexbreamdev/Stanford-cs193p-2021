//
//  ContentView.swift
//  Assignment Lecture 2
//
//  Created by Oleksii Leshchenko on 18.04.2023.
//

import SwiftUI

struct ContentView: View {
    private var vehicles: [String] = ["✈️", "🚅", "🛳️", "🚀", "🚞", "🛫", "🚆", "⛵️", "🚐", "🚑", "🚒", "🚙"]
    
    private var fruits: [String] = ["🍑", "🍌", "🍊", "🍎", "🍓", "🍍", "🍒", "🥑"]
    
    private var deck: [String] = ["🃏", "🂠", "🂡", "🂣", "🂤", "🂥", "🂦", "🂧", "🂨", "🂩", "🂪", "🂬"]
    
    @State var column: GridItem = GridItem(.adaptive(minimum: 100, maximum: 100))

    @State private var itemsArray: [String] = [String](repeating: "", count: 4)
    @State private var randomLength: Int = 4
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: [column], spacing: 8) {
                        ForEach(itemsArray[0..<randomLength], id: \.self) { item in
                            CardView(content: item)
                                .aspectRatio(2/3, contentMode: .fit)
                                .frame(width: rectangleSize(), height: rectangleSize())
                        }
                    }
                }
                .padding(.bottom, 20)
            }
            .padding(.horizontal)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Memorize!")
                            .font(.largeTitle)
                    }
                    .padding(.vertical)
                        
                }
            }
            .safeAreaInset(edge: .bottom) {
                themeControl
                    .frame(height: 55)
            }
        }
        .onAppear {
            randomLength = Int.random(in: 4...vehicles.count - 1)
            itemsArray = vehicles.shuffled()
        }
    }
    
    private var themeControl: some View {
        HStack(alignment: .bottom) {
            ThemeButton(iconName: "car.side.fill", title: "Cars") {
                randomLength = Int.random(in: 4...vehicles.count)
                itemsArray = vehicles.shuffled()
            }
            
            Spacer()
            
            ThemeButton(iconName: "basket.fill", title: "Fruits") {
                randomLength = Int.random(in: 4...fruits.count)
                itemsArray = fruits.shuffled()
            }
            
            Spacer()
            
            ThemeButton(iconName: "circle.square.fill", title: "Deck") {
                randomLength = Int.random(in: 4...deck.count)
                itemsArray = deck.shuffled()
            }
        }
        .frame(maxWidth: 500)
        .padding(.horizontal, 40)
    }
    
    func rectangleSize() -> CGFloat {
           let padding: CGFloat = 8 // Spacing between rectangles in the grid
        let availableWidth = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height - 50) // Total available width for rectangles
           let itemCount: CGFloat = 2 // Number of items in each row
           let itemWidth = (availableWidth - (itemCount + 1) * padding - 60) / itemCount // Width of each item

           return itemWidth // Size of each rectangle
       }
}

struct ThemeButton: View {
    let iconName: String
    let title: String
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            VStack(spacing: 5) {
                Image(systemName: iconName)
                    .font(.largeTitle)
                Text(title)
            }
        }
    }
}

struct CardView: View {
    var content: String
    @State private var isFaceUp: Bool = true
    @State private var degree: Double = 0
    
    var body: some View {
        ZStack {
            let cardShape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                cardShape
                    .fill()
                    .foregroundColor(.primary)
                    .colorInvert()
                
                cardShape
                    .strokeBorder(lineWidth: 3)
                    .foregroundColor(.blue)
                
                Text(content)
                    .font(.title)
            } else {
                cardShape.fill(.blue)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
