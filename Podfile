
use_frameworks!

def shared_pods
  pod 'RxSwift'
  pod 'RxCocoa'
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
          config.build_settings['SWIFT_VERSION'] = ‘3.1’
          config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.12’
         end
       end
end
