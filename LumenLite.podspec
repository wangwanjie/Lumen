# Lumen 轻量导出库（CocoaPods）：线上版本可用，以预编译的静态 LumenLite.xcframework 发布，不含源码。
#
# 与只在 Debug 使用的 LumenServer 不同，LumenLite 可以集成进 Release：
#   - 纯 ObjC 静态库，无 +load / 构造函数 / 方法交换，不调用就不执行任何代码；
#   - 链接进 App 后增量约 150 KB（arm64），只依赖 UIKit、QuartzCore、ImageIO 系统框架与 libcompression。
#
#   pod 'LumenLite', :podspec => 'https://raw.githubusercontent.com/wangwanjie/Lumen/v<版本>/LumenLite.podspec'
#
# 二进制包由 Scripts/build_lite_xcframework.sh 构建，作为 Release 附件 LumenLite_v<版本>.xcframework.zip 上传；
# 下面的 5f75abf404869db5648580cc6f9d3a73a59a63bbe86ea1b48bcb29c335b51afd 由 Scripts/sync_distribution.sh 在同步到发布仓库时替换为该 zip 的 SHA-256，
# 本文件不能直接用于 pod install，请使用发布仓库 tag 中的 LumenLite.podspec。
# 版本号由 Scripts/bump_version.sh 统一管理。
Pod::Spec.new do |s|
  s.name             = 'LumenLite'
  s.version          = '0.3.5'
  s.summary          = 'Lumen 轻量导出库：线上版本把界面现场导出为 .lumen 离线归档，供 Lumen.app 查看。'
  s.description      = <<-DESC
    LumenLite 在调用时把指定 UIWindow / UIViewController 的界面层级、节点属性、Auto Layout 约束与分层纹理
    导出为 Lumen 离线归档（.lumen），拉回本地用 Lumen.app 打开分析。支持用户截屏时自动导出。
  DESC
  s.homepage         = 'https://lumen.vanjay.cn'
  s.license          = { :type => 'Proprietary', :text => 'Copyright (c) 2026 wangwanjie. All rights reserved. See https://github.com/wangwanjie/Lumen/blob/main/LICENSE' }
  s.author           = { 'wangwanjie' => 'https://github.com/wangwanjie' }
  s.source           = {
    :http   => "https://github.com/wangwanjie/Lumen/releases/download/v#{s.version}/LumenLite_v#{s.version}.xcframework.zip",
    :sha256 => '5f75abf404869db5648580cc6f9d3a73a59a63bbe86ea1b48bcb29c335b51afd'
  }

  # 与 xcframework 的部署目标一致（Scripts/build_lite_xcframework.sh）
  s.ios.deployment_target = '12.0'

  s.vendored_frameworks = 'LumenLite.xcframework'
  s.frameworks = 'Foundation', 'UIKit', 'QuartzCore', 'ImageIO'
  # 归档 JSON 分段的 deflate 压缩（系统库 libcompression）
  s.libraries  = 'compression'
end
