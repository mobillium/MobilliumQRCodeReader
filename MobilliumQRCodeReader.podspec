#
# Be sure to run `pod lib lint MobilliumQRCodeReader.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MobilliumQRCodeReader'
  s.version          = '1.0.0'
  s.summary          = 'Simple way to read QR Code by camera and from gallery'

  s.description      = <<-DESC
  MobilliumQRCodeReader is a customisable qr code reader also you can read qr code from gallery image.
                       DESC

  s.homepage         = 'https://github.com/mobillium/MobilliumQRCodeReader'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mrtcelebi' => 'mrttcelebi@gmail.com' }
  s.source           = { :git => 'https://github.com/mobillium/MobilliumQRCodeReader.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/_mrtcelebi_'

  s.ios.deployment_target = '11.0'
  s.swift_version = "5.0"
  s.source_files = 'Sources/MobilliumQRCodeReader/Classes/**/*'
end
