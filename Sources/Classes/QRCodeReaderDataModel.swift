//
//  QrReaderDataModel.swift
//  MobilliumQRCodeReader
//
//  Created by Murat Celebi on 29.03.2022.
//

import UIKit

public struct QRCodeReaderDataModel {
    let backgroundColor: CGColor
    let closeButtonImage: UIImage
    let closeButtonTintColor: UIColor
    let isShowsCloseButton: Bool
    let galleryButtonTitle: String?
    let galleryButtonTitleColor: UIColor
    let galleryButtonFont: UIFont
    let galleryButtonBackgroundColor: UIColor
    let galleryButtonCornerRadius: CGFloat
    let isShowsGalleryButton: Bool
    let infoText: String?
    let infoTextColor: UIColor
    let infoTextFont: UIFont
    let lineWidth: CGFloat
    let lineColor: UIColor
    let marginSize: CGFloat
    let cornerRadiuesSize: CGFloat
    let lineDashPattern: [NSNumber]?
    
    public init(backgroundColor: CGColor = UIColor.gray.withAlphaComponent(0.3).cgColor,
                closeButtonImage: UIImage = ImageProvider.getCloseImage(),
                closeButtonTintColor: UIColor = .white,
                isShowsCloseButton: Bool = true,
                infoText: String? = nil,
                infoTextColor: UIColor = .white,
                infoTextFont: UIFont = .systemFont(ofSize: 14),
                galleryButtonTitle: String? = "Choose from Gallery",
                galleryButtonTitleColor: UIColor = .systemBlue,
                galleryButtonFont: UIFont = .systemFont(ofSize: 14, weight: .semibold),
                galleryButtonBackgroundColor: UIColor = .white,
                galleryButtonCornerRadius: CGFloat = 8,
                isShowsGalleryButton: Bool = true,
                lineWidth: CGFloat = 4,
                lineColor: UIColor = .white,
                marginSize: CGFloat = 32,
                cornerRadiuesSize: CGFloat = 24,
                lineDashPattern: [NSNumber]? = [25, 10]) {
        self.backgroundColor = backgroundColor
        self.closeButtonImage = closeButtonImage
        self.closeButtonTintColor = closeButtonTintColor
        self.isShowsCloseButton = isShowsCloseButton
        self.infoText = infoText
        self.infoTextColor = infoTextColor
        self.infoTextFont = infoTextFont
        self.galleryButtonTitle = galleryButtonTitle
        self.galleryButtonTitleColor = galleryButtonTitleColor
        self.galleryButtonFont = galleryButtonFont
        self.galleryButtonBackgroundColor = galleryButtonBackgroundColor
        self.galleryButtonCornerRadius = galleryButtonCornerRadius
        self.isShowsGalleryButton = isShowsGalleryButton
        self.lineWidth = lineWidth
        self.lineColor = lineColor
        self.marginSize = marginSize
        self.cornerRadiuesSize = cornerRadiuesSize
        self.lineDashPattern = lineDashPattern
    }
}
