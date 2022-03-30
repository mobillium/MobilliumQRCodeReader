//
//  QRCodeReaderViewController.swift
//  MobilliumQRCodeReader
//
//  Created by Murat Celebi on 28.03.2022.
//

import AVFoundation
import UIKit

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
    
    public var getQrCodeClosure: ((String) -> Void)?
    private var readQRCodeFromImageDidSuccess: (() -> Void)?
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    private let imagePicker = UIImagePickerController()
    
    private let qrCodeReaderDataModel: QRCodeReaderDataModel
    private let margin: CGFloat = 16
    
    public init(nibName nibNameOrNil: String? = nil,
                bundle nibBundleOrNil: Bundle? = nil,
                qrCodeReaderDataModel: QRCodeReaderDataModel = QRCodeReaderDataModel()) {
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
        setLocalize()
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
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: margin / 2).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin / 2).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
        view.addSubview(infoLabel)
        infoLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: margin / 2).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin).isActive = true
        
        view.addSubview(galleryButton)
        galleryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        galleryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -margin).isActive = true
        galleryButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
}

// MARK: - Configure
extension QRCodeReaderViewController {
    
    private func configureContents() {
        view.backgroundColor = .white
        configureCloseButton()
        configureGalleryButton()
        configureQRCodeReader()
        readQRCodeFromImageDidSuccess = { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
    private func configureCloseButton() {
        closeButton.setImage(qrCodeReaderDataModel.closeButtonImage, for: .normal)
        closeButton.tintColor = qrCodeReaderDataModel.closeButtonTintColor
        closeButton.isHidden = !qrCodeReaderDataModel.isShowsCloseButton
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    private func configureGalleryButton() {
        galleryButton.setTitle(qrCodeReaderDataModel.galleryButtonTitle, for: .normal)
        galleryButton.setTitleColor(qrCodeReaderDataModel.galleryButtonTitleColor, for: .normal)
        galleryButton.backgroundColor = qrCodeReaderDataModel.galleryButtonBackgroundColor
        galleryButton.layer.cornerRadius = qrCodeReaderDataModel.galleryButtonCornerRadius
        galleryButton.titleLabel?.font = qrCodeReaderDataModel.galleryButtonFont
        galleryButton.isHidden = !qrCodeReaderDataModel.isShowsGalleryButton
        galleryButton.addTarget(self, action: #selector(chooseFromGalleryButtonTapped), for: .touchUpInside)
    }
    
    private func setLocalize() {
        infoLabel.text = qrCodeReaderDataModel.infoText
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
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        previewLayer = QRCodeReaderPreviewLayer(session: captureSession,
                                                marginSize: qrCodeReaderDataModel.marginSize,
                                                lineWidth: qrCodeReaderDataModel.lineWidth,
                                                lineColor: qrCodeReaderDataModel.lineColor,
                                                lineDashPattern: qrCodeReaderDataModel.lineDashPattern,
                                                cornerRadiuesSize: qrCodeReaderDataModel.cornerRadiuesSize)
        previewLayer.frame = view.layer.bounds
        previewLayer.backgroundColor = qrCodeReaderDataModel.backgroundColor
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        view.bringSubviewToFront(closeButton)
        view.bringSubviewToFront(infoLabel)
        view.bringSubviewToFront(galleryButton)
    }
    
    private func failed() {
        let alertController = UIAlertController(title: "Scanning not supported",
                                                message: "Your device does not support scanning a code from an item. Please use a device with a camera.",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
        captureSession = nil
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
                if !granted {
                    self?.showOpenSettingsAlert() }
            }
        case .denied, .restricted:
            showOpenSettingsAlert()
        default:
            return
        }
    }
    
    private func showOpenSettingsAlert() {
        let alertController = UIAlertController (title: nil, message: "Go to Settings?", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)")
                })
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
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
                guard let stringValue = readableObject?.stringValue else { return }
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                getQrCodeClosure?(stringValue)
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
                    print("Qr didnt find")
                } else {
                    print("message: \(qrCodeString)")
                    getQrCodeClosure?(qrCodeString)
                }
            }
        } else {
            print("Something went wrong")
        }
        dismiss(animated: true, completion: { [weak self] in
            self?.readQRCodeFromImageDidSuccess?()
        })
    }
}
