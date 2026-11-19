<p align="center">
  <img src="assets/AppIcon.png" width="128" height="128" alt="Lumen">
</p>

<h1 align="center">Lumen</h1>

<p align="center">iOS / macOS 界面调试工具：3D 分层查看界面层级，并提供命令行与 MCP 接口，让脚本、CI 与 AI 助手也能读取界面。</p>

<p align="center"><a href="README.en.md">English</a></p>

## 能力一览

Lumen 用来查看运行中 App 的视图层级，并把同一套能力开放给命令行与 AI 助手，支持 macOS AppKit 程序与零改动注入。

| 能力 | 说明 |
|---|---|
| 2D / 3D 层级画布 | Metal 渲染，平面与分层 3D 视图切换，可调层间距、相机复位，显示隐藏节点与边框线，间距测量 |
| 层级大纲 | 树形大纲与画布联动选中，按类名、文本等过滤 |
| SwiftUI | 在宿主视图之下给出 SwiftUI 的逻辑视图树：`Text` 的文字、`Button` / `Toggle` / `TextField` 等控件、修饰符链与参数、调试数据中的属性值（含 `@State`），可按文本查找；集成 LumenServer 或注入后自动开启 |
| 属性检查器 | 按类分组的属性、继承链、所属 ViewController、实例变量名、accessibilityIdentifier、窗口坐标 |
| 运行时改属性 | 在检查器中直接修改可编辑属性（数值拖动微调、取色、文本等），修改记录可撤销、可复制为 AI 提示；命令行 `lumen set` |
| 调用方法 | 控制台中列出并调用节点、layer 或所属 ViewController 上的方法；命令行 `lumen methods` / `lumen invoke` |
| 手势开关 | 查看节点上的手势识别器（状态、目标动作、代理），单独启用或禁用；命令行 `lumen gestures` |
| 约束诊断 | Auto Layout 歧义、固有尺寸、抗拉伸与抗压缩优先级、影响该节点的全部约束；命令行 `lumen constraints` |
| 点击诊断（hit-test） | 解释某一点命中了谁、其他视图为何被跳过、响应链与候选手势；命令行 `lumen hittest` |
| 无障碍 | 按 VoiceOver 朗读顺序列出无障碍元素（label、value、hint、traits）；命令行 `lumen a11y` |
| 外观覆盖 | 运行时切换深色模式、Dynamic Type 字号、从右到左布局；命令行 `lumen appearance` |
| 审计 | 检查触控区域过小、文字截断、对比度低、遮挡、布局歧义、无障碍缺失等问题，可导出报告，可配置阈值作为 CI 判定；命令行 `lumen audit` |
| 时间轴 | 连接期间每次层级变化记入时间轴，可回看历史快照，并比较任意两个时间点之间的变化 |
| 设计稿对比 | 在画布上叠加参考图（叠加 / 差异模式、可调不透明度），对齐窗口后给出还原度 |
| 复制与导出 | 复制类名、Lumen 选择器、节点描述，复制为 AI 提示，导出节点截图 |
| 自动刷新 | 按间隔刷新，并在 App 通知层级变化时自动刷新 |
| 选择器查询 | 类 CSS 语法：类名、`#identifier`、`[text*="登录"]`、`:visible`、后代 / 子代组合 |
| `.lumen` 完整归档 | 把层级、全部节点详情与纹理存成单个 `.lumen` 文件（App 菜单“导出快照…”或 `lumen archive save`），可在 App 中离线打开，也可离线查询、审计、对比 |
| JSON 快照与对比 | `lumen snapshot save` 保存 JSON 层级快照（`lumen.snapshot` 格式），与另一个快照或当前界面 diff，可作为 CI 断言 |
| 命令行 | `lumen` 覆盖发现 App（本机、USB 真机、局域网）、层级、查询、节点详情、截图、快照与归档、审计、运行时修改、源码定位、注入启动 |
| AI 助手 | `lumen mcp` 以 MCP 服务运行，提供层级、查询、节点详情、截图、快照对比、审计、hit-test、约束、无障碍、改属性、调用方法、外观覆盖、源码定位等工具 |
| 零改动注入 | `lumen launch` 把采集端注入 macOS 程序或 iOS 模拟器中的 App，无需改动工程 |
| 平台 | 被调试端：iOS、tvOS、visionOS（UIKit）与 macOS（AppKit），visionOS 需用 Swift Package Manager 接入；客户端：macOS 14 及以上 |

## 下载

从 [Releases](https://github.com/wangwanjie/Lumen/releases/latest) 下载对应芯片的安装包：

| 芯片 | 下载 |
|---|---|
| Apple 芯片（M 系列） | [Lumen_arm64.dmg](https://github.com/wangwanjie/Lumen/releases/latest/download/Lumen_arm64.dmg) |
| Intel | [Lumen_x86_64.dmg](https://github.com/wangwanjie/Lumen/releases/latest/download/Lumen_x86_64.dmg) |

打开 DMG，把 Lumen 拖进「应用程序」。安装包经过 Apple 公证，App 内置自动更新（菜单「Lumen → 检查更新…」）。
不确定芯片类型：苹果菜单 → 关于本机，「芯片」一栏显示 Apple M 系列选 arm64，显示 Intel 选 x86_64。

## 接入被调试的 App

采集端 `LumenServer` 只应出现在 Debug 构建中。三种方式任选其一。

### 1. Swift Package Manager

Xcode 中 File → Add Package Dependencies，输入 `https://github.com/wangwanjie/Lumen.git`，把 `LumenServer` 加到 App target；或在 `Package.swift` 中：

```swift
dependencies: [
    .package(url: "https://github.com/wangwanjie/Lumen.git", from: "0.1.0"),
],
targets: [
    .target(name: "MyApp", dependencies: [
        .product(name: "LumenServer", package: "Lumen"),
    ]),
]
```

启动时调用：

```swift
#if DEBUG
import LumenServer
#endif

// 例如在 application(_:didFinishLaunchingWithOptions:) 或 applicationDidFinishLaunching 中：
#if DEBUG
LumenServer.start()
#endif
```

SPM 无法按配置链接依赖，Release 构建也会链接 LumenServer，但 `#if DEBUG` 保证它不会启动。希望 Release 包里完全不含采集端时，用 CocoaPods 方式。

### 2. CocoaPods（仅 Debug 配置）

```ruby
pod 'LumenServer', :podspec => 'https://raw.githubusercontent.com/wangwanjie/Lumen/v0.1.0/LumenServer.podspec', :configurations => ['Debug']
```

代码同上（`#if DEBUG` 中 `import LumenServer` 并调用 `LumenServer.start()`）。

### 3. 零改动注入：`lumen launch`

不修改工程，直接把采集端注入启动：

```bash
LUMEN=/Applications/Lumen.app/Contents/Helpers/lumen

# macOS 程序（可执行文件或 .app）
$LUMEN launch --mac /path/to/MyApp.app

# iOS 模拟器中已安装的 App（booted 或模拟器 UDID）
$LUMEN launch --simulator booted com.example.MyApp
```

注入库随 App 安装在 `/Applications/Lumen.app/Contents/Helpers/`，`lumen` 会自动找到。受 SIP 保护的系统程序、启用 Hardened Runtime 且未允许 DYLD 环境变量的程序无法注入，请改用前两种方式。

启动被调试的 App 后打开 Lumen，它会自动发现本机的 App 并连接；同时运行多个 App 时在工具栏中切换。

## 调试真机

### USB 连接（推荐）

采集端默认只监听设备本机回环地址，USB 连接经 usbmuxd 转发到达，无需额外配置：

1. 按上文集成 LumenServer（Debug 构建中调用 `LumenServer.start()`），把 App 装到 iPhone / iPad 上运行；
2. 用数据线连接这台 Mac，并在设备上选择“信任此电脑”；
3. 打开 Lumen，在工具栏的 App 列表中按“USB 设备：设备名”分组选择；插拔设备后列表会立即刷新。

命令行同样可用：

```bash
lumen devices                                   # 列出 USB 连接的设备与 UDID
lumen apps                                      # 本机与 USB 真机上已集成 Lumen 的 App
lumen --device <UDID> hierarchy --depth 4       # 只看该设备上的 App
```

### 局域网（不插线）

客户端通过 Bonjour 服务 `_lumen._tcp` 发现局域网中的 App，App 需开启局域网连接并广播该服务：

1. 在宿主 App 的 Info.plist 中设置布尔键 `LumenAllowsNetworkConnections = YES`（之后照常调用 `LumenServer.start()`），或在代码中调用 `LumenServer.start(allowsNetworkConnections: true)`；
2. 在 Info.plist 中声明本地网络权限：

```xml
<key>NSLocalNetworkUsageDescription</key>
<string>用于 Lumen 界面调试（仅 Debug 构建）</string>
<key>NSBonjourServices</key>
<array>
    <string>_lumen._tcp</string>
</array>
```

3. 首次运行时在设备上允许本地网络权限；
4. 在 Lumen 的设置中勾选“发现局域网设备”，或在命令行中加 `--network`（例如 `lumen apps --network`）。

## AI 助手接入（MCP）

`lumen mcp` 以 [Model Context Protocol](https://modelcontextprotocol.io) 服务运行，提供列出与选择 App、读取层级、选择器查询、按文本查找、节点详情、截图、快照对比、审计、hit-test、约束诊断、无障碍、运行时改属性、调用方法、外观覆盖、源码定位等工具。

Claude Code：

```bash
claude mcp add lumen -- /Applications/Lumen.app/Contents/Helpers/lumen mcp
```

Cursor 等支持 `mcpServers` 配置的客户端：

```json
{
  "mcpServers": {
    "lumen": {
      "command": "/Applications/Lumen.app/Contents/Helpers/lumen",
      "args": ["mcp"]
    }
  }
}
```

## 命令行速查

在终端中使用时可以建一个软链接：

```bash
sudo ln -sf /Applications/Lumen.app/Contents/Helpers/lumen /usr/local/bin/lumen
```

| 命令 | 作用 |
|---|---|
| `lumen apps` | 列出正在运行、已集成 Lumen 的 App（本机与 USB 真机，`--network` 时含局域网） |
| `lumen devices` | 列出 USB 连接的设备（UDID） |
| `lumen hierarchy [--depth N] [--visible]` | 输出层级树，每个节点一行 |
| `lumen query 'UIButton[text*="登录"]:visible'` | 按选择器查找节点 |
| `lumen node 12` | 节点详情：继承链与按类分组的属性 |
| `lumen screenshot 12 -o node.png` | 保存节点截图 |
| `lumen snapshot save before.json` | 保存 JSON 层级快照（用于对比） |
| `lumen snapshot diff before.json --exit-code` | 与当前界面对比，有差异时退出码为 1 |
| `lumen archive save current.lumen` | 保存完整归档（层级、节点详情与纹理），可在 App 中离线打开 |
| `lumen audit --fail-on error` | 审计界面问题，存在错误级发现时退出码为 1 |
| `lumen set 12 UIView.alpha 0.5` | 运行时修改属性 |
| `lumen launch --mac <App>` | 零改动注入启动 |
| `lumen mcp` | 以 MCP 服务运行 |

全局选项：`--json` 输出稳定的 JSON，`--app <名称|bundle id|pid|UDID>` 指定目标 App，`--device <UDID|设备名>` 只看该真机上的 App，`--network` 额外发现局域网中的 App，`--port N` 直连端口。`lumen help <命令>` 查看详细说明。

## 隐私与安全

- 采集端只应在 Debug 构建中集成：SPM 用 `#if DEBUG` 包住启动代码，CocoaPods 用 `:configurations => ['Debug']`。
- 默认只监听本机回环地址（127.0.0.1），并拒绝非本机来源的连接；模拟器、Mac App 与 USB 连接的真机使用这种方式。
- 局域网访问需要显式开启：Info.plist 设置 `LumenAllowsNetworkConnections = YES` 或调用 `LumenServer.start(allowsNetworkConnections: true)`，开启后监听所有网卡并广播 Bonjour 服务 `_lumen._tcp`（见“调试真机”）。
- 密码框（安全输入框）的文本一律以掩码返回，不会离开被调试的 App。
- 所有数据只在本机的 Lumen、`lumen` 与被调试 App 之间传输，不上传任何服务器。

## 许可

Lumen.app、`lumen` 命令行工具与 LumenServer SDK 以二进制形式免费提供，可在自己 App 的 Debug 构建中集成 SDK；不得反编译、修改或单独再分发，详见 [LICENSE](LICENSE)。© 2026 wangwanjie，保留所有权利。
