# 🧱 ashiq_project

## 🚀 Overview
`ashiq_project` is a **Flutter Clean Architecture Starter Template** that bootstraps a new Flutter app with:
- A scalable and modular folder structure  
- Built-in **dependency injection**  
- Pre-configured **networking**, **local storage**, and **core utilities**  
- Ready-to-use **themes**, **routes**, and **translations**

This brick saves hours of setup time — just run one command and start building features.

---

## 📁 Folder Structure
After generating, your project will be organized like this:

```
lib/
├── core/
│ ├── common/ → Shared widgets & models
│ ├── config/ → App theme, routes, colors, constants
│ ├── di/ → Dependency injection setup
│ ├── error/ → Failure & exception handling
│ ├── extensions/ → Custom extensions
│ ├── network/ → API client & connectivity check
│ ├── services/ → Hive-based local storage
│ ├── usecase/ → Base use case template
│ └── utils/ → Helper classes (toast, logs, file picker, etc.)
│
├── assets/
│ ├── fonts/ → Roboto font family
│ ├── images/ → Placeholder assets
│ ├── logo/ → App logos
│ ├── lottie/ → Lottie animations
│ └── translations/ → Language files (e.g. en-US.json)
│
├── global.dart
└── required_dependencies.yml
```


---

## ⚙️ Key Features
✅ Clean Architecture structure  
✅ GetIt-based dependency injection  
✅ Network & connectivity setup  
✅ Theming and route management  
✅ Localization-ready  
✅ Reusable widgets (textfield, dropdown, shimmer, etc.)  
✅ Built-in Hive storage service  
✅ Utility classes (toast, snackbar, logs, etc.)

---

## 🧩 Dependencies
Dependencies are managed through `required_dependencies.yml` and installed automatically after generation.

Example:
```yaml
dependencies:
  - dio
  - get
  - hive
  - easy_localization

dev_dependencies:
  - hive_generator
  - build_runner

```

---

## 🪄 Usage

### 1 Add the brick
```
mason add ashiq_project
```

### 2 Add the brick
```
mason make ashiq_project
```
