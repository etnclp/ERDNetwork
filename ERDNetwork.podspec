Pod::Spec.new do |s|
  s.name             = 'ERDNetwork'
  s.version          = '0.1.1'
  s.summary          = 'The network manager of iOS Apps'
  s.description      = <<-EOS
TODO: Add long description of the pod here.
EOS
  s.homepage         = 'https://github.com/etnclp/ERDNetwork'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'etnclp' => 'tuncalperdi@gmail.com' }
  s.source           = { :git => 'https://github.com/etnclp/ERDNetwork.git', :tag => s.version.to_s }
  s.swift_version = '5.0'
  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.14'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '5.0'
  s.ios.frameworks = 'UIKit'

  s.subspec 'Base' do |ss|
    ss.source_files = 'Sources/Base/**/*'
  end

  s.subspec 'Rx' do |ss|
    ss.source_files = 'Sources/Rx/**/*'
    ss.dependency 'ERDNetwork/Base'
    ss.dependency 'RxSwift', "~> 5.1"
    ss.dependency 'RxCocoa', "~> 5.1"
  end
end
