//
//  QRCodeReaderViewController.swift
//  MobilliumQRCodeReader
//
//  Created by Murat Celebi on 28.03.2022.
//

import AVFoundation
import UIKit

public protocol QRCodeReaderDelegate: AnyObject {
    func qrCodeReader(_ viewController: UIViewController, didSuccess qrCode: String)
    func qrCodeReaderFailed(_ viewController: UIViewController)
}

public class QRCodeReaderViewController: UIViewController {
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        return button
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let galleryButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.contentEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
        return button
    }()
    
    private var captureSession: AVCaptureSession!
    private var previewLayer: QRCodeReaderPreviewLayer!
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    private let imagePicker = UIImagePickerController()
    
    private let qrCodeReaderDataModel: QRCodeReaderDataModel
    private let sMargin: CGFloat = 8
    private let mMargin: CGFloat = 16
    private let lMargin: CGFloat = 32
    
    public weak var delegate: QRCodeReaderDelegate?
    
    public init(qrCodeReaderDataModel: QRCodeReaderDataModel = QRCodeReaderDataModel()) {
        self.qrCodeReaderDataModel = qrCodeReaderDataModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContents()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if captureSession?.isRunning == false {
            captureSession.startRunning()
        }
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if captureSession?.isRunning == true {
            captureSession.stopRunning()
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkCameraPermission()
    }
}

// MARK: - UILayout
extension QRCodeReaderViewController {
    
    private func addSubviews() {
        view.addSubview(closeButton)
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: sMargin).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sMargin).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
        view.addSubview(infoLabel)
        infoLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: sMargin).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: lMargin).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -lMargin).isActive = true
        
        view.addSubview(galleryButton)
        galleryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        galleryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -mMargin).isActive = true
        galleryButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
}

// MARK: - Configure
extension QRCodeReaderViewController {
    
    private func configureContents() {
        configureCloseButton()
        configureInfoLabel()
        configureGalleryButton()
        configureQRCodeReader()
    }
    
    private func configureCloseButton() {
        closeButton.setImage(qrCodeReaderDataModel.closeButtonModel.image, for: .normal)
        closeButton.tintColor = qrCodeReaderDataModel.closeButtonModel.tintColor
        closeButton.isHidden = qrCodeReaderDataModel.closeButtonModel.isHidden
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    private func configureInfoLabel() {
        infoLabel.text = qrCodeReaderDataModel.infoTextModel.text
        infoLabel.textColor = qrCodeReaderDataModel.infoTextModel.textColor
        infoLabel.font = qrCodeReaderDataModel.infoTextModel.font
        infoLabel.isHidden = qrCodeReaderDataModel.infoTextModel.isHidden
    }
    
    private func configureGalleryButton() {
        galleryButton.setTitle(qrCodeReaderDataModel.galleryButtonModel.title, for: .normal)
        galleryButton.setTitleColor(qrCodeReaderDataModel.galleryButtonModel.titleColor, for: .normal)
        galleryButton.backgroundColor = qrCodeReaderDataModel.galleryButtonModel.backgroundColor
        galleryButton.layer.cornerRadius = qrCodeReaderDataModel.galleryButtonModel.cornerRadius
        galleryButton.titleLabel?.font = qrCodeReaderDataModel.galleryButtonModel.font
        galleryButton.isHidden = qrCodeReaderDataModel.galleryButtonModel.isHidden
        galleryButton.addTarget(self, action: #selector(chooseFromGalleryButtonTapped), for: .touchUpInside)
    }
    
    private func configureQRCodeReader() {
        captureSession = AVCaptureSession()
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            captureSession = nil
            dismiss(animated: true, completion: { [weak self] in
                guard let self = self else { return }
                self.delegate?.qrCodeReaderFailed(self)
            })
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            captureSession = nil
            dismiss(animated: true, completion: { [weak self] in
                guard let self = self else { return }
                self.delegate?.qrCodeReaderFailed(self)
            })
            return
        }
        
        previewLayer = QRCodeReaderPreviewLayer(session: captureSession,
                                                marginSize: qrCodeReaderDataModel.qrCodeReaderPreviewLayerModel.marginSize,
                                                lineWidth: qrCodeReaderDataModel.qrCodeReaderPreviewLayerModel.lineWidth,
                                                lineColor: qrCodeReaderDataModel.qrCodeReaderPreviewLayerModel.lineColor,
                                                lineDashPattern: qrCodeReaderDataModel.qrCodeReaderPreviewLayerModel.lineDashPattern,
                                                cornerRadiusSize: qrCodeReaderDataModel.qrCodeReaderPreviewLayerModel.cornerRadius)
        previewLayer.frame = view.layer.bounds
        previewLayer.backgroundColor = qrCodeReaderDataModel.qrCodeReaderPreviewLayerModel.backgroundColor
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        view.bringSubviewToFront(closeButton)
        view.bringSubviewToFront(infoLabel)
        view.bringSubviewToFront(galleryButton)
    }
}

// MARK: - Actions
extension QRCodeReaderViewController {
    
    @objc
    private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc
    private func chooseFromGalleryButtonTapped() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: - Check Camera Permission
extension QRCodeReaderViewController {
    
    private func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard let self = self, !granted else { return }
                self.showOpenSettingsAlert()
            }
        case .denied, .restricted:
            showOpenSettingsAlert()
        default:
            return
        }
    }
    
    private func showOpenSettingsAlert() {
        let alertController = UIAlertController (title: nil, message: qrCodeReaderDataModel.settingsAlertDataModel.message, preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: qrCodeReaderDataModel.settingsAlertDataModel.actionButtonTitle, style: .default) { _ in
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print(success)
                })
            }
        }
        let cancelAction = UIAlertAction(title: qrCodeReaderDataModel.settingsAlertDataModel.cancelButtonTitle, style: .default, handler: nil)
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate
extension QRCodeReaderViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        if let metadataObject = metadataObjects.first {
            if metadataObject.type == .qr {
                let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject
                guard let qrCodeString = readableObject?.stringValue else { return }
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                delegate?.qrCodeReader(self, didSuccess: qrCodeString)
            }
        }
        dismiss(animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension QRCodeReaderViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let qrcodeImage = info[.originalImage] as? UIImage {
            if let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh]) {
                let ciImage = CIImage(image: qrcodeImage)!
                var qrCodeString = ""
                
                let features = detector.features(in: ciImage)
                for feature in features as! [CIQRCodeFeature] {
                    qrCodeString += feature.messageString!
                }
                
                if qrCodeString == "" {
                    imagePicker.dismiss(animated: true, completion: { [weak self] in
                        guard let self = self else { return }
                        self.dismiss(animated: true, completion: {
                            self.delegate?.qrCodeReaderFailed(self)
                        })
                    })
                } else {
                    delegate?.qrCodeReader(self, didSuccess: qrCodeString)
                }
            }
        } else {
            delegate?.qrCodeReaderFailed(self)
        }
        imagePicker.dismiss(animated: true, completion: { [weak self] in
            self?.dismiss(animated: true)
        })
    }
}
