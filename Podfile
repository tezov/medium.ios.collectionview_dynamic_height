platform :ios, '14.0'

target 'test_snapkit' do
  use_frameworks!
  
  pod 'SnapKit', '~> 5.6.0'
  pod 'LoremIpsum', '~> 1.0'
  
end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
      end
    end
  end
end

