//
//  Extensions.swift
//  ReusableCarousel
//
//  Created by Noel Obaseki on 27/07/2022.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadImage(imageUrl: String, Placeholder: UIImage) {
        DispatchQueue.global(qos: .background).async {
            do{
                guard let url = URL(string: imageUrl) else {
                    self.image = Placeholder
                    return
                }
                if let imageData = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        if let loadedImage = UIImage(data: imageData) {
                            self.image = loadedImage
                        }
                    }
                } else {
                    self.image = Placeholder
                }
            }
        }
    }
}
