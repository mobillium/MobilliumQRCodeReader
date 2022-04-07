//
//  QRCodeReaderPreviewLayerModel.swift
//  MobilliumQRCodeReader
//
//  Created by Murat Celebi on 31.03.2022.
//

public struct QRCodeReaderPreviewLayerModel {
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
