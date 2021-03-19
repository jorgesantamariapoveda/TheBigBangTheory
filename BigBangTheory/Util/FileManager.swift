//
//  FileManager.swift
//  BigBangTheory
//
//  Created by Jorge on 14/03/2021.
//

import UIKit

// MARK: - Public functions

func saveImageCache(image: UIImage, imageName: String, imageFormat: ImageFormat) {
    guard let documents = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
        return
    }
    let fichero = documents.appendingPathComponent(imageName).appendingPathExtension(imageFormat.rawValue)
    DispatchQueue.global(qos: .background).async {
        do {
            if let data = convertUIImageToData(image: image, imageFormat: imageFormat) {
                try data.write(to: fichero, options: [.atomicWrite, .completeFileProtection])
            } else {
                print("Problem generating the data")
            }
        } catch {
            print("Error in saveImageCache \(error)")
        }
    }
}

func loadImageCache(imageName: String, imageFormat: ImageFormat) -> UIImage? {
    guard let documents = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
        return nil
    }
    let fichero = documents.appendingPathComponent(imageName).appendingPathExtension(imageFormat.rawValue)
    if FileManager.default.fileExists(atPath: fichero.path) {
        do {
            let imageData = try Data(contentsOf: fichero)
            return UIImage(data: imageData)
        } catch {
            print("Error in loadImageCache \(error)")
        }
    }
    return nil
}
