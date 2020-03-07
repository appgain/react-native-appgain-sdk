
Pod::Spec.new do |s|
  s.name         = "RNAppgainSdk"
  s.version      = "1.0.0"
  s.summary      = "RNAppgainSdk"
  s.description  = <<-DESC
                  RNAppgainSdk
                   DESC
  s.homepage     = ""
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "appgain.io" => "author@domain.cn" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/author/RNAppgainSdk.git", :tag => "master" }
  s.source_files  = "RNAppgainSdk/**/*.{h,m}"
  s.requires_arc = true


  s.dependency "React"
  s.dependency "Appgain"

end

  