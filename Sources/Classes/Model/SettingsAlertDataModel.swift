//
//  SettingsAlertDataModel.swift
//  MobilliumQRCodeReader
//
//  Created by Murat Celebi on 31.03.2022.
//
 
public struct SettingsAlertDataModel {
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
