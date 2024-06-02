<p align="center">
  <img src="https://cdn-icons-png.flaticon.com/512/6295/6295417.png" width="100" />
</p>
<p align="center">
    <h1 align="center">NOTEMANAGER</h1>
</p>
<p align="center">
	<img src="https://img.shields.io/github/license/Orisiss/NoteManager?style=flat&color=0080ff" alt="license">
	<img src="https://img.shields.io/github/last-commit/Orisiss/NoteManager?style=flat&logo=git&logoColor=white&color=0080ff" alt="last-commit">
	<img src="https://img.shields.io/github/languages/top/Orisiss/NoteManager?style=flat&color=0080ff" alt="repo-top-language">
	<img src="https://img.shields.io/github/languages/count/Orisiss/NoteManager?style=flat&color=0080ff" alt="repo-language-count">
<p>
<p align="center">
		<em>Developed with the software and tools below.</em>
</p>
<p align="center">
	<img src="https://img.shields.io/badge/Swift-F05138.svg?style=flat&logo=Swift&logoColor=white" alt="Swift">
	<img src="https://img.shields.io/badge/HTML5-E34F26.svg?style=flat&logo=HTML5&logoColor=white" alt="HTML5">
	<img src="https://img.shields.io/badge/YAML-CB171E.svg?style=flat&logo=YAML&logoColor=white" alt="YAML">
	<img src="https://img.shields.io/badge/C-A8B9CC.svg?style=flat&logo=C&logoColor=black" alt="C">
	<img src="https://img.shields.io/badge/Kotlin-7F52FF.svg?style=flat&logo=Kotlin&logoColor=white" alt="Kotlin">
	<img src="https://img.shields.io/badge/Org-77AA99.svg?style=flat&logo=Org&logoColor=white" alt="Org">
	<br>
	<img src="https://img.shields.io/badge/CMake-064F8C.svg?style=flat&logo=CMake&logoColor=white" alt="CMake">
	<img src="https://img.shields.io/badge/Gradle-02303A.svg?style=flat&logo=Gradle&logoColor=white" alt="Gradle">
	<img src="https://img.shields.io/badge/Dart-0175C2.svg?style=flat&logo=Dart&logoColor=white" alt="Dart">
	<img src="https://img.shields.io/badge/JSON-000000.svg?style=flat&logo=JSON&logoColor=white" alt="JSON">
	<img src="https://img.shields.io/badge/JetBrains-000000.svg?style=flat&logo=JetBrains&logoColor=white" alt="JetBrains">
</p>
<hr>

## 🔗 Quick Links

> - [📂 Repository Structure](#-repository-structure)
> - [🧩 Modules](#-modules)
> - [🚀 Getting Started](#-getting-started)
>   - [⚙️ Installation](#️-installation)
>   - [🤖 Running NoteManager](#-running-NoteManager)
>   - [🧪 Tests](#-tests)
> - [🛠 Project Roadmap](#-project-roadmap)
> - [🤝 Contributing](#-contributing)
> - [📄 License](#-license)
> - [👏 Acknowledgments](#-acknowledgments)

---

## 📂 Repository Structure

```sh
└── NoteManager/
    ├── README.md
    ├── analysis_options.yaml
    ├── android
    │   ├── .gitignore
    │   ├── app
    │   │   ├── build.gradle
    │   │   └── src
    │   │       ├── debug
    │   │       │   └── AndroidManifest.xml
    │   │       ├── main
    │   │       │   ├── AndroidManifest.xml
    │   │       │   ├── kotlin
    │   │       │   └── res
    │   │       └── profile
    │   │           └── AndroidManifest.xml
    │   ├── build.gradle
    │   ├── gradle
    │   │   └── wrapper
    │   │       └── gradle-wrapper.properties
    │   ├── gradle.properties
    │   └── settings.gradle
    ├── ios
    │   ├── .gitignore
    │   ├── Flutter
    │   │   ├── AppFrameworkInfo.plist
    │   │   ├── Debug.xcconfig
    │   │   └── Release.xcconfig
    │   ├── Podfile
    │   ├── Podfile.lock
    │   ├── Runner
    │   │   ├── AppDelegate.swift
    │   │   ├── Assets.xcassets
    │   │   │   ├── AppIcon.appiconset
    │   │   │   │   ├── Contents.json
    │   │   │   │   ├── Icon-App-1024x1024@1x.png
    │   │   │   │   ├── Icon-App-20x20@1x.png
    │   │   │   │   ├── Icon-App-20x20@2x.png
    │   │   │   │   ├── Icon-App-20x20@3x.png
    │   │   │   │   ├── Icon-App-29x29@1x.png
    │   │   │   │   ├── Icon-App-29x29@2x.png
    │   │   │   │   ├── Icon-App-29x29@3x.png
    │   │   │   │   ├── Icon-App-40x40@1x.png
    │   │   │   │   ├── Icon-App-40x40@2x.png
    │   │   │   │   ├── Icon-App-40x40@3x.png
    │   │   │   │   ├── Icon-App-60x60@2x.png
    │   │   │   │   ├── Icon-App-60x60@3x.png
    │   │   │   │   ├── Icon-App-76x76@1x.png
    │   │   │   │   ├── Icon-App-76x76@2x.png
    │   │   │   │   └── Icon-App-83.5x83.5@2x.png
    │   │   │   └── LaunchImage.imageset
    │   │   │       ├── Contents.json
    │   │   │       ├── LaunchImage.png
    │   │   │       ├── LaunchImage@2x.png
    │   │   │       ├── LaunchImage@3x.png
    │   │   │       └── README.md
    │   │   ├── Base.lproj
    │   │   │   ├── LaunchScreen.storyboard
    │   │   │   └── Main.storyboard
    │   │   ├── Info.plist
    │   │   └── Runner-Bridging-Header.h
    │   ├── Runner.xcodeproj
    │   │   ├── project.pbxproj
    │   │   ├── project.xcworkspace
    │   │   │   ├── contents.xcworkspacedata
    │   │   │   └── xcshareddata
    │   │   │       ├── IDEWorkspaceChecks.plist
    │   │   │       └── WorkspaceSettings.xcsettings
    │   │   └── xcshareddata
    │   │       └── xcschemes
    │   │           └── Runner.xcscheme
    │   ├── Runner.xcworkspace
    │   │   ├── contents.xcworkspacedata
    │   │   └── xcshareddata
    │   │       ├── IDEWorkspaceChecks.plist
    │   │       └── WorkspaceSettings.xcsettings
    │   └── RunnerTests
    │       └── RunnerTests.swift
    ├── lib
    │   ├── assets
    │   │   └── avatar.png
    │   ├── main.dart
    │   ├── models
    │   │   ├── devoir.dart
    │   │   ├── evaluation.dart
    │   │   ├── matiere.dart
    │   │   ├── professeur.dart
    │   │   ├── recompense.dart
    │   │   └── recompense_evaluation.dart
    │   ├── pages
    │   │   ├── evaluation.dart
    │   │   ├── profil.dart
    │   │   ├── settings.dart
    │   │   └── todo.dart
    │   ├── services
    │   │   └── sqlite_service.dart
    │   └── widgets
    │       └── tabbar.dart
    ├── linux
    │   ├── .gitignore
    │   ├── CMakeLists.txt
    │   ├── flutter
    │   │   ├── CMakeLists.txt
    │   │   ├── generated_plugin_registrant.cc
    │   │   ├── generated_plugin_registrant.h
    │   │   └── generated_plugins.cmake
    │   ├── main.cc
    │   ├── my_application.cc
    │   └── my_application.h
    ├── macos
    │   ├── .gitignore
    │   ├── Flutter
    │   │   ├── Flutter-Debug.xcconfig
    │   │   ├── Flutter-Release.xcconfig
    │   │   └── GeneratedPluginRegistrant.swift
    │   ├── Podfile
    │   ├── Podfile.lock
    │   ├── Runner
    │   │   ├── AppDelegate.swift
    │   │   ├── Assets.xcassets
    │   │   │   └── AppIcon.appiconset
    │   │   │       ├── Contents.json
    │   │   │       ├── app_icon_1024.png
    │   │   │       ├── app_icon_128.png
    │   │   │       ├── app_icon_16.png
    │   │   │       ├── app_icon_256.png
    │   │   │       ├── app_icon_32.png
    │   │   │       ├── app_icon_512.png
    │   │   │       └── app_icon_64.png
    │   │   ├── Base.lproj
    │   │   │   └── MainMenu.xib
    │   │   ├── Configs
    │   │   │   ├── AppInfo.xcconfig
    │   │   │   ├── Debug.xcconfig
    │   │   │   ├── Release.xcconfig
    │   │   │   └── Warnings.xcconfig
    │   │   ├── DebugProfile.entitlements
    │   │   ├── Info.plist
    │   │   ├── MainFlutterWindow.swift
    │   │   └── Release.entitlements
    │   ├── Runner.xcodeproj
    │   │   ├── project.pbxproj
    │   │   ├── project.xcworkspace
    │   │   │   └── xcshareddata
    │   │   │       └── IDEWorkspaceChecks.plist
    │   │   └── xcshareddata
    │   │       └── xcschemes
    │   │           └── Runner.xcscheme
    │   ├── Runner.xcworkspace
    │   │   ├── contents.xcworkspacedata
    │   │   └── xcshareddata
    │   │       └── IDEWorkspaceChecks.plist
    │   └── RunnerTests
    │       └── RunnerTests.swift
    ├── note_manager.db
    ├── pubspec.lock
    ├── pubspec.yaml
    ├── test
    │   └── widget_test.dart
    ├── web
    │   ├── favicon.png
    │   ├── icons
    │   │   ├── Icon-192.png
    │   │   ├── Icon-512.png
    │   │   ├── Icon-maskable-192.png
    │   │   └── Icon-maskable-512.png
    │   ├── index.html
    │   └── manifest.json
    └── windows
        ├── .gitignore
        ├── CMakeLists.txt
        ├── flutter
        │   ├── CMakeLists.txt
        │   ├── generated_plugin_registrant.cc
        │   ├── generated_plugin_registrant.h
        │   └── generated_plugins.cmake
        └── runner
            ├── CMakeLists.txt
            ├── Runner.rc
            ├── flutter_window.cpp
            ├── flutter_window.h
            ├── main.cpp
            ├── resource.h
            ├── resources
            │   └── app_icon.ico
            ├── runner.exe.manifest
            ├── utils.cpp
            ├── utils.h
            ├── win32_window.cpp
            └── win32_window.h
```

---

## 🧩 Modules

<details closed><summary>.</summary>

| File                                                                                              | Summary                                           |
| ---                                                                                               | ---                                               |
| [pubspec.yaml](https://github.com/Orisiss/NoteManager/blob/master/pubspec.yaml)                   | HTTP error 429 for prompt `pubspec.yaml`          |
| [analysis_options.yaml](https://github.com/Orisiss/NoteManager/blob/master/analysis_options.yaml) | HTTP error 429 for prompt `analysis_options.yaml` |

</details>

<details closed><summary>android</summary>

| File                                                                                          | Summary                                             |
| ---                                                                                           | ---                                                 |
| [settings.gradle](https://github.com/Orisiss/NoteManager/blob/master/android/settings.gradle) | HTTP error 429 for prompt `android/settings.gradle` |
| [build.gradle](https://github.com/Orisiss/NoteManager/blob/master/android/build.gradle)       | HTTP error 429 for prompt `android/build.gradle`    |

</details>

<details closed><summary>android.app</summary>

| File                                                                                        | Summary                                              |
| ---                                                                                         | ---                                                  |
| [build.gradle](https://github.com/Orisiss/NoteManager/blob/master/android/app/build.gradle) | HTTP error 429 for prompt `android/app/build.gradle` |

</details>

<details closed><summary>android.app.src.main.kotlin.com.example.note_manager</summary>

| File                                                                                                                                       | Summary                                                                                          |
| ---                                                                                                                                        | ---                                                                                              |
| [MainActivity.kt](https://github.com/Orisiss/NoteManager/blob/master/android/app/src/main/kotlin/com/example/note_manager/MainActivity.kt) | HTTP error 429 for prompt `android/app/src/main/kotlin/com/example/note_manager/MainActivity.kt` |

</details>

<details closed><summary>macos</summary>

| File                                                                                  | Summary                                        |
| ---                                                                                   | ---                                            |
| [Podfile.lock](https://github.com/Orisiss/NoteManager/blob/master/macos/Podfile.lock) | HTTP error 429 for prompt `macos/Podfile.lock` |
| [Podfile](https://github.com/Orisiss/NoteManager/blob/master/macos/Podfile)           | HTTP error 429 for prompt `macos/Podfile`      |

</details>

<details closed><summary>macos.Runner.xcworkspace</summary>

| File                                                                                                                             | Summary                                                                       |
| ---                                                                                                                              | ---                                                                           |
| [contents.xcworkspacedata](https://github.com/Orisiss/NoteManager/blob/master/macos/Runner.xcworkspace/contents.xcworkspacedata) | HTTP error 429 for prompt `macos/Runner.xcworkspace/contents.xcworkspacedata` |

</details>

<details closed><summary>macos.Runner.xcworkspace.xcshareddata</summary>

| File                                                                                                                                          | Summary                                                                                    |
| ---                                                                                                                                           | ---                                                                                        |
| [IDEWorkspaceChecks.plist](https://github.com/Orisiss/NoteManager/blob/master/macos/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist) | HTTP error 429 for prompt `macos/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist` |

</details>

<details closed><summary>macos.Flutter</summary>

| File                                                                                                                                | Summary                                                                   |
| ---                                                                                                                                 | ---                                                                       |
| [Flutter-Debug.xcconfig](https://github.com/Orisiss/NoteManager/blob/master/macos/Flutter/Flutter-Debug.xcconfig)                   | HTTP error 429 for prompt `macos/Flutter/Flutter-Debug.xcconfig`          |
| [GeneratedPluginRegistrant.swift](https://github.com/Orisiss/NoteManager/blob/master/macos/Flutter/GeneratedPluginRegistrant.swift) | HTTP error 429 for prompt `macos/Flutter/GeneratedPluginRegistrant.swift` |
| [Flutter-Release.xcconfig](https://github.com/Orisiss/NoteManager/blob/master/macos/Flutter/Flutter-Release.xcconfig)               | HTTP error 429 for prompt `macos/Flutter/Flutter-Release.xcconfig`        |

</details>

<details closed><summary>macos.Runner</summary>

| File                                                                                                                   | Summary                                                            |
| ---                                                                                                                    | ---                                                                |
| [Info.plist](https://github.com/Orisiss/NoteManager/blob/master/macos/Runner/Info.plist)                               | HTTP error 429 for prompt `macos/Runner/Info.plist`                |
| [Release.entitlements](https://github.com/Orisiss/NoteManager/blob/master/macos/Runner/Release.entitlements)           | HTTP error 429 for prompt `macos/Runner/Release.entitlements`      |
| [MainFlutterWindow.swift](https://github.com/Orisiss/NoteManager/blob/master/macos/Runner/MainFlutterWindow.swift)     | HTTP error 429 for prompt `macos/Runner/MainFlutterWindow.swift`   |
| [AppDelegate.swift](https://github.com/Orisiss/NoteManager/blob/master/macos/Runner/AppDelegate.swift)                 | HTTP error 429 for prompt `macos/Runner/AppDelegate.swift`         |
| [DebugProfile.entitlements](https://github.com/Orisiss/NoteManager/blob/master/macos/Runner/DebugProfile.entitlements) | HTTP error 429 for prompt `macos/Runner/DebugProfile.entitlements` |

</details>

<details closed><summary>macos.Runner.Configs</summary>

| File                                                                                                           | Summary                                                            |
| ---                                                                                                            | ---                                                                |
| [Release.xcconfig](https://github.com/Orisiss/NoteManager/blob/master/macos/Runner/Configs/Release.xcconfig)   | HTTP error 429 for prompt `macos/Runner/Configs/Release.xcconfig`  |
| [Debug.xcconfig](https://github.com/Orisiss/NoteManager/blob/master/macos/Runner/Configs/Debug.xcconfig)       | HTTP error 429 for prompt `macos/Runner/Configs/Debug.xcconfig`    |
| [AppInfo.xcconfig](https://github.com/Orisiss/NoteManager/blob/master/macos/Runner/Configs/AppInfo.xcconfig)   | HTTP error 429 for prompt `macos/Runner/Configs/AppInfo.xcconfig`  |
| [Warnings.xcconfig](https://github.com/Orisiss/NoteManager/blob/master/macos/Runner/Configs/Warnings.xcconfig) | HTTP error 429 for prompt `macos/Runner/Configs/Warnings.xcconfig` |

</details>

<details closed><summary>macos.Runner.Base.lproj</summary>

| File                                                                                                    | Summary                                                          |
| ---                                                                                                     | ---                                                              |
| [MainMenu.xib](https://github.com/Orisiss/NoteManager/blob/master/macos/Runner/Base.lproj/MainMenu.xib) | HTTP error 429 for prompt `macos/Runner/Base.lproj/MainMenu.xib` |

</details>

<details closed><summary>macos.Runner.Assets.xcassets.AppIcon.appiconset</summary>

| File                                                                                                                              | Summary                                                                                   |
| ---                                                                                                                               | ---                                                                                       |
| [Contents.json](https://github.com/Orisiss/NoteManager/blob/master/macos/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json) | HTTP error 429 for prompt `macos/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json` |

</details>

<details closed><summary>macos.RunnerTests</summary>

| File                                                                                                        | Summary                                                         |
| ---                                                                                                         | ---                                                             |
| [RunnerTests.swift](https://github.com/Orisiss/NoteManager/blob/master/macos/RunnerTests/RunnerTests.swift) | HTTP error 429 for prompt `macos/RunnerTests/RunnerTests.swift` |

</details>

<details closed><summary>macos.Runner.xcodeproj</summary>

| File                                                                                                         | Summary                                                            |
| ---                                                                                                          | ---                                                                |
| [project.pbxproj](https://github.com/Orisiss/NoteManager/blob/master/macos/Runner.xcodeproj/project.pbxproj) | HTTP error 429 for prompt `macos/Runner.xcodeproj/project.pbxproj` |

</details>

<details closed><summary>macos.Runner.xcodeproj.project.xcworkspace.xcshareddata</summary>

| File                                                                                                                                                            | Summary                                                                                                      |
| ---                                                                                                                                                             | ---                                                                                                          |
| [IDEWorkspaceChecks.plist](https://github.com/Orisiss/NoteManager/blob/master/macos/Runner.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist) | HTTP error 429 for prompt `macos/Runner.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist` |

</details>

<details closed><summary>macos.Runner.xcodeproj.xcshareddata.xcschemes</summary>

| File                                                                                                                                | Summary                                                                                   |
| ---                                                                                                                                 | ---                                                                                       |
| [Runner.xcscheme](https://github.com/Orisiss/NoteManager/blob/master/macos/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme) | HTTP error 429 for prompt `macos/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme` |

</details>

<details closed><summary>web</summary>

| File                                                                                  | Summary                                       |
| ---                                                                                   | ---                                           |
| [index.html](https://github.com/Orisiss/NoteManager/blob/master/web/index.html)       | HTTP error 429 for prompt `web/index.html`    |
| [manifest.json](https://github.com/Orisiss/NoteManager/blob/master/web/manifest.json) | HTTP error 429 for prompt `web/manifest.json` |

</details>

<details closed><summary>windows</summary>

| File                                                                                        | Summary                                            |
| ---                                                                                         | ---                                                |
| [CMakeLists.txt](https://github.com/Orisiss/NoteManager/blob/master/windows/CMakeLists.txt) | HTTP error 429 for prompt `windows/CMakeLists.txt` |

</details>

<details closed><summary>windows.flutter</summary>

| File                                                                                                                                | Summary                                                                    |
| ---                                                                                                                                 | ---                                                                        |
| [generated_plugins.cmake](https://github.com/Orisiss/NoteManager/blob/master/windows/flutter/generated_plugins.cmake)               | HTTP error 429 for prompt `windows/flutter/generated_plugins.cmake`        |
| [CMakeLists.txt](https://github.com/Orisiss/NoteManager/blob/master/windows/flutter/CMakeLists.txt)                                 | HTTP error 429 for prompt `windows/flutter/CMakeLists.txt`                 |
| [generated_plugin_registrant.h](https://github.com/Orisiss/NoteManager/blob/master/windows/flutter/generated_plugin_registrant.h)   | HTTP error 429 for prompt `windows/flutter/generated_plugin_registrant.h`  |
| [generated_plugin_registrant.cc](https://github.com/Orisiss/NoteManager/blob/master/windows/flutter/generated_plugin_registrant.cc) | HTTP error 429 for prompt `windows/flutter/generated_plugin_registrant.cc` |

</details>

<details closed><summary>windows.runner</summary>

| File                                                                                                         | Summary                                                        |
| ---                                                                                                          | ---                                                            |
| [flutter_window.cpp](https://github.com/Orisiss/NoteManager/blob/master/windows/runner/flutter_window.cpp)   | HTTP error 429 for prompt `windows/runner/flutter_window.cpp`  |
| [runner.exe.manifest](https://github.com/Orisiss/NoteManager/blob/master/windows/runner/runner.exe.manifest) | HTTP error 429 for prompt `windows/runner/runner.exe.manifest` |
| [utils.h](https://github.com/Orisiss/NoteManager/blob/master/windows/runner/utils.h)                         | HTTP error 429 for prompt `windows/runner/utils.h`             |
| [win32_window.cpp](https://github.com/Orisiss/NoteManager/blob/master/windows/runner/win32_window.cpp)       | HTTP error 429 for prompt `windows/runner/win32_window.cpp`    |
| [utils.cpp](https://github.com/Orisiss/NoteManager/blob/master/windows/runner/utils.cpp)                     | HTTP error 429 for prompt `windows/runner/utils.cpp`           |
| [main.cpp](https://github.com/Orisiss/NoteManager/blob/master/windows/runner/main.cpp)                       | HTTP error 429 for prompt `windows/runner/main.cpp`            |
| [Runner.rc](https://github.com/Orisiss/NoteManager/blob/master/windows/runner/Runner.rc)                     | HTTP error 429 for prompt `windows/runner/Runner.rc`           |
| [resource.h](https://github.com/Orisiss/NoteManager/blob/master/windows/runner/resource.h)                   | HTTP error 429 for prompt `windows/runner/resource.h`          |
| [flutter_window.h](https://github.com/Orisiss/NoteManager/blob/master/windows/runner/flutter_window.h)       | HTTP error 429 for prompt `windows/runner/flutter_window.h`    |
| [CMakeLists.txt](https://github.com/Orisiss/NoteManager/blob/master/windows/runner/CMakeLists.txt)           | HTTP error 429 for prompt `windows/runner/CMakeLists.txt`      |
| [win32_window.h](https://github.com/Orisiss/NoteManager/blob/master/windows/runner/win32_window.h)           | HTTP error 429 for prompt `windows/runner/win32_window.h`      |

</details>

<details closed><summary>linux</summary>

| File                                                                                            | Summary                                             |
| ---                                                                                             | ---                                                 |
| [main.cc](https://github.com/Orisiss/NoteManager/blob/master/linux/main.cc)                     | HTTP error 429 for prompt `linux/main.cc`           |
| [my_application.cc](https://github.com/Orisiss/NoteManager/blob/master/linux/my_application.cc) | HTTP error 429 for prompt `linux/my_application.cc` |
| [my_application.h](https://github.com/Orisiss/NoteManager/blob/master/linux/my_application.h)   | HTTP error 429 for prompt `linux/my_application.h`  |
| [CMakeLists.txt](https://github.com/Orisiss/NoteManager/blob/master/linux/CMakeLists.txt)       | HTTP error 429 for prompt `linux/CMakeLists.txt`    |

</details>

<details closed><summary>linux.flutter</summary>

| File                                                                                                                              | Summary                                                                  |
| ---                                                                                                                               | ---                                                                      |
| [generated_plugins.cmake](https://github.com/Orisiss/NoteManager/blob/master/linux/flutter/generated_plugins.cmake)               | HTTP error 429 for prompt `linux/flutter/generated_plugins.cmake`        |
| [CMakeLists.txt](https://github.com/Orisiss/NoteManager/blob/master/linux/flutter/CMakeLists.txt)                                 | HTTP error 429 for prompt `linux/flutter/CMakeLists.txt`                 |
| [generated_plugin_registrant.h](https://github.com/Orisiss/NoteManager/blob/master/linux/flutter/generated_plugin_registrant.h)   | HTTP error 429 for prompt `linux/flutter/generated_plugin_registrant.h`  |
| [generated_plugin_registrant.cc](https://github.com/Orisiss/NoteManager/blob/master/linux/flutter/generated_plugin_registrant.cc) | HTTP error 429 for prompt `linux/flutter/generated_plugin_registrant.cc` |

</details>

<details closed><summary>test</summary>

| File                                                                                         | Summary                                           |
| ---                                                                                          | ---                                               |
| [widget_test.dart](https://github.com/Orisiss/NoteManager/blob/master/test/widget_test.dart) | HTTP error 429 for prompt `test/widget_test.dart` |

</details>

<details closed><summary>lib</summary>

| File                                                                          | Summary                                   |
| ---                                                                           | ---                                       |
| [main.dart](https://github.com/Orisiss/NoteManager/blob/master/lib/main.dart) | HTTP error 429 for prompt `lib/main.dart` |

</details>

<details closed><summary>lib.services</summary>

| File                                                                                                       | Summary                                                      |
| ---                                                                                                        | ---                                                          |
| [sqlite_service.dart](https://github.com/Orisiss/NoteManager/blob/master/lib/services/sqlite_service.dart) | HTTP error 429 for prompt `lib/services/sqlite_service.dart` |

</details>

<details closed><summary>lib.models</summary>

| File                                                                                                                   | Summary                                                           |
| ---                                                                                                                    | ---                                                               |
| [recompense_evaluation.dart](https://github.com/Orisiss/NoteManager/blob/master/lib/models/recompense_evaluation.dart) | HTTP error 429 for prompt `lib/models/recompense_evaluation.dart` |
| [recompense.dart](https://github.com/Orisiss/NoteManager/blob/master/lib/models/recompense.dart)                       | HTTP error 429 for prompt `lib/models/recompense.dart`            |
| [devoir.dart](https://github.com/Orisiss/NoteManager/blob/master/lib/models/devoir.dart)                               | HTTP error 429 for prompt `lib/models/devoir.dart`                |
| [matiere.dart](https://github.com/Orisiss/NoteManager/blob/master/lib/models/matiere.dart)                             | HTTP error 429 for prompt `lib/models/matiere.dart`               |
| [professeur.dart](https://github.com/Orisiss/NoteManager/blob/master/lib/models/professeur.dart)                       | HTTP error 429 for prompt `lib/models/professeur.dart`            |
| [evaluation.dart](https://github.com/Orisiss/NoteManager/blob/master/lib/models/evaluation.dart)                       | HTTP error 429 for prompt `lib/models/evaluation.dart`            |

</details>

<details closed><summary>lib.pages</summary>

| File                                                                                            | Summary                                               |
| ---                                                                                             | ---                                                   |
| [todo.dart](https://github.com/Orisiss/NoteManager/blob/master/lib/pages/todo.dart)             | HTTP error 429 for prompt `lib/pages/todo.dart`       |
| [profil.dart](https://github.com/Orisiss/NoteManager/blob/master/lib/pages/profil.dart)         | HTTP error 429 for prompt `lib/pages/profil.dart`     |
| [settings.dart](https://github.com/Orisiss/NoteManager/blob/master/lib/pages/settings.dart)     | HTTP error 429 for prompt `lib/pages/settings.dart`   |
| [evaluation.dart](https://github.com/Orisiss/NoteManager/blob/master/lib/pages/evaluation.dart) | HTTP error 429 for prompt `lib/pages/evaluation.dart` |

</details>

<details closed><summary>lib.widgets</summary>

| File                                                                                      | Summary                                             |
| ---                                                                                       | ---                                                 |
| [tabbar.dart](https://github.com/Orisiss/NoteManager/blob/master/lib/widgets/tabbar.dart) | HTTP error 429 for prompt `lib/widgets/tabbar.dart` |

</details>

<details closed><summary>ios</summary>

| File                                                                                | Summary                                      |
| ---                                                                                 | ---                                          |
| [Podfile.lock](https://github.com/Orisiss/NoteManager/blob/master/ios/Podfile.lock) | HTTP error 429 for prompt `ios/Podfile.lock` |
| [Podfile](https://github.com/Orisiss/NoteManager/blob/master/ios/Podfile)           | HTTP error 429 for prompt `ios/Podfile`      |

</details>

<details closed><summary>ios.Runner.xcworkspace</summary>

| File                                                                                                                           | Summary                                                                     |
| ---                                                                                                                            | ---                                                                         |
| [contents.xcworkspacedata](https://github.com/Orisiss/NoteManager/blob/master/ios/Runner.xcworkspace/contents.xcworkspacedata) | HTTP error 429 for prompt `ios/Runner.xcworkspace/contents.xcworkspacedata` |

</details>

<details closed><summary>ios.Runner.xcworkspace.xcshareddata</summary>

| File                                                                                                                                                | Summary                                                                                      |
| ---                                                                                                                                                 | ---                                                                                          |
| [IDEWorkspaceChecks.plist](https://github.com/Orisiss/NoteManager/blob/master/ios/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist)         | HTTP error 429 for prompt `ios/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist`     |
| [WorkspaceSettings.xcsettings](https://github.com/Orisiss/NoteManager/blob/master/ios/Runner.xcworkspace/xcshareddata/WorkspaceSettings.xcsettings) | HTTP error 429 for prompt `ios/Runner.xcworkspace/xcshareddata/WorkspaceSettings.xcsettings` |

</details>

<details closed><summary>ios.Flutter</summary>

| File                                                                                                            | Summary                                                        |
| ---                                                                                                             | ---                                                            |
| [Release.xcconfig](https://github.com/Orisiss/NoteManager/blob/master/ios/Flutter/Release.xcconfig)             | HTTP error 429 for prompt `ios/Flutter/Release.xcconfig`       |
| [AppFrameworkInfo.plist](https://github.com/Orisiss/NoteManager/blob/master/ios/Flutter/AppFrameworkInfo.plist) | HTTP error 429 for prompt `ios/Flutter/AppFrameworkInfo.plist` |
| [Debug.xcconfig](https://github.com/Orisiss/NoteManager/blob/master/ios/Flutter/Debug.xcconfig)                 | HTTP error 429 for prompt `ios/Flutter/Debug.xcconfig`         |

</details>

<details closed><summary>ios.Runner</summary>

| File                                                                                                               | Summary                                                         |
| ---                                                                                                                | ---                                                             |
| [Info.plist](https://github.com/Orisiss/NoteManager/blob/master/ios/Runner/Info.plist)                             | HTTP error 429 for prompt `ios/Runner/Info.plist`               |
| [Runner-Bridging-Header.h](https://github.com/Orisiss/NoteManager/blob/master/ios/Runner/Runner-Bridging-Header.h) | HTTP error 429 for prompt `ios/Runner/Runner-Bridging-Header.h` |
| [AppDelegate.swift](https://github.com/Orisiss/NoteManager/blob/master/ios/Runner/AppDelegate.swift)               | HTTP error 429 for prompt `ios/Runner/AppDelegate.swift`        |

</details>

<details closed><summary>ios.Runner.Base.lproj</summary>

| File                                                                                                                        | Summary                                                                   |
| ---                                                                                                                         | ---                                                                       |
| [Main.storyboard](https://github.com/Orisiss/NoteManager/blob/master/ios/Runner/Base.lproj/Main.storyboard)                 | HTTP error 429 for prompt `ios/Runner/Base.lproj/Main.storyboard`         |
| [LaunchScreen.storyboard](https://github.com/Orisiss/NoteManager/blob/master/ios/Runner/Base.lproj/LaunchScreen.storyboard) | HTTP error 429 for prompt `ios/Runner/Base.lproj/LaunchScreen.storyboard` |

</details>

<details closed><summary>ios.Runner.Assets.xcassets.AppIcon.appiconset</summary>

| File                                                                                                                            | Summary                                                                                 |
| ---                                                                                                                             | ---                                                                                     |
| [Contents.json](https://github.com/Orisiss/NoteManager/blob/master/ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json) | HTTP error 429 for prompt `ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json` |

</details>

<details closed><summary>ios.Runner.Assets.xcassets.LaunchImage.imageset</summary>

| File                                                                                                                              | Summary                                                                                   |
| ---                                                                                                                               | ---                                                                                       |
| [Contents.json](https://github.com/Orisiss/NoteManager/blob/master/ios/Runner/Assets.xcassets/LaunchImage.imageset/Contents.json) | HTTP error 429 for prompt `ios/Runner/Assets.xcassets/LaunchImage.imageset/Contents.json` |

</details>

<details closed><summary>ios.RunnerTests</summary>

| File                                                                                                      | Summary                                                       |
| ---                                                                                                       | ---                                                           |
| [RunnerTests.swift](https://github.com/Orisiss/NoteManager/blob/master/ios/RunnerTests/RunnerTests.swift) | HTTP error 429 for prompt `ios/RunnerTests/RunnerTests.swift` |

</details>

<details closed><summary>ios.Runner.xcodeproj</summary>

| File                                                                                                       | Summary                                                          |
| ---                                                                                                        | ---                                                              |
| [project.pbxproj](https://github.com/Orisiss/NoteManager/blob/master/ios/Runner.xcodeproj/project.pbxproj) | HTTP error 429 for prompt `ios/Runner.xcodeproj/project.pbxproj` |

</details>

<details closed><summary>ios.Runner.xcodeproj.project.xcworkspace</summary>

| File                                                                                                                                             | Summary                                                                                       |
| ---                                                                                                                                              | ---                                                                                           |
| [contents.xcworkspacedata](https://github.com/Orisiss/NoteManager/blob/master/ios/Runner.xcodeproj/project.xcworkspace/contents.xcworkspacedata) | HTTP error 429 for prompt `ios/Runner.xcodeproj/project.xcworkspace/contents.xcworkspacedata` |

</details>

<details closed><summary>ios.Runner.xcodeproj.project.xcworkspace.xcshareddata</summary>

| File                                                                                                                                                                  | Summary                                                                                                        |
| ---                                                                                                                                                                   | ---                                                                                                            |
| [IDEWorkspaceChecks.plist](https://github.com/Orisiss/NoteManager/blob/master/ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist)         | HTTP error 429 for prompt `ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist`     |
| [WorkspaceSettings.xcsettings](https://github.com/Orisiss/NoteManager/blob/master/ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/WorkspaceSettings.xcsettings) | HTTP error 429 for prompt `ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/WorkspaceSettings.xcsettings` |

</details>

<details closed><summary>ios.Runner.xcodeproj.xcshareddata.xcschemes</summary>

| File                                                                                                                              | Summary                                                                                 |
| ---                                                                                                                               | ---                                                                                     |
| [Runner.xcscheme](https://github.com/Orisiss/NoteManager/blob/master/ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme) | HTTP error 429 for prompt `ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme` |

</details>

---

## 🚀 Getting Started

***Requirements***

Ensure you have the following dependencies installed on your system:

* **Dart**: `version x.y.z`

### ⚙️ Installation

1. Clone the NoteManager repository:

```sh
git clone https://github.com/Orisiss/NoteManager
```

2. Change to the project directory:

```sh
cd NoteManager
```

3. Install the dependencies:

```sh
pub get
```

### 🤖 Running NoteManager

Use the following command to run NoteManager:

```sh
dart main.dart
```

### 🧪 Tests

To execute tests, run:

```sh
dart test
```

---

## 🛠 Project Roadmap

- [X] `► INSERT-TASK-1`
- [ ] `► INSERT-TASK-2`
- [ ] `► ...`

---

## 🤝 Contributing

Contributions are welcome! Here are several ways you can contribute:

- **[Submit Pull Requests](https://github.com/Orisiss/NoteManager/blob/main/CONTRIBUTING.md)**: Review open PRs, and submit your own PRs.
- **[Join the Discussions](https://github.com/Orisiss/NoteManager/discussions)**: Share your insights, provide feedback, or ask questions.
- **[Report Issues](https://github.com/Orisiss/NoteManager/issues)**: Submit bugs found or log feature requests for Notemanager.

<details closed>
    <summary>Contributing Guidelines</summary>

1. **Fork the Repository**: Start by forking the project repository to your GitHub account.
2. **Clone Locally**: Clone the forked repository to your local machine using a Git client.
   ```sh
   git clone https://github.com/Orisiss/NoteManager
   ```
3. **Create a New Branch**: Always work on a new branch, giving it a descriptive name.
   ```sh
   git checkout -b new-feature-x
   ```
4. **Make Your Changes**: Develop and test your changes locally.
5. **Commit Your Changes**: Commit with a clear message describing your updates.
   ```sh
   git commit -m 'Implemented new feature x.'
   ```
6. **Push to GitHub**: Push the changes to your forked repository.
   ```sh
   git push origin new-feature-x
   ```
7. **Submit a Pull Request**: Create a PR against the original project repository. Clearly describe the changes and their motivations.

Once your PR is reviewed and approved, it will be merged into the main branch.

</details>

---

## 📄 License

This project is protected under the [SELECT-A-LICENSE](https://choosealicense.com/licenses) License. For more details, refer to the [LICENSE](https://choosealicense.com/licenses/) file.

---

## 👏 Acknowledgments

- List any resources, contributors, inspiration, etc. here.

[**Return**](#-quick-links)

---
