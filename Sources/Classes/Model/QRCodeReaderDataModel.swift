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
    
    public init(closeButtonModel: CloseButtonModel = CloseButtonModel(),
                infoTextModel: InfoTextModel = InfoTextModel(),
                galleryButtonModel: GalleryButtonModel = GalleryButtonModel(),
                qrCodeReaderPreviewLayerModel: QRCodeReaderPreviewLayerModel = QRCodeReaderPreviewLayerModel()) {
        self.closeButtonModel = closeButtonModel
        self.infoTextModel = infoTextModel
        self.galleryButtonModel = galleryButtonModel
        self.qrCodeReaderPreviewLayerModel = qrCodeReaderPreviewLayerModel
    }
}
