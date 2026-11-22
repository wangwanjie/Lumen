<p align="center">
  <img src="assets/AppIcon.png" width="128" height="128" alt="Lumen">
</p>

<h1 align="center">Lumen</h1>

<p align="center">A UI debugger for iOS and macOS apps: inspect view hierarchies in layered 3D, and read the same data from the command line or through MCP for scripts, CI and AI assistants.</p>

<p align="center"><a href="https://lumen.vanjay.cn">Website</a> · <a href="README.md">简体中文</a></p>

https://github.com/user-attachments/assets/145638f3-5af4-4100-ad07-fdfa3a7fb970

<p align="center"><sub>▶ Promo video (1:42, Chinese captions, with music) · <a href="https://lumen.vanjay.cn/#tour">chaptered version on the website</a></sub></p>

**A UI debugger built for AI-assisted development.** Free to use, with a built-in MCP server and CLI:

```bash
claude mcp add lumen -- /Applications/Lumen.app/Contents/Helpers/lumen mcp
```

After that one command, Claude Code, Codex, the ChatGPT desktop app, Cursor and other assistants can read the running app's hierarchy, take screenshots, run audits, change properties and locate source. Debug apps in the Simulator, on USB devices, any Mac app, or unencrypted third-party ipa files, across UIKit, SwiftUI and AppKit.

## Features

Lumen inspects the view hierarchy of a running app and exposes the same capabilities to the command line and AI assistants. It supports macOS AppKit apps and can inject itself without any project changes.

| Feature | Details |
|---|---|
| 2D / 3D canvas | Metal rendering; flat and exploded 3D views (perspective projection; 3D layers follow the outline's expanded and collapsed nodes), adjustable layer spacing (⌘[ / ⌘]), camera reset, hidden nodes and wireframes; measurements off, to the parent's edges, or locked between two nodes; content is clipped by `layer.mask`, so masked-out areas stay hidden; search matches are tinted on the canvas while the rest fades; empty layers can be transparent, outlined or drawn with a light plate; the layer flashes after Locate; renders the liquid-glass platter and selection lens of iOS 26 / 27 tab bars plus web, Metal, video and Lottie content, SwiftUI list icons and `foregroundStyle` tints, OpenGL-drawn windows (such as Qt 5 apps) and Electron / Chromium web content; liquid glass uses its real blur radius; a toolbar along the top, a path bar along the bottom (root to selection, each segment clickable) and a zoom percentage; the status bar shows the loading stage, texture progress and elapsed time |
| Hierarchy outline | Tree outline linked with the canvas, which highlights the row under the pointer; filter by class name, text and more, and drill into search results; type a class or view controller name prefix to jump to a row; depth presets (⌥⌘1…⌥⌘5) expand by window and view controller; focus mode shows a single subtree (Esc exits); expansion state is remembered per app; `UIWindowScene` and layout guides appear in the tree; indentation narrows for deep hierarchies so the deepest rows stay visible; font size, row height and indent guides are adjustable in Settings |
| Class blocking | Keep a list of blocked classes in Settings: the canvas skips matching nodes and their subtrees, the outline dims them and offers temporary reveal, re-block and block-this-class |
| SwiftUI | Shows the SwiftUI logical view tree under each hosting view: `Text` strings, controls such as `Button` / `Toggle` / `TextField`, modifier chains with arguments, and property values from the debug data (including `@State`); searchable by text. Enabled automatically when LumenServer is linked or injected. Logical nodes load progressively: hosting views that are slow to read the first time show the platform hierarchy first and are filled in in the background when the app is idle, so a large app like iOS Settings shows its first screen in 0.4 s instead of about 26 s |
| Inspector | A geometry card (parent and selection size, the distance to each parent edge, origin and window coordinates); attributes grouped by class, class chain (hover to see the framework each class lives in), owning view controller, ivar names and their owners, accessibilityIdentifier; enums such as `contentMode` and `textAlignment` show case names and can be changed from a menu; an Event Handling section lists a control's target-actions and `UIAction`s |
| Live attribute editing | Edit attributes in the inspector (drag to nudge numbers, color picker, text…), including colors and text whose value is nil; changes are logged, undoable and can be copied as an AI prompt. CLI: `lumen set` (enums accept case names such as `scaleAspectFit`) |
| App-defined attributes | Implement `@objc lumen_debugInfo()` on a view, layer or view controller to show your own state at the top of the inspector; entries with a setter are editable. Implement `+lumen_colorAliases` to label colors with design token names (see “Customizing the inspector” below) |
| Method invocation | List and call methods on a node, its layer or its view controller from the console, with inline prediction and Tab completion for selectors and one field per argument (colors open the color panel); returned objects can become the next target, list their methods or be revealed in the outline. CLI: `lumen methods` / `lumen invoke` |
| Gestures | A bar at the start of an outline row marks views with gesture recognizers; click it to open the gesture panel showing class, superclass, owning ivar, state, target/action and delegate, and enable or disable each recognizer. CLI: `lumen gestures` |
| Constraint diagnostics | Auto Layout ambiguity, intrinsic size, hugging / compression priorities and every constraint affecting the node. CLI: `lumen constraints` |
| Hit-test diagnostics | Explains which view a point hits, why others were skipped, the responder chain and candidate gestures. CLI: `lumen hittest` |
| Accessibility | Lists accessibility elements in VoiceOver order (label, value, hint, traits). CLI: `lumen a11y` |
| Appearance overrides | Switch dark mode, Dynamic Type size and right-to-left layout at runtime. CLI: `lumen appearance` |
| Audit | Finds small touch targets, truncated text, low contrast, occlusion, ambiguous layout, missing accessibility, masks that hide content entirely or leave only a sliver visible, and more, with causes and suggested fixes; export reports, tune thresholds, gate CI. CLI: `lumen audit` |
| Timeline | Every hierarchy change while connected is recorded; browse past snapshots and compare any two points in time |
| Design comparison | Overlay a reference image on the canvas (overlay / difference modes, adjustable opacity), align it to a window and get a match score |
| Copy & export | Copy class name, Lumen selector, node description, an AI-ready prompt; export node screenshots |
| Auto refresh | Refresh on an interval and whenever the app reports hierarchy changes |
| Selector queries | CSS-like syntax: class names, `#identifier`, `[text*="Login"]`, `:visible`, descendant / child combinators |
| `.lumen` archives | Save the hierarchy, all node details and textures into one `.lumen` file (File → Export Snapshot… or `lumen archive save`); open it offline in the app, or query, audit and diff it from the CLI |
| JSON snapshots & diff | `lumen snapshot save` writes a JSON hierarchy snapshot (`lumen.snapshot` format); diff it against another snapshot or the live UI (usable as a CI assertion) |
| Command line | `lumen` covers app discovery (this Mac, USB devices, LAN), hierarchy, queries, node details, screenshots, snapshots and archives, audits, live editing, source lookup and injection |
| AI assistants | `lumen mcp` runs as an MCP server with tools for hierarchy, queries, node details, screenshots, snapshot diffs, audits, hit-testing, constraints, accessibility, attribute editing, method calls, appearance overrides and source lookup |
| Target picker | Debuggable apps appear as cards grouped by platform and device, labelled USB / Wi-Fi / LAN / Simulator / This Mac, with a preview of the main window; when one process runs both a linked and an injected server, it is listed once |
| Background handling | Shows a notice with retry when the target app moves to the background or is suspended, and reloads the hierarchy and textures automatically once it is back |
| Disconnect snapshot | When the target app quits, crashes or drops off the network, the last hierarchy, the details already read and the textures stay on screen read-only and can be saved as a `.lumen` snapshot; Lumen switches back to live once the same app reappears |
| App Log | The App Log panel shows stdout / stderr and os_log for apps started with Launch for Debugging and for apps that link LumenServer; a virtualized list keeps up with heavy logging, with text search, source and level filters, and allow / deny rules |
| Language & appearance | The interface is available in Simplified Chinese, English and Traditional Chinese and switches in place; appearance follows the system or stays light or dark |
| One-step setup | `python3 /Applications/Lumen.app/Contents/Resources/lumen_setup.py` adds the server to the Debug configuration of an Xcode project (iOS Simulator / device, tvOS, macOS) without touching the Podfile or Package; `--remove` reverts it exactly |
| Zero-change injection | The Launch for Debugging window (⌘N) and `lumen launch` inject the server without touching your project into Mac apps (including Mac Catalyst), apps in the iOS Simulator, iOS app packages (run directly on Apple silicon Macs, optionally at an iPhone model's screen size) and apps on a USB-connected device; dropping an `.ipa` asks whether to run it on this Mac or on a device; apps whose signature blocks injection are re-signed as a copy; Electron / Chromium apps (including Mac App Store ones), iPad apps on Mac, apps blocked by Gatekeeper and apps that check for injection at launch are handled; system apps in the Simulator (Settings, Safari and so on) can be debugged too; the launch window has list and icon views with search; devices are signed with the Apple ID you signed in to in Xcode (a free account works) with a reminder before profiles expire, and recent launches restart in one click |
| Platforms | Debugged apps: iOS 15+, Mac Catalyst 15+, tvOS 15+, visionOS (UIKit) and macOS 12+ (AppKit). Client: macOS 14 or later |

## Download

Download the build for your Mac from [Releases](https://github.com/wangwanjie/Lumen/releases/latest):

| Chip | Download |
|---|---|
| Apple silicon (M series) | [Lumen_arm64.dmg](https://github.com/wangwanjie/Lumen/releases/latest/download/Lumen_arm64.dmg) |
| Intel | [Lumen_x86_64.dmg](https://github.com/wangwanjie/Lumen/releases/latest/download/Lumen_x86_64.dmg) |

Open the DMG and drag Lumen into Applications. Builds are notarized by Apple and update themselves (menu Lumen → Check for Updates…).

## Integrating the app you debug

The `LumenServer` collector belongs in Debug builds only. Pick one of four options; the one-step script is recommended when you would rather not change your dependencies.

### 1. One-step script (recommended, zero configuration)

Run this in the project directory (the one containing the `.xcworkspace` / `.xcodeproj`):

```bash
python3 /Applications/Lumen.app/Contents/Resources/lumen_setup.py
```

The script only touches the Debug configurations of your app targets; no Podfile, Package or code changes on your side:

- It appends a Run Script phase "[Lumen] Embed LumenInject" that copies the prebuilt collector for the current platform (iOS Simulator / device, tvOS, macOS) from Lumen.app into the app's Frameworks folder and re-signs it with the app's signing identity, so it runs on devices too. Release and other configurations copy nothing, so shipping builds contain no Lumen code;
- it sets `ENABLE_USER_SCRIPT_SANDBOXING = NO` in those configurations (the Run Script reads from Lumen.app);
- it inserts a few lines at the top of `didFinishLaunching` / `applicationDidFinishLaunching` / your SwiftUI `App.init` (Swift and Objective-C are detected automatically) that load the framework, which starts the collector.

Every change is marked and running the script again is safe. The changes are for local debugging only; do not commit them:

```bash
SETUP=/Applications/Lumen.app/Contents/Resources/lumen_setup.py
python3 $SETUP --remove                 # revert everything byte for byte (e.g. before switching branches)
python3 $SETUP --dry-run                # print the changes without writing
python3 $SETUP --target MyApp           # only this app target; --configs Debug,Beta picks configurations
```

With CocoaPods, `pod install` can do it for you: `python3 $SETUP --install-pod-hook` adds a committable `post_integrate` hook to the Podfile; after `export IntegrateLumen=true` on your machine every `pod install` integrates Lumen, and without it the changes are reverted. Teammates without Lumen.app are unaffected. Targets that already link `LumenServer` via SwiftPM or CocoaPods are skipped.

### 2. Swift Package Manager

In Xcode choose File → Add Package Dependencies, enter `https://github.com/wangwanjie/Lumen.git` and add `LumenServer` to your app target, or in `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/wangwanjie/Lumen.git", from: "0.3.0"),
],
targets: [
    .target(name: "MyApp", dependencies: [
        .product(name: "LumenServer", package: "Lumen"),
    ]),
]
```

Start it at launch:

```swift
#if DEBUG
import LumenServer
#endif

// e.g. in application(_:didFinishLaunchingWithOptions:) or applicationDidFinishLaunching:
#if DEBUG
LumenServer.start()
#endif
```

Objective-C projects call the entry class of the same name, `LumenServer` (no Swift bridging file needed):

```objc
#if DEBUG
@import LumenServer;   // with CocoaPods and modules disabled: #import <LumenServer/LumenServer-Swift.h>
#endif

// in application:didFinishLaunchingWithOptions: or applicationDidFinishLaunching:
#if DEBUG
[LumenServer start];   // LAN access: [LumenServer startAllowingNetworkConnections:YES]
#endif
```

SwiftPM links dependencies in every configuration, so Release builds still link LumenServer; `#if DEBUG` keeps it from starting. Use CocoaPods if Release builds must not contain the collector at all.

### 3. CocoaPods (Debug only)

```ruby
pod 'LumenServer', :podspec => 'https://raw.githubusercontent.com/wangwanjie/Lumen/v0.3.0/LumenServer.podspec', :configurations => ['Debug']
```

The code is the same as above (Swift: `import LumenServer` and `LumenServer.start()` inside `#if DEBUG`; Objective-C: `@import LumenServer;` then `[LumenServer start]`).

### 4. Zero-change injection: Launch for Debugging

Inject the server without modifying your project. The easiest way is the Launch for Debugging button in Lumen's toolbar (⌘N), or dropping an `.app` / `.ipa` onto the window or the Dock icon:

- **Mac apps**: pick one from the list or choose any `.app` or executable. For apps using the Hardened Runtime or library validation (most apps downloaded from the web), Lumen first lists what re-signing affects; after you confirm, it copies the app to `~/Library/Caches/lumen/resigned/`, re-signs the copy ad-hoc and launches the copy. The original app is left untouched. Mac Catalyst apps are launched through LaunchServices. These cases are handled automatically too:
  - **Electron / Chromium apps** (Google Chrome, balenaEtcher, Chromium apps from the Mac App Store and so on): the server starts only in the main process, leaving GPU, renderer and other helper processes alone; helpers that inherit the sandbox are re-signed along with the main app; the copy uses its own user data directory (`~/Library/Caches/lumen/resigned-data/`), so it never competes with the original app's single-instance lock or touches its sign-ins and cookies. Apps like Discord, which choose their own data directory and read the host's signing certificate, are handled too: their data-directory environment variable points to the same separate directory, and the copy is signed with the development certificate in your keychain (you get one by signing in with your Apple ID in Xcode; a free account works).
  - **iPad apps on Mac** and apps with non-Mach-O files in their code directories (such as Qt-packaged DB Browser for SQLite) re-sign and launch normally.
  - **Apps blocked by Gatekeeper** (quarantined, not notarized and not allowed with “Open Anyway”): Lumen launches a re-signed copy without the quarantine flag; the original stays as it is.
  - **Apps that check for injection at launch**: some apps enumerate loaded libraries at launch and quit when they find a foreign one. “Hide injection library” is on by default and removes the injection library from the dyld image list the app sees. It only defeats checks that enumerate image names or counts; use it only on apps you are entitled to debug.
- **Simulator**: pick a simulator and one of its apps (a simulator that is shut down is booted automatically), or install a simulator build `.app` first. User apps and system apps (Settings, Safari and so on) are listed in separate groups, and system apps can be debugged too; a green dot in the device menu marks booted simulators.

The Mac Apps and Simulator tabs switch between a list and an icon grid that shows each app's own icon; the search field filters by name or bundle ID, and the divider between the list and the description can be dragged. The context menu of a recent launch lists the original file and where it was installed (the re-signed copy, the local copy of an iOS package, the install directory in the simulator, the copy prepared for a device), with Show in Finder and Copy Path.
- **iOS app packages**: run an `.ipa` or an iOS device build `.app` directly on an Apple silicon Mac. Lumen unpacks it into the cache, retargets the binaries to Mac Catalyst and signs them ad-hoc. Launching the same package again reuses the copy. iPhone-only apps default to an iPad layout on Mac; pick a device under “Screen size” (or a custom size) to run at that size — handy for checking the UI at different sizes. For the most faithful iPhone layout, use a simulator or a device.
- **Devices**: pick a USB-connected iPhone or iPad and a package. Lumen embeds the injection library, re-signs the app with your Apple Development certificate and installs it. Certificates and provisioning profiles come from the Apple ID you signed in to in Xcode (a free account works; profiles last 7 days, Lumen reminds you a day before they expire and renews them in one click). Paid accounts can also import an App Store Connect API key in Settings › Signing. Lumen never handles your Apple ID password.

When something can't be launched, Lumen explains why and how to fix it (for example a FairPlay-encrypted package, an iOS package on an Intel Mac, or a device that doesn't trust the developer yet), and common fixes run in one click. Lumen connects automatically on success; Relaunch Current App (⌥⌘R) restarts the app the same way and restores the selected node.

The app's stdout / stderr and os_log (`Logger`, `os_log`) appear in the App Log panel at the bottom. Mac apps and iOS packages running on this Mac follow the process's os_log through `log stream`, so do simulators; on a device the injection library forwards os_log to the console (debug level excluded). Each entry takes one row (multi-line messages are folded); select it to see the full text below and press ⌘C to copy. Errors are red, faults purple, debug entries gray. Scrolling up pauses “follow latest” and scrolling back to the bottom resumes it, so heavy logging never pushes away what you are reading.

Apps that were not started by Launch for Debugging (for example an injected app opened by hand on the device, or an app that links LumenServer through CocoaPods / SPM) push their logs over the Lumen connection, so the panel works for them as well while you debug: an injected app captures print / NSLog from the moment the library loads (and still writes to the original console), while an integrated app starts capturing once it is connected; os_log is read from process launch (debug level excluded, iOS 15 / macOS 12 or later). The server keeps a recent history, and a reconnect only replays what was missed. Search from the toolbar; under Filter, choose sources and the minimum os_log level, and combine an allow list (show rows that match any rule) with a deny list (hide rows that match any rule). Rules match the whole line, the message, subsystem, category or process / library with contains, equals, begins with or a regular expression, ignore case, and apply to every app. Right-click a log entry to add the selected text or its subsystem to either list.

The command line works too:

```bash
LUMEN=/Applications/Lumen.app/Contents/Helpers/lumen

# macOS apps (executable or .app); add --resign to launch a re-signed copy when the signature blocks injection
$LUMEN launch --mac /path/to/MyApp.app
$LUMEN launch --mac /Applications/SomeApp.app --resign
$LUMEN launch --mac /Applications/SomeApp.app --resign --show-injection   # don't hide the injection library

# An app installed in the iOS Simulator (booted or a simulator UDID), or install a simulator build first
$LUMEN launch --simulator booted com.example.MyApp
$LUMEN launch --simulator <UDID> --install build/Debug-iphonesimulator/MyApp.app

# iOS app packages: run on this Mac (optionally at a device size), or re-sign and install on a device
$LUMEN launch --ios MyApp.ipa
$LUMEN launch --ios MyApp.ipa --iphone-model iphone-16-pro   # run at a device screen size
$LUMEN launch --ios MyApp.ipa --device-size 393x852x3        # custom size
$LUMEN launch --ios MyApp.ipa --keep-titlebar                # keep the window title bar (hidden by default)
$LUMEN launch --ios MyApp.ipa --allow-maximize               # allow maximizing the window (disabled by default)
$LUMEN launch --ios MyApp.ipa --device "My iPhone"

$LUMEN simulators      # simulators and their apps
$LUMEN simulators <UDID> --system   # user and system apps in separate groups
$LUMEN identities      # signing certificates and development provisioning profiles
```

The injection libraries ship inside `/Applications/Lumen.app/Contents/Helpers/` and `Contents/Resources/`, and `lumen` finds them automatically. SIP-protected system apps and FairPlay-encrypted App Store apps cannot be debugged this way. For your own apps, prefer one of the first three options.

Then open Lumen: it discovers apps on this Mac and connects automatically; switch between apps from the toolbar.

## Debugging on a device

### USB (recommended)

By default the collector listens on the device's loopback address only; USB connections arrive through usbmuxd, so no extra setup is needed:

1. Integrate LumenServer as above (the one-step script, or call `LumenServer.start()` in Debug builds), then install and run the app on your iPhone / iPad;
2. Connect it to this Mac with a cable and tap "Trust This Computer" on the device;
3. Open Lumen and pick the app from the toolbar's app list, grouped under "USB 设备：<device name>" (USB devices); the list refreshes as soon as a device is plugged in or out.

From the command line:

```bash
lumen devices                                   # USB devices and their UDIDs
lumen apps                                      # Lumen-enabled apps on this Mac and on USB devices
lumen --device <UDID> hierarchy --depth 4       # only apps on that device
```

### LAN (wireless)

The client discovers LAN apps through the Bonjour service `_lumen._tcp`, so the app must enable network connections, which also advertises that service:

1. Set the Boolean `LumenAllowsNetworkConnections = YES` in the host app's Info.plist (and keep calling `LumenServer.start()`), or call `LumenServer.start(allowsNetworkConnections: true)`;
2. Declare local network access in Info.plist:

```xml
<key>NSLocalNetworkUsageDescription</key>
<string>Used by Lumen UI debugging (Debug builds only)</string>
<key>NSBonjourServices</key>
<array>
    <string>_lumen._tcp</string>
</array>
```

3. Allow local network access on the device the first time the app runs;
4. Enable "发现局域网设备" (discover LAN devices) in Lumen's settings, or pass `--network` on the command line (e.g. `lumen apps --network`).

## Customizing the inspector

Implement `@objc lumen_debugInfo()` on a view, layer or view controller and the attributes it returns appear in a custom group at the top of the inspector — useful for business state such as order IDs, experiment groups or data sources. Attributes with a `retainedSetter` can be edited in the inspector, `enum` values are picked from a menu and `json` values expand as a tree. Compile it in Debug builds only:

```swift
#if DEBUG
extension WeatherBadgeView {
    @objc func lumen_debugInfo() -> [String: Any] {
        let setTemperature: @convention(block) (NSNumber) -> Void = { [weak self] value in
            self?.temperature = value.intValue
        }
        return [
            "properties": [
                ["section": "Weather", "title": "Temperature", "valueType": "number", "value": temperature,
                 "retainedSetter": setTemperature, "help": "Degrees Celsius"],
                ["section": "Weather", "title": "Symbol", "valueType": "enum", "value": symbol,
                 "allEnumCases": ["sun.max.fill", "cloud.fill", "snowflake"]],
            ],
        ]
    }
}
#endif
```

`valueType` is one of `string`, `number`, `bool`, `color`, `rect`, `size`, `point`, `insets`, `enum`, `shadow` or `json`; `help` becomes the tooltip.

When your design system names its colors, implement the class method `lumen_colorAliases` in an `NSObject` category and return “alias → color” or “group → alias → color”. Matching color attributes are labelled with the alias, such as “Brand / brandPrimary”, in the inspector, the command line and MCP output:

```swift
#if DEBUG
extension NSObject {
    @objc class func lumen_colorAliases() -> [String: Any] {
        return ["Brand": ["brandPrimary": UIColor.systemBlue], "textSecondary": UIColor.secondaryLabel]
    }
}
#endif
```

## AI assistants (MCP)

`lumen mcp` runs a [Model Context Protocol](https://modelcontextprotocol.io) server with tools to list and select apps, read the hierarchy, run selector queries, find text, read node details, take screenshots, diff snapshots, audit, hit-test, inspect constraints and accessibility, edit attributes, invoke methods, override appearance and locate source code.

Claude Code:

```bash
claude mcp add lumen -- /Applications/Lumen.app/Contents/Helpers/lumen mcp
```

Run `/mcp` in Claude Code to confirm the connection. `/mcp__lumen__lumen_ui_debug_workflow` followed by a description of the problem runs the built-in debugging workflow.

Codex (the CLI, the IDE extension and the ChatGPT desktop app share `~/.codex/config.toml`, so adding it once is enough):

```bash
codex mcp add lumen -- /Applications/Lumen.app/Contents/Helpers/lumen mcp
codex mcp list
```

Or edit the config file directly:

```toml
# ~/.codex/config.toml
[mcp_servers.lumen]
command = "/Applications/Lumen.app/Contents/Helpers/lumen"
args = ["mcp"]
```

ChatGPT: use the ChatGPT desktop app for macOS. In its settings, open "MCP servers" and add a STDIO server with the command `/Applications/Lumen.app/Contents/Helpers/lumen` and the argument `mcp`. If you already added Lumen in Codex, the app picks it up from the shared config. ChatGPT on the web only connects to publicly reachable remote MCP servers, so it cannot reach Lumen on your Mac. If the Lumen tools do not show up in regular chats in the desktop app, use them from Codex inside the desktop app.

Clients configured with `mcpServers` (Cursor and others):

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

Once connected, you can ask your assistant to work with Lumen directly, for example:

- "The Forgot Password button on the login screen doesn't respond. Use Lumen to check whether another view covers it and tell me which file to change."
- "Build the profile screen from design/profile.png, run it, then compare Lumen screenshots and the hierarchy against the design and fix spacing, font size and color differences."
- "Section headers on the Settings screen are hard to read in dark mode. Use Lumen to switch to dark mode, find the hard-coded colors and fix them."

More examples are on the [website](https://lumen.vanjay.cn/#ai-examples).

## Command line cheat sheet

```bash
sudo ln -sf /Applications/Lumen.app/Contents/Helpers/lumen /usr/local/bin/lumen
```

| Command | Purpose |
|---|---|
| `lumen apps` | List running apps that embed Lumen (this Mac and USB devices; LAN with `--network`) |
| `lumen devices` | List USB-connected devices (UDIDs) |
| `lumen hierarchy [--depth N] [--visible]` | Print the hierarchy, one node per line |
| `lumen query 'UIButton[text*="Login"]:visible'` | Find nodes by selector |
| `lumen node 12` | Node details: class chain and attributes grouped by class |
| `lumen screenshot 12 -o node.png` | Save a node screenshot |
| `lumen snapshot save before.json` | Save a JSON hierarchy snapshot (for diffing) |
| `lumen snapshot diff before.json --exit-code` | Diff against the live UI; exit code 1 when different |
| `lumen archive save current.lumen` | Save a full archive (hierarchy, node details, textures) that the app opens offline |
| `lumen audit --fail-on error` | Audit the UI; exit code 1 when error-level findings exist |
| `lumen set 12 UIView.alpha 0.5` | Change an attribute at runtime |
| `lumen launch --mac <App> [--resign]` | Launch with zero-change injection; add `--resign` to launch a re-signed copy of a third-party Hardened Runtime app |
| `lumen launch --ios <ipa> [--device <device>]` | Run an iOS app package on this Mac, or re-sign and install it on a device |
| `lumen simulators [UDID [--system]]` / `lumen identities` | List simulators and their apps (`--system` adds system apps) / signing certificates and provisioning profiles |
| `lumen mcp` | Run as an MCP server |

Global options: `--json` for stable JSON output, `--app <name|bundle id|pid|UDID>` to pick the target app, `--device <UDID|name>` to limit to one device, `--network` to also discover LAN apps, `--port N` to connect directly. The CLI's own messages are in Chinese; run `lumen help <command>` for details.

## Privacy & security

- Integrate the collector in Debug builds only: the one-step script copies it into Debug builds only, wrap the start call in `#if DEBUG` with SwiftPM, use `:configurations => ['Debug']` with CocoaPods.
- By default it listens on the loopback address (127.0.0.1) only and rejects connections from other hosts; this is how the Simulator, Mac apps and USB-connected devices connect.
- LAN access must be enabled explicitly: set `LumenAllowsNetworkConnections = YES` in Info.plist or call `LumenServer.start(allowsNetworkConnections: true)`; it then listens on all interfaces and advertises the Bonjour service `_lumen._tcp` (see "Debugging on a device").
- Copies that Launch for Debugging re-signs and installs on a device enable LAN connections so the device can also be found over Wi-Fi; anyone on the same network can connect to such a copy, so debug on a network you trust.
- Launch for Debugging only changes copies in the cache: re-signing and removing the quarantine flag happen on copies under `~/Library/Caches/lumen/`, never on the original app; copies of Chromium apps use their own data directory and never touch the original's sign-ins or cookies.
- Text in secure text fields (passwords) is always returned masked and never leaves the debugged app.
- Data flows only between Lumen, `lumen` and the debugged app on your machine; nothing is uploaded.

## License

Lumen.app, the `lumen` CLI and the LumenServer SDK are free to use and distributed as binaries only; you may integrate the SDK into Debug builds of your own apps, but may not decompile, modify or redistribute it on its own. See [LICENSE](LICENSE). © 2026 wangwanjie. All rights reserved.
