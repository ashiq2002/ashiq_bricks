
---

## 📘 `ashiq_feature/README.md`

```markdown
# 🧩 ashiq_feature

## 🚀 Overview
`ashiq_feature` is a **Flutter Clean Architecture Feature Generator** that creates a fully structured feature module — including `data`, `domain`, and `presentation` layers — and **automatically injects dependencies** into your main injector file.
```
---

## 📁 Generated Folder Structure
When you generate a feature, the folder structure looks like this:

```
lib/
└── features/
└── {{feature_name}}/
├── data/
│ ├── datasources/
│ │ └── {{feature_name}}_remote_data_source.dart
│ ├── models/
│ │ ├── {{feature_name}}_response.dart
│ │ └── {{feature_name}}_response.g.dart
│ └── repositories/
│ └── {{feature_name}}_repository_impl.dart
│
├── domain/
│ ├── entities/
│ │ └── {{feature_name}}_entity.dart
│ ├── repositories/
│ │ └── {{feature_name}}_repository.dart
│ └── usecase/
│ └── {{feature_name}}_usecase.dart
│
├── presentation/
│ ├── pages/
│ │ └── {{feature_name}}_page.dart
│ ├── bloc/ or controllers/ → Based on your chosen state management (Bloc or GetX)
│ └── widgets/
│ └── {{feature_name}}_widget.dart
│
└── {{feature_name}}_injector.dart
```

---

## ⚙️ Features
✅ Clean Architecture (Data → Domain → Presentation)  
✅ Supports **Bloc** or **GetX** (your choice)  
✅ Automatically updates the **main dependency injector**  
✅ Generates repository, model, entity, and use case templates  
✅ Keeps project structure modular and consistent  

---

## 🪄 Usage

### 1 Add the brick
```
mason add ashiq_feature
```

### 2 Add the brick
```
mason make ashiq_feature
```
