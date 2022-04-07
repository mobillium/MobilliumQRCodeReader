//
//  QrReaderDataModel.swift
//  MobilliumQRCodeReader
//
//  Created by Murat Celebi on 29.03.2022.
//

import UIKit

public struct QRCodeReaderDataModel {
    public let closeButtonModel: CloseButtonModel
    public let infoTextModel: InfoTextModel
    public let galleryButtonModel: GalleryButtonModel
    public let qrCodeReaderPreviewLayerModel: QRCodeReaderPreviewLayerModel
    public let settingsAlertDataModel: SettingsAlertDataModel
    
    public init(closeButtonModel: CloseButtonModel = CloseButtonModel(),
                infoTextModel: InfoTextModel = InfoTextModel(),
                galleryButtonModel: GalleryButtonModel = GalleryButtonModel(),
                qrCodeReaderPreviewLayerModel: QRCodeReaderPreviewLayerModel = QRCodeReaderPreviewLayerModel(),
                settingsAlertDataModel: SettingsAlertDataModel = SettingsAlertDataModel()) {
        self.closeButtonModel = closeButtonModel
        self.infoTextModel = infoTextModel
        self.galleryButtonModel = galleryButtonModel
        self.qrCodeReaderPreviewLayerModel = qrCodeReaderPreviewLayerModel
        self.settingsAlertDataModel = settingsAlertDataModel
    }
}
