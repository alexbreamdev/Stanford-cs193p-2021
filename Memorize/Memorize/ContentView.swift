//
//  ContentView.swift
//  Memorize
//
//  Created by Oleksii Leshchenko on 16.04.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // MARK: - ViewBuilder combines list of views in one view and returns it in tuple view
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 3)
            
            Text("🚜")
        }
        .padding(.horizontal)
        .foregroundColor(.red) // puts color on all views in zstack
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
