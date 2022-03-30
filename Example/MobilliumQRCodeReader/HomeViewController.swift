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
        let viewController = QRCodeReaderViewController()
        viewController.modalTransitionStyle = .coverVertical
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
        viewController.getQrCodeClosure = { [weak self] text in
            DispatchQueue.main.async {
                self?.outputLabel.text = text
            }
        }
    }
}
