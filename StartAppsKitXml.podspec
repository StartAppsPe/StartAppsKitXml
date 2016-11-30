#
# Be sure to run `pod lib lint StartAppsKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|

s.name             = 'StartAppsKitXml'
s.version          = '1.0.1'
s.summary          = 'A library that does everything.'
s.description      = <<-DESC
A library that does everything. Central class is LoadAction and it helps you work with asynchronous loading of data from any Source.
DESC
s.homepage         = 'https://github.com/StartAppsPe/'+s.name
s.license          = 'MIT'
s.author           = { 'Gabriel Lanata' => 'gabriellanata@gmail.com' }

s.source           = { :git => 'https://github.com/StartAppsPe/'+s.name+'.git', :tag => s.version.to_s }
s.module_name      = s.name
s.platform         = :ios, '8.0'
s.requires_arc     = true

s.source_files     = 'Sources'

s.dependency 'StartAppsKitLoadAction', '~> 1'
s.dependency 'StartAppsKitLogger', '~> 1'
s.dependency 'AEXML', '~> 4'

end
