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
        let dataModel = QRCodeReaderDataModel(backgroundColor: UIColor.gray.withAlphaComponent(0.3).cgColor,
                                              closeButtonImage: ImageProvider.getCloseImage(),
                                              closeButtonTintColor: .white,
                                              isShowsCloseButton: true,
                                              infoText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                              infoTextColor: .white,
                                              infoTextFont: .systemFont(ofSize: 14),
                                              galleryButtonTitle: "Choose from Gallery",
                                              galleryButtonTitleColor: .systemBlue,
                                              galleryButtonFont: .systemFont(ofSize: 14, weight: .semibold),
                                              galleryButtonBackgroundColor: .white,
                                              galleryButtonCornerRadius: 8,
                                              isShowsGalleryButton: true,
                                              lineWidth: 4,
                                              lineColor: .white,
                                              marginSize: 32,
                                              cornerRadiuesSize: 24,
                                              lineDashPattern: [25, 10])
        let viewController = QRCodeReaderViewController(qrCodeReaderDataModel: dataModel)
        viewController.modalTransitionStyle = .coverVertical
        viewController.modalPresentationStyle = .fullScreen
        viewController.delegate = self
        present(viewController, animated: true, completion: nil)
    }
}

extension HomeViewController: QRCodeReaderDelegate {
    
    func qrCodeReadSuccessful(qrCode: String?) {
        outputLabel.text = qrCode
    }
    
    func qrCodeReaderFailed() {
        let alertController = UIAlertController(title: "Scanning not supported",
                                                message: "Your device does not support scanning a code from an item. Please use a device with a camera.",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
    
    func qrCodeNotFoundFromImageRead() {
        let alertController = UIAlertController(title: "Error",
                                                message: "QR code not found from image which you have selected from gallery",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}
