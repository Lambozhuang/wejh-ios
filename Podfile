platform :ios, '12.0'

use_frameworks!
inhibit_all_warnings!

target 'wejh-ios' do

  # Networking
  pod 'Moya/RxSwift', '~>14.0'  # https://github.com/Moya/Moya

  # Tool
  pod 'SwiftLint', '0.39.2'  # https://github.com/realm/SwiftLint

  # Keychain
  pod 'KeychainAccess', '~> 4.0'  # https://github.com/kishikawakatsumi/KeychainAccess

  # UI

  # Auto Layout
  pod 'SnapKit', '~> 5.0'  # https://github.com/SnapKit/SnapKit

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
