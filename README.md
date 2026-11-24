<p align="center">
  <img src="assets/AppIcon.png" width="128" height="128" alt="Lumen">
</p>

<h1 align="center">Lumen</h1>

<p align="center">iOS / macOS 界面调试工具：3D 分层查看界面层级，并提供命令行与 MCP 接口，让脚本、CI 与 AI 助手也能读取界面。</p>

<p align="center"><a href="https://lumen.vanjay.cn">官网</a> · <a href="README.en.md">English</a></p>

https://github.com/user-attachments/assets/145638f3-5af4-4100-ad07-fdfa3a7fb970

<p align="center"><sub>▶ 宣传片（1 分 42 秒，有背景音乐）· <a href="https://lumen.vanjay.cn/#tour">在官网观看章节版</a></sub></p>

**为 AI 编程准备好的界面调试器。** 免费使用，内置 MCP 服务与命令行：

```bash
claude mcp add lumen -- /Applications/Lumen.app/Contents/Helpers/lumen mcp
```

一行命令后，Claude Code、Codex、ChatGPT 桌面 App、Cursor 等 AI 助手就能读取运行中 App 的层级、截图、审计、改属性、定位源码。模拟器、USB 真机、任意 Mac 应用、未加壳的第三方 ipa 都能直接调试，UIKit、SwiftUI、AppKit 全支持。

## 能力一览

Lumen 用来查看运行中 App 的视图层级，并把同一套能力开放给命令行与 AI 助手，支持 macOS AppKit 程序与零改动注入。

| 能力 | 说明 |
|---|---|
| 2D / 3D 层级画布 | Metal 渲染，平面与分层 3D 视图切换（透视投影，3D 分层跟随大纲的展开与折叠），可调层间距（⌘[ / ⌘]）、相机复位，显示隐藏节点与边框线；间距测量分关闭、父视图边距、锁定两节点三档；按 `layer.mask` 裁剪，不画被遮罩挡住的内容；搜索结果在画布上着色、其余淡化；无内容图层可选透明、只描边框或淡色底板；“定位”后目标图层闪烁高亮；还原 iOS 26 / 27 标签栏的液态玻璃底板与选中镜片，以及网页、Metal、视频、Lottie、SwiftUI 列表图标与 `foregroundStyle` 着色、OpenGL 绘制的窗口（如 Qt 5 App）、Electron / Chromium 网页等图层的内容；液态玻璃按真实的模糊半径还原；3D 下展开 / 折叠时层栈以中间为基准对称伸缩，各层平滑移到新深度；画布控件是可停靠在上 / 下 / 左 / 右边缘的悬浮胶囊（左右时竖排，拖动或右键切换位置）、底部路径栏（从根到所选节点，逐段可点）与缩放百分比；状态栏显示加载阶段、纹理进度与耗时 |
| 层级大纲 | 树形大纲与画布联动选中，悬停行时画布同步高亮；按类名、文本等过滤，搜索结果可继续下钻；键入类名或控制器名前缀直接定位；层级深度预设（⌥⌘1…⌥⌘5）按窗口与 ViewController 展开；聚焦模式只看某个节点的子树（Esc 退出）；按 App 记住展开状态；顶层列出 `UIWindowScene` 与 Layout Guide；层级很深时缩进自动收窄，深层节点也能看全；可在设置中调整字号、行高与层级引导竖线 |
| 屏蔽的类 | 在设置中维护要屏蔽的类，画布不渲染命中的节点及其子树，大纲灰显标识，可临时显示、重新屏蔽或一键屏蔽此类 |
| SwiftUI | 在宿主视图之下给出 SwiftUI 的逻辑视图树：`Text` 的文字、`Button` / `Toggle` / `TextField` 等控件、修饰符链与参数、调试数据中的属性值（含 `@State`），可按文本查找；集成 LumenServer 或注入后自动开启。逻辑节点渐进加载：首次读取慢的宿主先显示平台层级，空闲时在后台逐个补读并自动推送，iOS“设置”这类大型 App 首屏从约 26 秒缩短到 0.4 秒 |
| 属性检查器 | 几何读数卡（父视图与所选节点的尺寸、四边边距、原点与窗口坐标）；按类分组的属性、继承链（悬停显示所在的 framework）、所属 ViewController、实例变量名及其持有者、accessibilityIdentifier；`contentMode`、`textAlignment` 等枚举显示名称并可下拉修改；控件的“事件处理”栏列出 target-action 与 `UIAction` |
| 运行时改属性 | 在检查器中直接修改可编辑属性（数值拖动微调、取色、文本等），值为 nil 的颜色与文本同样可改；大纲与画布的右键菜单可直接隐藏 / 显示节点；修改记录可撤销、可复制为 AI 提示；命令行 `lumen set`（枚举可按名称设置，如 `scaleAspectFit`） |
| App 自定义属性 | 在 view / layer / ViewController 上实现 `@objc lumen_debugInfo()`，把业务状态显示在检查器最前面，带 setter 的项可直接修改；实现 `+lumen_colorAliases` 后颜色属性旁显示设计色别名（见下文“自定义检查器内容”） |
| 调用方法 | 控制台中列出并调用节点、layer 或所属 ViewController 上的方法，方法名输入时预测并支持 Tab 补全，参数按签名逐个填写（颜色参数可用取色面板）；返回的对象可继续作为调用目标、列出方法或在大纲中选中；命令行 `lumen methods` / `lumen invoke` |
| 手势 | 大纲行首的竖条标出挂有手势识别器的视图，点按弹出手势面板；查看类名、父类、持有它的实例变量、状态、目标动作与代理，单独启用或禁用；命令行 `lumen gestures` |
| 约束诊断 | Auto Layout 歧义、固有尺寸、抗拉伸与抗压缩优先级、影响该节点的全部约束；命令行 `lumen constraints` |
| 点击诊断（hit-test） | 解释某一点命中了谁、其他视图为何被跳过、响应链与候选手势；命令行 `lumen hittest` |
| 无障碍 | 按 VoiceOver 朗读顺序列出无障碍元素（label、value、hint、traits）；命令行 `lumen a11y` |
| 外观覆盖 | 运行时切换深色模式、Dynamic Type 字号、从右到左布局；命令行 `lumen appearance` |
| 审计 | 检查触控区域过小、文字截断、对比度低、遮挡、布局歧义、无障碍缺失、遮罩把内容整个挡住或只露出一小部分等问题，并给出原因与修复建议；可导出报告，可配置阈值作为 CI 判定；命令行 `lumen audit` |
| 时间轴 | 连接期间每次层级变化记入时间轴，可回看历史快照，并比较任意两个时间点之间的变化 |
| 设计稿对比 | 在画布上叠加参考图（叠加 / 差异模式、可调不透明度），对齐窗口后给出还原度 |
| 复制与导出 | 复制类名、Lumen 选择器、节点描述，复制为 AI 提示，导出节点截图 |
| 自动刷新 | 默认仅手动刷新；可开启按间隔刷新或在 App 通知层级变化时自动刷新，开启时工具栏按钮高亮并显示状态，每次应用变化时闪一下；正在点击、拖动、滚动或编辑时新层级先记入时间轴，停手后再替换界面 |
| 选择器查询 | 类 CSS 语法：类名、`#identifier`、`[text*="登录"]`、`:visible`、后代 / 子代组合 |
| `.lumen` 完整归档 | 把层级、全部节点详情与纹理存成单个 `.lumen` 文件（App 菜单“导出快照…”或 `lumen archive save`），可在 App 中离线打开，也可离线查询、审计、对比 |
| JSON 快照与对比 | `lumen snapshot save` 保存 JSON 层级快照（`lumen.snapshot` 格式），与另一个快照或当前界面 diff，可作为 CI 断言 |
| 命令行 | `lumen` 覆盖发现 App（本机、USB 真机、局域网）、层级、查询、节点详情、截图、快照与归档、审计、运行时修改、源码定位、注入启动 |
| AI 助手 | `lumen mcp` 以 MCP 服务运行，提供层级、查询、节点详情、截图、快照对比、审计、hit-test、约束、无障碍、改属性、调用方法、外观覆盖、源码定位、应用日志查询等工具 |
| 目标选择 | 以卡片网格列出可调试的 App，按平台分组、按设备归类，标明 USB / Wi-Fi / 局域网 / 模拟器 / 本机，卡片显示主窗口预览；同一进程里同时有集成与注入的两份采集端时只列一份 |
| 后台提示 | 目标 App 进入后台或被挂起时给出提示与重试，恢复后自动重新拉取层级与纹理 |
| 断线保留现场 | 目标 App 退出、崩溃或网络断开时，最后一份层级、已读取的详情与纹理继续以只读方式显示，可另存为 `.lumen` 快照；同一 App 重新出现时自动切回实时 |
| 应用日志 | 开启“采集日志”后（默认关闭，在设置或面板工具栏开启），底部“应用日志”面板显示标准输出 / 错误与 os_log，启动调试的 App 与集成了 LumenServer 的 App 都能看；虚拟化列表应对大量日志，支持文本筛选、来源与级别过滤、白名单与黑名单规则 |
| 界面语言与外观 | 界面支持简体中文、English、繁體中文，切换后立即生效；外观可跟随系统、浅色或深色 |
| 一键接入 | `python3 /Applications/Lumen.app/Contents/Resources/lumen_setup.py` 把采集端接入 Xcode 工程的 Debug 配置（iOS 模拟器 / 真机、tvOS、macOS），无需改 Podfile / Package，`--remove` 原样撤销 |
| 零改动注入 | “启动调试”窗口（⌘N）与 `lumen launch`：不改工程，注入启动 Mac App（含 Mac Catalyst）、模拟器中的 App、iOS 安装包（Apple 芯片的 Mac 上直接运行，可按 iPhone 机型尺寸运行）与 USB 真机上的 App；拖入 `.ipa` 时询问在本机还是真机运行；签名会挡住注入时自动重签副本；兼容 Electron / Chromium 内核的 App（含 Mac App Store 版）、iPad 版 Mac App、被 Gatekeeper 拦下的 App 与启动时检测注入的 App；模拟器中的系统 App（设置、Safari 等）也能注入调试；启动窗口支持列表 / 图标两种显示与搜索；真机借 Xcode 中登录的 Apple ID（免费账号即可）自动签名，到期前提醒续签；最近启动可一键重启 |
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
    .package(url: "https://github.com/wangwanjie/Lumen.git", from: "0.3.2"),
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
pod 'LumenServer', :podspec => 'https://raw.githubusercontent.com/wangwanjie/Lumen/v0.3.2/LumenServer.podspec', :configurations => ['Debug']
```

代码同上（Swift：`#if DEBUG` 中 `import LumenServer` 并调用 `LumenServer.start()`；Objective-C：`@import LumenServer;` 后 `[LumenServer start]`）。

### 4. 零改动注入：启动调试

不修改工程，直接把采集端注入启动。最省事的是在 Lumen 中点工具栏的“启动调试”（⌘N），或把 `.app` / `.ipa` 拖进窗口、拖到程序坞图标上：

- **Mac 应用**：从列表中选择或选择任意 `.app` / 可执行文件。启用 Hardened Runtime、库验证的 App（多数从官网下载的 App 都是）会先列出重签的影响，确认后复制到 `~/Library/Caches/lumen/resigned/` 做 ad-hoc 重签再启动副本，原 App 不改动。Mac Catalyst App 经 LaunchServices 注入启动。以下情况也会自动处理：
  - **Electron / Chromium 内核的 App**（Google Chrome、balenaEtcher、Mac App Store 上的网易云音乐等）：采集端只在主进程启动，GPU、渲染等辅助进程不受影响；带沙盒继承的辅助程序随主程序一起重签；副本使用独立的用户数据目录（`~/Library/Caches/lumen/resigned-data/`），不与原 App 争用单实例锁，也不读写原 App 的登录状态与 Cookie。Discord 这类自行决定数据目录、并会读取宿主签名证书的 App 也已适配：数据目录经它认的环境变量同样指向独立目录，副本改用钥匙串里的开发证书签名（在 Xcode 中登录 Apple ID 即有，免费账号即可）。
  - **iPad 版 Mac App**（如酷狗音乐）与包内带非 Mach-O 文件的 App（如 Qt 打包的 DB Browser for SQLite）可正常重签启动。
  - **被 Gatekeeper 拦下的 App**（带下载隔离标记且未公证、你也没有在“仍要打开”中放行）：改为启动去掉隔离标记的重签副本，原 App 保持原样。
  - **启动时检测注入的 App**：部分 App 启动时枚举已加载的库，发现外来库就退出。“隐藏注入库”默认开启，把注入库从 App 看到的 dyld 镜像列表中去掉；它只能挡住按镜像名 / 数量枚举的检测，请仅用于你有权调试的 App。
- **模拟器**：选择模拟器与其中的 App（未启动的模拟器会自动启动），或安装模拟器构建的 `.app` 后启动。用户 App 与系统 App（设置、Safari 等）分组列出，系统 App 同样可以注入调试；设备菜单中绿点表示已启动的模拟器。

“Mac 应用”与“模拟器”标签可在列表和图标两种显示方式间切换，图标取自 App 本身；搜索框按名称或 bundle id 过滤，列表与说明区之间的分隔条可拖动调整高度。“最近启动”右键菜单列出原始文件与安装位置（重签副本、本机运行副本、模拟器中的安装目录、装到真机前的副本），可在访达中显示或复制路径。
- **iOS 安装包**：在 Apple 芯片的 Mac 上直接运行 `.ipa` 或 iOS 真机构建的 `.app`——解包到缓存后把二进制改为 Mac Catalyst 平台、ad-hoc 签名运行；同一个包第二次启动复用副本。只适配 iPhone 的应用在 Mac 上默认是 iPad 布局，可在“屏幕尺寸”里选一个机型（或自定义尺寸）以该尺寸运行，方便用不同尺寸调 UI；要最真实的 iPhone 布局用模拟器或真机。
- **真机**：选择 USB 连接的 iPhone / iPad 与安装包，Lumen 把注入库放进包内，用你的 Apple Development 证书重签后安装启动。证书与描述文件来自 Xcode 中登录的 Apple ID（免费账号即可，7 天有效，到期前一天提醒并可一键续签）；付费账号也可以在“设置 › 签名”中导入 App Store Connect API 密钥。Lumen 不接触你的 Apple ID 密码。

无法启动时会说明原因并给出解决方案（例如 FairPlay 加密、Intel Mac 运行 iOS 包、设备未信任开发者），常见的处理可以一键执行。成功后自动连接；“重新启动当前 App”（⌥⌘R）沿用上次的方式重启并恢复选中的节点。

日志采集默认关闭，避免日志量很大的 App 白白占用 CPU 与内存；在“设置 › 通用 › 应用日志”或日志面板工具栏勾选“采集日志”后开启，开启时对当前连接的 App 立即补发最近一段历史，关闭时停止采集并清空面板（MCP 的 `lumen_get_logs` 自行订阅，不受此开关影响）。开启后，App 的标准输出 / 错误与 os_log（`Logger`、`os_log`）都显示在底部的“应用日志”面板：Mac App 与 iOS 包在本机运行时用 `log stream` 跟随进程的 os_log，模拟器同样，真机由注入库把 os_log 转写进控制台（不含调试级别）。“显示”菜单可开关精简行首（os_log 只留时分秒、类型与缩短的子系统:类别）与自动换行（长消息、多行消息在行内完整显示），两项默认开启；选中一行后在下方查看完整内容，⌘C 拷贝；错误红色、故障紫色、调试灰色。向上滚动会自动暂停“跟随最新”，滚回底部恢复，日志再多也不会把正在看的内容顶走。

不是由“启动调试”启动的 App（例如在设备上手动打开已注入的 App，或用 CocoaPods / SPM 集成了 LumenServer 的 App），连接后由采集端经 Lumen 连接推送日志，面板同样能看到，只要在调试就一直有：注入的 App 从库加载起采集 print / NSLog（同时照常输出到原来的控制台），集成方式在连接后才开始采集；os_log 读取进程启动以来的全部记录（不含调试级别，需 iOS 15 / macOS 12 及以上）。采集端保留最近一段历史，断线重连只补发断开期间的部分。工具栏可按文本筛选；“过滤”里可以选择来源、os_log 最低级别，并同时设置白名单（只显示命中任一条规则的行）与黑名单（隐藏命中任一条规则的行），规则按整行、消息、子系统、类别或进程 / 库做包含、等于、开头是或正则匹配，忽略大小写，设置对所有 App 生效。在日志上右键可以把选中文本或所在行的子系统直接加入白名单或黑名单。

命令行同样可用：

```bash
LUMEN=/Applications/Lumen.app/Contents/Helpers/lumen

# macOS 程序（可执行文件或 .app）；签名会挡住注入时加 --resign 启动重签副本
$LUMEN launch --mac /path/to/MyApp.app
$LUMEN launch --mac /Applications/SomeApp.app --resign
$LUMEN launch --mac /Applications/SomeApp.app --resign --show-injection   # 不隐藏注入库

# iOS 模拟器中已安装的 App（booted 或模拟器 UDID），或先安装模拟器构建的 .app
$LUMEN launch --simulator booted com.example.MyApp
$LUMEN launch --simulator <UDID> --install build/Debug-iphonesimulator/MyApp.app

# iOS 安装包：在本机运行（可选机型尺寸），或重签后安装到真机
$LUMEN launch --ios MyApp.ipa
$LUMEN launch --ios MyApp.ipa --iphone-model iphone-16-pro   # 按机型尺寸运行
$LUMEN launch --ios MyApp.ipa --device-size 393x852x3        # 自定义尺寸
$LUMEN launch --ios MyApp.ipa --keep-titlebar                # 保留窗口标题栏（默认隐藏）
$LUMEN launch --ios MyApp.ipa --allow-maximize               # 允许窗口最大化（默认禁用）
$LUMEN launch --ios MyApp.ipa --device "我的 iPhone"

$LUMEN simulators      # 列出模拟器与其中的 App
$LUMEN simulators <UDID> --system   # 用户 App 与系统 App 分组列出
$LUMEN identities      # 列出签名证书与开发描述文件
```

注入库随 App 安装在 `/Applications/Lumen.app/Contents/Helpers/` 与 `Contents/Resources/`，`lumen` 会自动找到。受 SIP 保护的系统程序、经过 FairPlay 加密的 App Store 应用无法这样调试。自己的 App 推荐用前三种方式。

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

## 自定义检查器内容

在 view、layer 或 ViewController 上实现 `@objc lumen_debugInfo()`，返回的属性显示在检查器最前面的自定义分组里，适合展示业务状态（订单号、实验分组、数据源等）。带 `retainedSetter` 的属性可以在检查器中直接修改，`enum` 用下拉菜单选择，`json` 按层级展开。只在 Debug 构建中编译即可：

```swift
#if DEBUG
extension WeatherBadgeView {
    @objc func lumen_debugInfo() -> [String: Any] {
        let setTemperature: @convention(block) (NSNumber) -> Void = { [weak self] value in
            self?.temperature = value.intValue
        }
        return [
            "properties": [
                ["section": "天气徽标", "title": "温度", "valueType": "number", "value": temperature,
                 "retainedSetter": setTemperature, "help": "摄氏度"],
                ["section": "天气徽标", "title": "天气图标", "valueType": "enum", "value": symbol,
                 "allEnumCases": ["sun.max.fill", "cloud.fill", "snowflake"]],
            ],
        ]
    }
}
#endif
```

`valueType` 可取 `string`、`number`、`bool`、`color`、`rect`、`size`、`point`、`insets`、`enum`、`shadow`、`json`，`help` 作为悬停提示。

设计稿里的颜色有名字时，在 `NSObject` 的分类里实现类方法 `lumen_colorAliases`，返回“别名 → 颜色”或“分组 → 别名 → 颜色”；检查器、命令行与 MCP 输出中，与别名一致的颜色属性旁会显示“品牌 / brandPrimary”这样的别名：

```swift
#if DEBUG
extension NSObject {
    @objc class func lumen_colorAliases() -> [String: Any] {
        return ["品牌": ["brandPrimary": UIColor.systemBlue], "textSecondary": UIColor.secondaryLabel]
    }
}
#endif
```

## AI 助手接入（MCP）

`lumen mcp` 以 [Model Context Protocol](https://modelcontextprotocol.io) 服务运行，提供列出与选择 App、读取层级、选择器查询、按文本查找、节点详情、截图、快照对比、审计、hit-test、约束诊断、无障碍、运行时改属性、调用方法、外观覆盖、源码定位、应用日志查询（`lumen_get_logs`：按文本 / 正则 / 级别 / 子系统过滤，`since` 游标增量读取，可等待新日志，可查看重启或崩溃前进程的日志）等工具。

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
| `lumen launch --mac <App> [--resign]` | 零改动注入启动；第三方 Hardened Runtime App 加 `--resign` 启动重签副本 |
| `lumen launch --ios <ipa> [--device <设备>]` | iOS 安装包在本机运行，或重签后安装到真机 |
| `lumen simulators [UDID [--system]]` / `lumen identities` | 列出模拟器与其中的 App（`--system` 含系统 App） / 签名证书与描述文件 |
| `lumen mcp` | 以 MCP 服务运行 |

全局选项：`--json` 输出稳定的 JSON，`--app <名称|bundle id|pid|UDID>` 指定目标 App，`--device <UDID|设备名>` 只看该真机上的 App，`--network` 额外发现局域网中的 App，`--port N` 直连端口。`lumen help <命令>` 查看详细说明。

## 隐私与安全

- 采集端只应在 Debug 构建中集成：一键脚本只在 Debug 配置把采集端拷进 App，SPM 用 `#if DEBUG` 包住启动代码，CocoaPods 用 `:configurations => ['Debug']`。
- 默认只监听本机回环地址（127.0.0.1），并拒绝非本机来源的连接；模拟器、Mac App 与 USB 连接的真机使用这种方式。
- 局域网访问需要显式开启：Info.plist 设置 `LumenAllowsNetworkConnections = YES` 或调用 `LumenServer.start(allowsNetworkConnections: true)`，开启后监听所有网卡并广播 Bonjour 服务 `_lumen._tcp`（见“调试真机”）。
- 经“启动调试”重签安装到真机的副本会开启局域网连接，以便设备经 Wi-Fi 连接时也能被发现；同一局域网中的设备都能连上这个副本，请在可信的网络中调试。
- “启动调试”只改动缓存中的副本：重签、去掉隔离标记都在 `~/Library/Caches/lumen/` 下的副本上进行，原 App 不改动；Chromium 内核 App 的副本使用独立的数据目录，不接触原 App 的登录状态与 Cookie。
- 密码框（安全输入框）的文本一律以掩码返回，不会离开被调试的 App。
- 所有数据只在本机的 Lumen、`lumen` 与被调试 App 之间传输，不上传任何服务器。

## 许可
## 赞助

Lumen 的全部功能免费开放。如果它帮到了你，欢迎通过微信或 USDT 赞助，收款码与地址见[官网赞助区](https://lumen.vanjay.cn/#sponsor)。


Lumen.app、`lumen` 命令行工具与 LumenServer SDK 以二进制形式免费提供，可在自己 App 的 Debug 构建中集成 SDK；不得反编译、修改或单独再分发，详见 [LICENSE](LICENSE)。© 2026 wangwanjie，保留所有权利。
