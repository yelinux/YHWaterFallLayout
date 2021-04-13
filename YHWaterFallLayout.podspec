Pod::Spec.new do |spec|
  spec.name         = "YHWaterFallLayout"
  spec.version      = "1.0"
  spec.summary      = "简易使用瀑布流."
  spec.description  = "简单使用瀑布流。"
  spec.homepage     = "https://github.com/yelinux/YHWaterFallLayout"
  spec.license      = "MIT"
  spec.author             = { "chenyehong" => "ye_linux@126.com" }

  spec.source       = { :git => "https://github.com/yelinux/YHWaterFallLayout.git", :tag => spec.version.to_s }

  spec.source_files  = "YHWaterFallLayout/*.{h,m}"
  spec.requires_arc = true
  spec.platform = :ios, '9.0'

end