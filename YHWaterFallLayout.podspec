Pod::Spec.new do |s|
    s.name         = 'YHWaterFallLayout'
    s.version      = '1.0.0'
    s.summary      = 'Easy using waterfall'
    s.description  = <<-DESC
        Easy for using waterfall
                   DESC
    s.homepage     = 'https://github.com/yelinux/YHWaterFallLayout'
    s.license      = { :type => "MIT", :file => 'LICENSE' }
    s.authors      = {'chenyehong' => 'ye_linux@126.com'}
    s.platform     = :ios, '9.0'
    s.source       = {:git => 'https://github.com/yelinux/YHWaterFallLayout.git', :tag => s.version}
    s.source_files = 'YHWaterFallLayout/*.{h,m}'
    s.requires_arc = true
    s.ios.frameworks = 'UIKit'
    s.ios.deployment_target = '9.0'
  end
