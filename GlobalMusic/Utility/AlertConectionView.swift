//
//  AlertConectionView.swift
//  GlobalMusic
//
//  Created by Ramirez Luis on 04/07/2021.
//

import SwiftUI

struct AlertConectionView: View {
    var body: some View {
        ZStack {
            ZStack {
                Color.white
            }
            .clipped()
            .ignoresSafeArea(.all)
            .opacity(0.9)
            
            RoundedRectangle(cornerRadius: 25.0)
                .frame(width: UIScreen.main.bounds.width / 1.3,
                       height: UIScreen.main.bounds.height / 4,
                       alignment: .center)
                .foregroundColor(Color.init(hexStringToUIColor(hex: "#FFFFFF")))
                .shadow(color: Color.init(hexStringToUIColor(hex: "#D6D6D6")),
                        radius: 8, x: 0.0, y: 0.0)
            
            VStack {
                Image(systemName: "xmark.icloud")
                    .foregroundColor(.gray)
                    .font(.system(size: 60))
                    .padding(.vertical, 10)
                Text("Ups! We have one drawback")
                    .font(.system(size: 20))
                    .foregroundColor(.red)
                    .padding(.vertical, 10)
                Text("Please retry later")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
            }
            
        }
    }
}

struct AlertConectionView_Previews: PreviewProvider {
    static var previews: some View {
        AlertConectionView()
    }
}
