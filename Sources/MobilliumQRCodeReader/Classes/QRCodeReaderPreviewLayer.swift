//
//  ScannerOverlayPreviewLayer.swift
//  MobilliumQRCodeReader
//
//  Created by Murat Celebi on 28.03.2022.
//

import AVFoundation
import UIKit

public class QRCodeReaderPreviewLayer: AVCaptureVideoPreviewLayer {
    
    private let lineWidth: CGFloat
    private let lineColor: UIColor
    private let lineDashPattern: [NSNumber]?
    private let marginSize: CGFloat
    private let cornerRadiusSize: CGFloat
    
    public var rectOfInterest: CGRect {
        metadataOutputRectConverted(fromLayerRect: maskContainer)
    }
    
    public override var frame: CGRect {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private var maskContainer: CGRect {
        let width = bounds.width - (marginSize * 2)
        return CGRect(x: marginSize,
                      y: ((bounds.height / 2) - (width) / 2),
                      width: width,
                      height: width)
    }
    
    public init(session: AVCaptureSession,
                marginSize: CGFloat,
                lineWidth: CGFloat,
                lineColor: UIColor,
                lineDashPattern: [NSNumber]?,
                cornerRadiusSize: CGFloat) {
        self.marginSize = marginSize
        self.lineWidth = lineWidth
        self.lineColor = lineColor
        self.lineDashPattern = lineDashPattern
        self.cornerRadiusSize = cornerRadiusSize
        super.init(session: session)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Drawing
    public override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        
        // MARK: - Background Mask
        let path = CGMutablePath()
        path.addRect(bounds)
        path.addRoundedRect(in: maskContainer, cornerWidth: cornerRadiusSize, cornerHeight: cornerRadiusSize)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path
        maskLayer.fillColor = backgroundColor
        maskLayer.fillRule = .evenOdd
        addSublayer(maskLayer)
        
        // MARK: - Line Frame Mask
        let linePath = CGMutablePath()
        linePath.addRoundedRect(in: maskContainer, cornerWidth: cornerRadiusSize, cornerHeight: cornerRadiusSize)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = linePath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = .round
        shapeLayer.lineDashPattern = lineDashPattern
        addSublayer(shapeLayer)
    }
}
