Pod::Spec.new do |s|
  s.name             = 'Capable'
  s.version          = '0.1.2'
  s.summary          = 'Keep track of accessibility settings and enable users with disabilities to use your app.'
 
  s.description      = <<-DESC
Capable lets you easily keep track of accessibility settings used by your app users. Send this info along with user properties and find out about where to improve accessibility within your app. Capable also comes with additional features that will help you to solve common accessibility problems.
                       DESC
 
  s.homepage         = 'https://github.com/chrs1885/Capable-iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Christoph Wendt' => 'christoph.wendt@me.com' }
  s.source           = { :git => 'https://github.com/chrs1885/Capable-iOS.git', :tag => s.version }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'Source/**/*.swift'
 
end