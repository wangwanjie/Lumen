# Lumen 采集端 SDK（CocoaPods），以预编译的 LumenServer.xcframework 发布，不含源码。
#
# 只应在 Debug 构建中集成，例如：
#   pod 'LumenServer', :podspec => 'https://raw.githubusercontent.com/wangwanjie/Lumen/v<版本>/LumenServer.podspec', :configurations => ['Debug']
# （xcframework 只在 GitHub Release 附件里，发布仓库本身不含它，所以不能用 :git 方式接入。）
#
# 二进制包由 Scripts/build_sdk_xcframework.sh 构建，作为 Release 附件 LumenServer_v<版本>.xcframework.zip 上传；
# 下面的 ea87d919c53562f94184c16ec28a4dae2feb1f70ac821511cb5e5217b162e6f2 由 Scripts/sync_distribution.sh 同步到发布仓库时替换为该 zip 的 SHA-256。
# 本文件在源码仓库根目录维护，版本号由 Scripts/bump_version.sh 统一管理。
Pod::Spec.new do |s|
  s.name             = 'LumenServer'
  s.version          = '0.3.5'
  s.summary          = 'Lumen 采集端：嵌入被调试的 iOS / macOS App，供 Lumen 查看与调试界面层级。'
  s.description      = <<-DESC
    LumenServer 嵌入被调试的 App（仅 Debug），在本机端口上提供界面层级、节点属性、截图等数据，
    由 Lumen.app、lumen 命令行工具或通过 lumen mcp 接入的 AI 助手读取。以预编译的 XCFramework 提供。
  DESC
  s.homepage         = 'https://lumen.vanjay.cn'
  s.license          = { :type => 'Proprietary', :text => 'Copyright (c) 2026 wangwanjie. All rights reserved. Free to use in Debug builds; see https://github.com/wangwanjie/Lumen/blob/main/LICENSE' }
  s.author           = { 'wangwanjie' => 'https://github.com/wangwanjie' }
  s.source           = {
    :http   => "https://github.com/wangwanjie/Lumen/releases/download/v#{s.version}/LumenServer_v#{s.version}.xcframework.zip",
    :sha256 => 'ea87d919c53562f94184c16ec28a4dae2feb1f70ac821511cb5e5217b162e6f2'
  }

  # 与 xcframework 的部署目标一致（Scripts/build_sdk_xcframework.sh）
  s.ios.deployment_target      = '15.0'
  s.osx.deployment_target      = '12.0'
  s.tvos.deployment_target     = '15.0'
  s.visionos.deployment_target = '1.0'

  s.vendored_frameworks = 'LumenServer.xcframework'

  # OSLog：读取本进程 os_log 推送给客户端的日志面板
  s.frameworks = 'Foundation', 'QuartzCore', 'ImageIO', 'Network', 'OSLog'
  s.ios.frameworks      = 'UIKit'
  s.tvos.frameworks     = 'UIKit'
  s.visionos.frameworks = 'UIKit'
  s.osx.frameworks      = 'AppKit'
end
