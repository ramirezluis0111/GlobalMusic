//
//  ImageExt.swift
//  GlobalMusic
//

import Foundation
import UIKit
import SwiftUI

func InitImage(url: String) -> UIImage{
    do {
        guard let url = URL(string: url) else {
            return UIImage()
        }

        let data = try? Data(contentsOf: url ) 
        
        if data == nil {
            return UIImage()
        } else {
            return UIImage(data: data!)!
        }
    
    }
}
