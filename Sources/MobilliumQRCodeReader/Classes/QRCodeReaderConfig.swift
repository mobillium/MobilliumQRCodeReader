//
//  QrReaderDataModel.swift
//  MobilliumQRCodeReader
//
//  Created by Murat Celebi on 29.03.2022.
//

import UIKit

public struct QRCodeReaderConfig {
    public let closeButton: CloseButton
    public let infoLabel: InfoLabel
    public let galleryButton: GalleryButton
    public let previewLayer: PreviewLayer
    public let settingsAlert: SettingsAlert
    
    public init(closeButton: CloseButton = CloseButton(),
                infoLabel: InfoLabel = InfoLabel(),
                galleryButton: GalleryButton = GalleryButton(),
                previewLayer: PreviewLayer = PreviewLayer(),
                settingsAlert: SettingsAlert = SettingsAlert()) {
        self.closeButton = closeButton
        self.infoLabel = infoLabel
        self.galleryButton = galleryButton
        self.previewLayer = previewLayer
        self.settingsAlert = settingsAlert
    }
}

// MARK: - InfoLabel
extension QRCodeReaderConfig {
    
    public struct InfoLabel {
        public let text: String?
        public let textColor: UIColor
        public let font: UIFont
        public let isHidden: Bool
        
        public init(text: String? = nil,
                    textColor: UIColor = .white,
                    font: UIFont = .systemFont(ofSize: 14),
                    isHidden: Bool = false) {
            self.text = text
            self.textColor = textColor
            self.font = font
            self.isHidden = isHidden
        }
    }
}

// MARK: - CloseButton
extension QRCodeReaderConfig {
    
    public struct CloseButton {
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
}

// MARK: - GalleryButton
extension QRCodeReaderConfig {
    
    public struct GalleryButton {
        public let title: String?
        public let titleColor: UIColor
        public let font: UIFont
        public let backgroundColor: UIColor
        public let cornerRadius: CGFloat
        public let isHidden: Bool
        public let height: CGFloat
        
        public init(title: String? = "Choose from Gallery",
                    titleColor: UIColor = .systemBlue,
                    font: UIFont = .systemFont(ofSize: 14, weight: .semibold),
                    backgroundColor: UIColor = .white,
                    cornerRadius: CGFloat = 8,
                    isHidden: Bool = false,
                    height: CGFloat = 32) {
            self.title = title
            self.titleColor = titleColor
            self.font = font
            self.backgroundColor = backgroundColor
            self.cornerRadius = cornerRadius
            self.isHidden = isHidden
            self.height = height
        }
    }
}

// MARK: - PreviewLayer
extension QRCodeReaderConfig {
    
    public struct PreviewLayer {
        public let backgroundColor: CGColor
        public let lineWidth: CGFloat
        public let lineColor: UIColor
        public let marginSize: CGFloat
        public let cornerRadius: CGFloat
        public let lineDashPattern: [NSNumber]?
        
        public init(backgroundColor: CGColor = UIColor.gray.withAlphaComponent(0.3).cgColor,
                    lineWidth: CGFloat = 4,
                    lineColor: UIColor = .white,
                    marginSize: CGFloat = 32,
                    cornerRadius: CGFloat = 24,
                    lineDashPattern: [NSNumber]? = [25, 10]) {
            self.backgroundColor = backgroundColor
            self.lineWidth = lineWidth
            self.lineColor = lineColor
            self.marginSize = marginSize
            self.cornerRadius = cornerRadius
            self.lineDashPattern = lineDashPattern
        }
    }
}

// MARK: - SettingsAlert
extension QRCodeReaderConfig {
    
    public struct SettingsAlert {
        public let title: String?
        public let message: String?
        public let actionButtonTitle: String?
        public let cancelButtonTitle: String?
        
        public init(title: String? = nil,
                    message: String? = "Go to Settings?",
                    actionButtonTitle: String? = "Settings",
                    cancelButtonTitle: String? = "Cancel") {
            self.title = title
            self.message = message
            self.actionButtonTitle = actionButtonTitle
            self.cancelButtonTitle = cancelButtonTitle
        }
    }

}

