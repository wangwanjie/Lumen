<p align="center">
  <img src="assets/AppIcon.png" width="128" height="128" alt="Lumen">
</p>

<h1 align="center">Lumen</h1>

<p align="center">iOS / macOS 界面调试工具：3D 分层查看界面层级，并提供命令行与 MCP 接口，让脚本、CI 与 AI 助手也能读取界面。</p>

<p align="center"><a href="https://lumen.vanjay.cn">官网</a> · <a href="README.en.md">English</a></p>

## 能力一览

Lumen 用来查看运行中 App 的视图层级，并把同一套能力开放给命令行与 AI 助手，支持 macOS AppKit 程序与零改动注入。

| 能力 | 说明 |
|---|---|
| 2D / 3D 层级画布 | Metal 渲染，平面与分层 3D 视图切换，可调层间距、相机复位，显示隐藏节点与边框线，间距测量；“定位”后目标图层闪烁高亮；还原 iOS 26 / 27 标签栏的液态玻璃底板与选中镜片；加载与刷新时显示进度、耗时与图层数 |
| 层级大纲 | 树形大纲与画布联动选中，按类名、文本等过滤；每行完整显示，宽度不够时横向滚动；可在设置中调整字号、行高与层级引导竖线 |
| 屏蔽的类 | 在设置中维护要屏蔽的类，画布不渲染命中的节点及其子树，大纲灰显标识，可临时显示、重新屏蔽或一键屏蔽此类 |
| SwiftUI | 在宿主视图之下给出 SwiftUI 的逻辑视图树：`Text` 的文字、`Button` / `Toggle` / `TextField` 等控件、修饰符链与参数、调试数据中的属性值（含 `@State`），可按文本查找；集成 LumenServer 或注入后自动开启 |
| 属性检查器 | 按类分组的属性、继承链、所属 ViewController、实例变量名、accessibilityIdentifier、窗口坐标 |
| 运行时改属性 | 在检查器中直接修改可编辑属性（数值拖动微调、取色、文本等），修改记录可撤销、可复制为 AI 提示；命令行 `lumen set` |
| 调用方法 | 控制台中列出并调用节点、layer 或所属 ViewController 上的方法；命令行 `lumen methods` / `lumen invoke` |
| 手势 | 大纲行首的竖条标出挂有手势识别器的视图，点按弹出手势面板；查看类名、父类、持有它的实例变量、状态、目标动作与代理，单独启用或禁用；命令行 `lumen gestures` |
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
| 目标选择 | 以卡片网格列出可调试的 App，按平台分组、按设备归类，标明 USB / Wi-Fi / 局域网 / 模拟器 / 本机，卡片显示主窗口预览 |
| 后台提示 | 目标 App 进入后台或被挂起时给出提示与重试，恢复后自动重新拉取层级与纹理 |
| 一键接入 | `python3 /Applications/Lumen.app/Contents/Resources/lumen_setup.py` 把采集端接入 Xcode 工程的 Debug 配置（iOS 模拟器 / 真机、tvOS、macOS），无需改 Podfile / Package，`--remove` 原样撤销 |
| 零改动注入 | `lumen launch` 把采集端注入 macOS 程序或 iOS 模拟器中的 App，无需改动工程 |
| 平台 | 被调试端：iOS 15+、Mac Catalyst 15+、tvOS 15+、visionOS（UIKit）与 macOS 12+（AppKit）；客户端：macOS 14 及以上 |

## 下载

从 [Releases](https://github.com/wangwanjie/Lumen/releases/latest) 下载对应芯片的安装包：

| 芯片 | 下载 |
|---|---|
| Apple 芯片（M 系列） | [Lumen_arm64.dmg](https://github.com/wangwanjie/Lumen/releases/latest/download/Lumen_arm64.dmg) |
| Intel | [Lumen_x86_64.dmg](https://github.com/wangwanjie/Lumen/releases/latest/download/Lumen_x86_64.dmg) |

打开 DMG，把 Lumen 拖进「应用程序」。安装包经过 Apple 公证，App 内置自动更新（菜单「Lumen → 检查更新…」）。
不确定芯片类型：苹果菜单 → 关于本机，「芯片」一栏显示 Apple M 系列选 arm64，显示 Intel 选 x86_64。

## 接入被调试的 App

采集端 `LumenServer` 只应出现在 Debug 构建中。四种方式任选其一，不想改依赖配置时推荐一键脚本。

### 1. 一键脚本（推荐，零配置）

在工程目录（含 `.xcworkspace` / `.xcodeproj`）运行：

```bash
python3 /Applications/Lumen.app/Contents/Resources/lumen_setup.py
```

脚本只改 App target 的 Debug 配置，不需要改 Podfile、Package 或写任何代码：

- Build Phases 末尾加 Run Script「[Lumen] Embed LumenInject」，构建时按平台（iOS 模拟器 / 真机、tvOS、macOS）把 Lumen.app 内预编译的采集端拷进 App 的 Frameworks，并用 App 的签名身份重签（真机可直接运行）；Release 等其他配置不拷贝，发布包里没有 Lumen；
- 在这些配置里关闭 `ENABLE_USER_SCRIPT_SANDBOXING`（Run Script 需要读取 Lumen.app）；
- 在 `didFinishLaunching` / `applicationDidFinishLaunching` / SwiftUI App 的 `init` 最前面插入几行加载代码（Swift / Objective-C 自动识别），加载后自动启动采集端。

所有改动都带标记，重复运行是安全的。这些改动只用于本地调试，不要提交：

```bash
SETUP=/Applications/Lumen.app/Contents/Resources/lumen_setup.py
python3 $SETUP --remove                 # 原样撤销（切换分支前执行）
python3 $SETUP --dry-run                # 只打印将要做的改动
python3 $SETUP --target MyApp           # 只处理指定 App target；--configs Debug,Beta 指定配置
```

CocoaPods 工程可以让 `pod install` 自动接入：`python3 $SETUP --install-pod-hook` 在 Podfile 加一个可提交的 `post_integrate` 钩子，本机 `export IntegrateLumen=true` 后每次 `pod install` 自动接入，未设置时自动撤销；未安装 Lumen.app 的同事不受影响。已通过 SPM / CocoaPods 集成 `LumenServer` 的 target 会被跳过。

### 2. Swift Package Manager

SDK 以预编译的 `LumenServer.xcframework` 发布（iOS、Mac Catalyst、macOS、tvOS、visionOS 的真机与模拟器），首次解析包时从 GitHub Release 下载并校验。

Xcode 中 File → Add Package Dependencies，输入 `https://github.com/wangwanjie/Lumen.git`，把 `LumenServer` 加到 App target；或在 `Package.swift` 中：

```swift
dependencies: [
    .package(url: "https://github.com/wangwanjie/Lumen.git", from: "0.2.2"),
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

Objective-C 工程用同名入口类 `LumenServer`（无需 Swift 桥接文件）：

```objc
#if DEBUG
@import LumenServer;   // CocoaPods 未开启模块时可改为 #import <LumenServer/LumenServer-Swift.h>
#endif

// 在 application:didFinishLaunchingWithOptions: 或 applicationDidFinishLaunching: 中：
#if DEBUG
[LumenServer start];   // 开放局域网：[LumenServer startAllowingNetworkConnections:YES]
#endif
```

SPM 无法按配置链接依赖，Release 构建也会链接 LumenServer，但 `#if DEBUG` 保证它不会启动。希望 Release 包里完全不含采集端时，用 CocoaPods 方式。

### 3. CocoaPods（仅 Debug 配置）

```ruby
pod 'LumenServer', :podspec => 'https://raw.githubusercontent.com/wangwanjie/Lumen/v0.2.2/LumenServer.podspec', :configurations => ['Debug']
```

代码同上（Swift：`#if DEBUG` 中 `import LumenServer` 并调用 `LumenServer.start()`；Objective-C：`@import LumenServer;` 后 `[LumenServer start]`）。

### 4. 零改动注入：`lumen launch`

不修改工程，直接把采集端注入启动：

```bash
LUMEN=/Applications/Lumen.app/Contents/Helpers/lumen

# macOS 程序（可执行文件或 .app）
$LUMEN launch --mac /path/to/MyApp.app

# iOS 模拟器中已安装的 App（booted 或模拟器 UDID）
$LUMEN launch --simulator booted com.example.MyApp
```

注入库随 App 安装在 `/Applications/Lumen.app/Contents/Helpers/`，`lumen` 会自动找到。受 SIP 保护的系统程序、启用 Hardened Runtime 且未允许 DYLD 环境变量的程序无法注入，请改用前三种方式。

启动被调试的 App 后打开 Lumen，它会自动发现本机的 App 并连接；同时运行多个 App 时在工具栏中切换。

## 调试真机

### USB 连接（推荐）

采集端默认只监听设备本机回环地址，USB 连接经 usbmuxd 转发到达，无需额外配置：

1. 按上文集成 LumenServer（一键脚本，或在 Debug 构建中调用 `LumenServer.start()`），把 App 装到 iPhone / iPad 上运行；
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

在 Claude Code 中输入 `/mcp` 确认已连接；输入 `/mcp__lumen__lumen_ui_debug_workflow` 并附上问题描述，可按内置流程排查。

Codex（CLI、IDE 插件与 ChatGPT 桌面 App 共用 `~/.codex/config.toml`，添加一次即可）：

```bash
codex mcp add lumen -- /Applications/Lumen.app/Contents/Helpers/lumen mcp
codex mcp list
```

或直接写入配置文件：

```toml
# ~/.codex/config.toml
[mcp_servers.lumen]
command = "/Applications/Lumen.app/Contents/Helpers/lumen"
args = ["mcp"]
```

ChatGPT：使用 macOS 版 ChatGPT 桌面 App，在设置的「MCP 服务器」中添加 STDIO 服务器，命令填 `/Applications/Lumen.app/Contents/Helpers/lumen`，参数填 `mcp`；已在 Codex 中添加过则无需重复配置。网页版 ChatGPT 只能连接公网可访问的远程 MCP 服务，无法直接使用本机的 Lumen；若桌面 App 的普通对话中看不到 Lumen 工具，在桌面 App 的 Codex 中使用。

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

接好后可以直接让 AI 助手用 Lumen 干活，例如：

- 「登录页的『忘记密码』按钮点了没反应，用 Lumen 查一下是不是被别的视图挡住了，告诉我该改哪个文件。」
- 「按 design/profile.png 写个人资料页，运行后用 Lumen 截图和层级对照设计稿，修正间距、字号和颜色的偏差。」
- 「深色模式下设置页的分组标题看不清，用 Lumen 切到深色模式复现，找出写死颜色的地方并修复。」

更多示例见 [官网](https://lumen.vanjay.cn/#ai-examples)。

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

- 采集端只应在 Debug 构建中集成：一键脚本只在 Debug 配置把采集端拷进 App，SPM 用 `#if DEBUG` 包住启动代码，CocoaPods 用 `:configurations => ['Debug']`。
- 默认只监听本机回环地址（127.0.0.1），并拒绝非本机来源的连接；模拟器、Mac App 与 USB 连接的真机使用这种方式。
- 局域网访问需要显式开启：Info.plist 设置 `LumenAllowsNetworkConnections = YES` 或调用 `LumenServer.start(allowsNetworkConnections: true)`，开启后监听所有网卡并广播 Bonjour 服务 `_lumen._tcp`（见“调试真机”）。
- 密码框（安全输入框）的文本一律以掩码返回，不会离开被调试的 App。
- 所有数据只在本机的 Lumen、`lumen` 与被调试 App 之间传输，不上传任何服务器。

## 许可

Lumen.app、`lumen` 命令行工具与 LumenServer SDK 以二进制形式免费提供，可在自己 App 的 Debug 构建中集成 SDK；不得反编译、修改或单独再分发，详见 [LICENSE](LICENSE)。© 2026 wangwanjie，保留所有权利。
