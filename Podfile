# Uncomment the next line to define a global platform for your project
 platform :ios, '15.0'

post_install do |installer|
  
  
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      end
       
        if ['BrightFutures'].include? target.name
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '4.0'
            end
        end
    end
    
end

target 'SprintTreeProject' do
  
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  # Pods for SprintTreeProject
  pod 'Alamofire'
  pod 'BrightFutures'
  pod 'AlamofireObjectMapper'
  pod 'SDWebImageSwiftUI'

  target 'SprintTreeProjectTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SprintTreeProjectUITests' do
    # Pods for testing
  end

end
