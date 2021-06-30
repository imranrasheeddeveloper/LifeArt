# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'LifeArt' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for LifeArt
  pod 'Firebase/Core'
  pod 'Firebase/Database'
  pod 'Firebase/Storage'
  pod 'Firebase/Auth'
  pod 'FittedSheets'
  pod 'Firebase/Auth'
  pod 'CodableFirebase'
  pod 'FlagPhoneNumber'
  pod 'SDWebImage', '~> 5.0'
  pod 'SkeletonView'
  pod 'Firebase/Messaging'
  pod 'ContextMenu'
  pod 'MessageKit'
  pod 'lottie-ios'
  pod 'IQKeyboardManagerSwift'
pod 'MaterialComponents/TextControls+FilledTextAreas'
pod 'MaterialComponents/TextControls+FilledTextFields'
pod 'MaterialComponents/TextControls+OutlinedTextAreas'
pod 'MaterialComponents/TextControls+OutlinedTextFields'
pod 'MaterialComponents/Snackbar'
pod 'MDFInternationalization'
pod 'SwiftyStoreKit'

post_install do |installer|
installer.pods_project.targets.each do |target|
target.build_configurations.each do |config|
config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
end
end
end

  target 'LifeArtTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'LifeArtUITests' do
    # Pods for testing
  end

end
