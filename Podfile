platform :ios, '12.0'

use_frameworks!
inhibit_all_warnings!

target 'wejh-ios' do

  # ReactiveX
  pod 'RxSwift', '~> 5.0' # https://github.com/ReactiveX/RxSwift
  pod 'RxCocoa', '~> 5.0' # https://github.com/ReactiveX/RxSwift

  # Rx Extensions
  pod 'RxSwiftExt', '~> 5.0' # https://github.com/RxSwiftCommunity/RxSwiftExt
  pod 'RxViewController', '~> 1.0' # https://github.com/devxoul/RxViewController
  pod 'NSObject+Rx', '~> 5.0' # https://github.com/RxSwiftCommunity/NSObject-Rx
  pod 'RxDataSources', '~> 4.0' # https://github.com/RxSwiftCommunity/RxDataSources
  # pod 'RxGesture', '~> 3.0' # https://github.com/RxSwiftCommunity/RxGesture
  # pod 'RxOptional', '~> 4.0' # https://github.com/RxSwiftCommunity/RxOptional

  # Networking
  pod 'Moya/RxSwift', '~> 14.0' # https://github.com/Moya/Moya

  # Tool
  pod 'SwiftLint', '0.39.2' # https://github.com/realm/SwiftLint

  # Keychain
  pod 'KeychainAccess', '~> 4.0' # https://github.com/kishikawakatsumi/KeychainAccess

  # UI
  pod 'WhatsNewKit', '~> 1.3' # https://github.com/SvenTiigi/WhatsNewKit

  # Dark Mode
  pod "FluentDarkModeKit" # https://github.com/SvenTiigi/WhatsNewKit

  # Auto Layout
  pod 'SnapKit', '~> 5.0' # https://github.com/SnapKit/SnapKit

end

post_install do |installer|
  # Enable tracing resources
  installer.pods_project.targets.each do |target|
    if target.name == 'RxSwift'
      target.build_configurations.each do |config|
        if config.name == 'Debug'
          config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
        end
      end
    end
  end
end
