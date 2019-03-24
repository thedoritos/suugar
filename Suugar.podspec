Pod::Spec.new do |spec|
  spec.name         = "Suugar"
  spec.version      = "0.1.0"
  spec.summary      = "Build UI for iOS application by code"

  spec.license      = "MIT"

  spec.homepage     = "https://blog.kakeragames.com"

  spec.author             = { "thedoritos" => "thedoritos@gmail.com" }
  spec.social_media_url   = "https://twitter.com/thedoritos"

  spec.platform     = :ios, "9.0"

  spec.source       = { :git => "https://github.com/thedoritos/suugar.git", :tag => "#{spec.version}" }

  spec.source_files  = "Suugar", "Suugar/**/*.{h,m}"
end

