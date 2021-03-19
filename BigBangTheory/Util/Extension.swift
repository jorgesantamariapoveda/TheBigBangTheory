//
//  Extension.swift
//  BigBangTheory
//
//  Created by Jorge on 14/03/2021.
//

import UIKit

extension Notification.Name {

    static let toggleFavorite = Notification.Name("toggleFavorite")
    
}

func convertUIImageToData(image: UIImage, imageFormat: ImageFormat, compressionQualityJPG: CGFloat = 1) -> Data? {
    switch imageFormat {
    case .jpg:
        return image.jpegData(compressionQuality: compressionQualityJPG)
    case .png:
        return image.pngData()
    }
}
