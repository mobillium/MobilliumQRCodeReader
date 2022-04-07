# MobilliumQRCodeReader

[![CI Status](https://img.shields.io/travis/mobillium/MobilliumQRCodeReader.svg?style=flat)](https://travis-ci.org/mobillium/MobilliumQRCodeReader)
[![Version](https://img.shields.io/cocoapods/v/MobilliumQRCodeReader.svg?style=flat)](https://cocoapods.org/pods/MobilliumQRCodeReader)
[![License](https://img.shields.io/cocoapods/l/MobilliumQRCodeReader.svg?style=flat)](https://cocoapods.org/pods/MobilliumQRCodeReader)
[![Platform](https://img.shields.io/cocoapods/p/MobilliumQRCodeReader.svg?style=flat)](https://cocoapods.org/pods/MobilliumQRCodeReader)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
- iOS 11.0+
- Swift 5.0+

## Installation

#### CocoaPods

MobilliumQRCodeReader is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MobilliumQRCodeReader'
```

#### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.    
Once you have your Swift package set up, adding MobilliumQRCodeReader as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/mobillium/MobilliumQRCodeReader.git", .upToNextMajor(from: "1.0.0"))
]
```

## Usage
MobilliumQRCodeReader comes with these models which you can customize for your requirements or you can continue with default values.     
Create own QRCodeReaderViewController and get result from QRCodeReaderDelegate.
- QRCodeReaderPreviewLayerModel
- CloseButtonModel
- InfoTextModel
- GalleryButtonModel
- SettingsAlertDataModel

Example usage:
```swift
import MobilliumQRCodeReader

class TestViewController: UIViewController {

  func presentQRCodeReader() {
      // default values
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

extension TestViewController: QRCodeReaderDelegate {

    func qrCodeReader(_ viewController: UIViewController, didSuccess qrCode: String) {
        outputLabel.text = qrCode
    }

    func qrCodeReaderFailed(_ viewController: UIViewController) {
        let alertController = UIAlertController(title: "Error",
                                                message: "An unexpected error occurred",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        viewController.present(alertController, animated: true)
    }
}

```

## License

MobilliumQRCodeReader is available under the MIT license. See the LICENSE file for more info.
