Pod::Spec.new do |s|

  s.license      = "MIT"
  s.author       = { "qqc" => "20599378@qq.com" }
  s.platform     = :ios, "8.0"
  s.requires_arc  = true

  s.name         = "QqcSelectAddress"
  s.version      = "1.0.2"
  s.summary      = "QqcSelectAddress"
  s.homepage     = "https://github.com/xukiki/QqcSelectAddress"
  s.source       = { :git => "https://github.com/xukiki/QqcSelectAddress.git", :tag => "#{s.version}" }
  
  s.source_files = 'QqcSelectAddress/*.{h,m}'
  s.resource = 'QqcSelectAddress/QqcSelectAddress.bundle'

  s.dependency 'UINib-Qqc'
  s.dependency 'NSBundle-Qqc'
  s.dependency 'UIButton-Qqc'
  s.dependency 'UIView-Qqc'
  
end
