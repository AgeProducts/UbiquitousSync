
use_frameworks!

target ‘UbiquitousSyncIOS’ do
   platform :ios, ‘9.3’
   pod 'RxSwift', :git => 'https://github.com/ReactiveX/RxSwift.git’, :branch => 'develop'
   pod 'RxCocoa', :git => 'https://github.com/ReactiveX/RxSwift.git', :branch => 'develop'
end

target ‘UbiquitousSyncMac’ do
   platform :osx, ‘10.11’
   pod 'RxSwift', :git => 'https://github.com/ReactiveX/RxSwift.git’, :branch => 'develop'
   pod 'RxCocoa', :git => 'https://github.com/ReactiveX/RxSwift.git', :branch => 'develop'
end

post_install do |installer|
      installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['SWIFT_VERSION'] = ‘3.0’
          config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.11’
         end
       end
end