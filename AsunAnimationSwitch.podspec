Pod::Spec.new do |s| 
s.name    = "AsunAnimationSwitch"
s.version = "0.0.1" 
s.summary = "点击动画Swift4.0版本"
  s.description      = <<-DESC
    点击按钮动画Swift版本,详情看主页
                       DESC
s.homepage = "https://github.com/BecomerichAsun/AsunAnimationSwitch.git"
s.license = { :type => 'MIT', :file => 'LICENSE' } 
s.author = { "Asun" => "becomerichios@163.com" } 
s.ios.deployment_target = '8.0' 
s.source = { :git => "https://github.com/BecomerichAsun/AsunAnimationSwitch.git", :tag => "v#{s.version}" } 
s.source_files = 'AsunAnimationSwitch/Source/*.swift'
s.requires_arc = true 
s.framework = "UIKit"
end