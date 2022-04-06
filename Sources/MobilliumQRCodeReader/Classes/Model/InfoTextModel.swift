//
//  InfoTextModel.swift
//  MobilliumQRCodeReader
//
//  Created by Murat Celebi on 31.03.2022.
//

public struct InfoTextModel {
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
