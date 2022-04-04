//
//  ViewController.swift
//  MobilliumQRCodeReader
//
//  Created by mrtcelebi on 03/30/2022.
//

import UIKit
import MobilliumQRCodeReader

class HomeViewController: UIViewController {
    
    private let outputLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private let readQRCodeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.contentEdgeInsets = .init(top: 8, left: 16, bottom: 8, right: 16)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContents()
        setLocalize()
    }
}

// MARK: - UILayout
extension HomeViewController {
    
    private func addSubviews() {
        view.addSubview(outputLabel)
        outputLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        outputLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        outputLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(readQRCodeButton)
        readQRCodeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        readQRCodeButton.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16).isActive = true
        readQRCodeButton.leadingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16).isActive = true
        readQRCodeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32).isActive = true
    }
}

// MARK: - Configure & SetLocalize
extension HomeViewController {
    
    private func configureContents() {
        view.backgroundColor = .white
        readQRCodeButton.addTarget(self, action: #selector(readQRCodeButtonTapped), for: .touchUpInside)
    }
    
    private func setLocalize() {
        readQRCodeButton.setTitle("QR Code Reader", for: .normal)
        outputLabel.text = "Test Scene"
    }
}

// MARK: - Actions
extension HomeViewController {
    
    @objc
    private func readQRCodeButtonTapped() {
        let closeButtonModel = CloseButtonModel(image: ImageProvider.getCloseImage(),
                                                tintColor: .white,
                                                isHidden: false)
        
        let infoTextModel = InfoTextModel(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                                          textColor: .white,
                                          font: .systemFont(ofSize: 14),
                                          isHidden: false)
        
        let galleryButtonModel = GalleryButtonModel(title: "Choose from Gallery",
                                                    titleColor: .systemBlue,
                                                    font: .systemFont(ofSize: 14, weight: .semibold),
                                                    backgroundColor: .white,
                                                    cornerRadius: 8,
                                                    isHidden: false,
                                                    height: 32)
        
        let qrCodeReaderPreviewLayerModel = QRCodeReaderPreviewLayerModel(backgroundColor: UIColor.gray.withAlphaComponent(0.3).cgColor,
                                                                          lineWidth: 4,
                                                                          lineColor: .white,
                                                                          marginSize: 32,
                                                                          cornerRadius: 24,
                                                                          lineDashPattern: [25, 10])
        
        let settingsAlertDataModel = SettingsAlertDataModel(title: nil,
                                                            message: "Go to Settings?",
                                                            actionButtonTitle: "Settings",
                                                            cancelButtonTitle: "Cancel")
        
        let dataModel = QRCodeReaderDataModel(closeButtonModel: closeButtonModel,
                                              infoTextModel: infoTextModel,
                                              galleryButtonModel: galleryButtonModel,
                                              qrCodeReaderPreviewLayerModel: qrCodeReaderPreviewLayerModel,
                                              settingsAlertDataModel: settingsAlertDataModel)
        let viewController = QRCodeReaderViewController(qrCodeReaderDataModel: dataModel)
        viewController.modalTransitionStyle = .coverVertical
        viewController.modalPresentationStyle = .fullScreen
        viewController.delegate = self
        present(viewController, animated: true, completion: nil)
    }
}

extension HomeViewController: QRCodeReaderDelegate {
    
    func qrCodeReader(_ viewController: UIViewController, didSuccess qrCode: String) {
        outputLabel.text = qrCode
    }
    
    func qrCodeReaderFailed(_ viewController: UIViewController) {
        let alertController = UIAlertController(title: "Scanning not supported",
                                                message: "Your device does not support scanning a code from an item. Please use a device with a camera.",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}
