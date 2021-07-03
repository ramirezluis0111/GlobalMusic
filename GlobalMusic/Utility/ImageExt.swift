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
        
        let data: Data = try! Data(contentsOf: url)
        
        return UIImage(data: data) ?? UIImage()
    }
}
