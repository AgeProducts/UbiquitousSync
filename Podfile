
use_frameworks!

def shared_pods
   pod 'RxSwift', :git => 'https://github.com/ReactiveX/RxSwift.git', :branch => 'swift4.0'
   pod 'RxCocoa', :git => 'https://github.com/ReactiveX/RxSwift.git', :branch => 'swift4.0'
end

target ‘UbiquitousSyncIOS’ do
   platform :ios, ‘10.3’
   shared_pods
 end

target ‘UbiquitousSyncMac’ do
   platform :osx, ‘10.12’
   shared_pods
 end

post_install do |installer|
      installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['SWIFT_VERSION'] = ‘4.0’
          config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.12’
         end
       end
end
