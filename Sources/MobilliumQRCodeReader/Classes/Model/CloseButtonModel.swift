//
//  CloseButtonModel.swift
//  MobilliumQRCodeReader
//
//  Created by Murat Celebi on 31.03.2022.
//

public struct CloseButtonModel {
    public let image: UIImage
    public let tintColor: UIColor
    public let isHidden: Bool
    
    public init(image: UIImage = ImageProvider.getCloseImage(),
                tintColor: UIColor = .white,
                isHidden: Bool = false) {
        self.image = image
        self.tintColor = tintColor
        self.isHidden = isHidden
    }
}
