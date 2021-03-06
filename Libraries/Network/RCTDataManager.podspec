Pod::Spec.new do |spec|
  spec.name         = 'RCTDataManager'
  spec.version      = '0.0.1'
  spec.summary      = 'Provides basic networking capabilities in ReactNative apps.'
  spec.description  = <<-DESC
    Use XMLHttpRequest to fetch data over the network.
                   DESC
  spec.homepage     = 'https://facebook.github.io/react-native/'
  spec.license      = { :type => 'BSD' }
  spec.author       = 'Facebook'
  spec.platform     = :ios, '7.0'
  spec.requires_arc = true
  spec.source_files  = '**/*.{h,m,c}'
  spec.dependency "ReactKit", "~> 0.0.1"

  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  #spec.libraries = "RCTDataManager", "ReactKit"

end
