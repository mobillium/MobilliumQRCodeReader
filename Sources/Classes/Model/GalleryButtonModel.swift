//
//  GalleryButtonModel.swift
//  MobilliumQRCodeReader
//
//  Created by Murat Celebi on 31.03.2022.
//

public struct GalleryButtonModel {
    public let title: String?
    public let titleColor: UIColor
    public let font: UIFont
    public let backgroundColor: UIColor
    public let cornerRadius: CGFloat
    public let isHidden: Bool
    
    public init(title: String? = "Choose from Gallery",
                titleColor: UIColor = .systemBlue,
                font: UIFont = .systemFont(ofSize: 14, weight: .semibold),
                backgroundColor: UIColor = .white,
                cornerRadius: CGFloat = 8,
                isHidden: Bool = false) {
        self.title = title
        self.titleColor = titleColor
        self.font = font
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.isHidden = isHidden
    }
}
