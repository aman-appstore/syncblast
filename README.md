# 🚀 SyncBlast
**High-Performance Material 3 Wireless DJ System**

SyncBlast ek advanced mobile application hai jo 20 smartphones ko ek sath jodkar ek synchronized surround-sound network mein badal deta hai. Ye app bina internet ke, local Wi-Fi hotspot par chalta hai.

## ✨ Features
* **Zero-Latency Sync:** 0.1ms precision timing logic (PTP) ke saath.
* **Master-Slave Architecture:** 1 Host (Master) aur 20 Joiners (Slaves).
* **AI Sound Engine:** Auto-Equalizer aur Distortion Control jo speaker health ke hisaab se awaaz adjust karta hai.
* **Mic Mode:** Master phone ko real-time wireless mic mein badal deta hai.
* **Visualizer Art:** Har phone par beat-synced 3D waves aur flash-sync animations.
* **Smart Pill UI:** App background mein jane par status bar mein ek interactive mini-controller.

## 🛠 Tech Stack
- **Framework:** Flutter (Material 3 Design)
- **Language:** Dart & Native Kotlin/C++ (Oboe Engine)
- **Protocol:** UDP over Local Hotspot
- **State Management:** Riverpod

## 📂 Project Structure
```text
syncblast/
├── lib/
│   ├── core/           # App themes aur constants
│   ├── providers/      # State management (Riverpod)
│   ├── screens/        # UI Screens (Lobby, Player, etc.)
│   ├── services/       # Core Logic (Networking, Audio, AI)
│   └── main.dart       # Entry Point
├── android/            # Android Native Config
└── pubspec.yaml        # Dependencies list