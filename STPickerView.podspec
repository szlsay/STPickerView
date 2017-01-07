Pod::Spec.new do |s|
s.name     = 'STPickerView'
s.version  = '2.0'
s.license = { :type => 'MIT', :file => 'LICENSE'}
s.summary  = '一个多功能的选择器,有城市选择，日期选择和单数组源自定的功能'
s.homepage = 'https://github.com/STShenZhaoliang'
s.author   = { 'STShenZhaoliang' => '409178030@qq.com' }
s.source   = {
:git => 'https://github.com/STShenZhaoliang/STPickerView.git',
:tag => s.version.to_s
}
s.ios.deployment_target = '7.0'
s.source_files     = "STPickerView/STPickerView/*.{h,m}"
s.resource         = 'STPickerView/Resource/area.plist'
s.requires_arc = true
end
