// swift-tools-version: 5.9
import PackageDescription

// Lumen 采集端 SDK：嵌入被调试 App 的 LumenServer（只应在 Debug 构建中使用），以预编译的 XCFramework 发布。
// LumenLite：线上版本可用的轻量导出库（iOS / Mac Catalyst，纯 ObjC 静态库），把界面现场导出为 .lumen 离线归档。
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
        // 线上版本导出界面现场：静态库，不调用就不执行任何代码，可以进 Release 构建
        .library(name: "LumenLite", targets: ["LumenLite"]),
    ],
    targets: [
        .binaryTarget(
            name: "LumenServer",
            url: "https://github.com/wangwanjie/Lumen/releases/download/v0.3.5/LumenServer_v0.3.5.xcframework.zip",
            checksum: "ea87d919c53562f94184c16ec28a4dae2feb1f70ac821511cb5e5217b162e6f2"
        ),
        // 静态库 xcframework（iOS 真机、模拟器、Mac Catalyst 切片），头文件目录带 module.modulemap，可直接 import LumenLite
        .binaryTarget(
            name: "LumenLite",
            url: "https://github.com/wangwanjie/Lumen/releases/download/v0.3.5/LumenLite_v0.3.5.xcframework.zip",
            checksum: "5f75abf404869db5648580cc6f9d3a73a59a63bbe86ea1b48bcb29c335b51afd"
        ),
    ]
)
