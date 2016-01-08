Pod::Spec.new do |s|
s.name         = "UCKit"
s.version      = "0.0.3"
s.summary      = "Something useful view."
s.homepage     = "https://github.com/XiaoyueWang/UCKit"
s.license      = 'MIT'
s.authors      = { "Uncle.Chen" => "suntear2941@hotmail.com" }
s.source       = { :git => "https://github.com/XiaoyueWang/UCKit.git", :tag => s.version.to_s }
s.platform     = :ios, '8.0'
s.requires_arc = true
s.source_files = 'UCKit/**/*.{h,m}'
s.public_header_files = 'UCKit/*.{h}'
end
