//
//  ButtonsSearch.swift
//  GlobalMusic
//
//  Created by Ramirez Luis on 06/07/2021.
//

import SwiftUI

struct ButtonsSearch: View {
    var body: some View {
        HStack {
            Button(action: {
            }) {
                Text("Cancel")
            }
            .font(.system(size: 18))
            .padding(.trailing, 10)
            .padding(.horizontal, 30)
            .transition(.move(edge: .trailing))
            .animation(.default)
            
            Button(action: {
            }) {
                Text("Search")
            }
            .font(.system(size: 18))
            .padding(.trailing, 10)
            .padding(.horizontal, 30)
            .transition(.move(edge: .trailing))
            .animation(.default)
        }
        .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .center)
    }
}

struct ButtonsSearch_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsSearch()
    }
}
