// swift-tools-version: 5.9
import PackageDescription

// Lumen 采集端 SDK：嵌入被调试 App 的 LumenServer（只应在 Debug 构建中使用），以预编译的 XCFramework 发布。
// Mac 端的 Lumen.app 与 lumen 命令行工具请从 Releases 下载安装包。
// 本文件由源码仓库的 Scripts/sync_distribution.sh 从 Distribution-template/Package.swift 同步，请勿在发布仓库里直接修改。
let package = Package(
    name: "Lumen",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .macCatalyst(.v15),
        .tvOS(.v15),
        .visionOS(.v1),
    ],
    products: [
        // 接入被调试 App：在 Debug 构建中调用 LumenServer.start()
        .library(name: "LumenServer", targets: ["LumenServer"]),
    ],
    targets: [
        .binaryTarget(
            name: "LumenServer",
            url: "https://github.com/wangwanjie/Lumen/releases/download/v0.3.2/LumenServer_v0.3.2.xcframework.zip",
            checksum: "e3ebc0a2203ea3536ea8cc40a70f83e42514bf9360974af84df82d84b2f338cd"
        ),
    ]
)
