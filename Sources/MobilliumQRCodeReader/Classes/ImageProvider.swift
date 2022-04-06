//
//  ImageProvider.swift
//  MobilliumQRCodeReader
//
//  Created by Murat Celebi on 30.03.2022.
//

import UIKit

public class ImageProvider {

    // for any image located in bundle where this class has built
    public static func image(named: String) -> UIImage? {
        return UIImage(named: named, in: Bundle(for: self), compatibleWith: nil)
    }
    
    public static func getCloseImage() -> UIImage {
        return image(named: "ic_close") ?? UIImage()
    }
}
