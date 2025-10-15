# 🍃 Leaf - iOS Book Discovery App

> An iOS application for book discovery and personal library management, built with SwiftUI and Firebase.

[![iOS](https://img.shields.io/badge/iOS-15.0+-blue.svg)](https://developer.apple.com/ios/)
[![Swift](https://img.shields.io/badge/Swift-5.7-orange.svg)](https://swift.org/)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-4.0-green.svg)](https://developer.apple.com/xcode/swiftui/)
[![Firebase](https://img.shields.io/badge/Firebase-10.0-yellow.svg)](https://firebase.google.com/)

## 📱 Overview


Leaf is a beautifully crafted iOS application that helps users discover, explore, and manage their personal book collections. With a focus on clean architecture and modern iOS development practices, this app showcases advanced SwiftUI techniques, Firebase integration, and robust networking capabilities.

<img src="https://github.com/user-attachments/assets/7850dfb5-5881-4ee2-bd9b-e970539e54ab" width="200"/>

<img src="https://github.com/user-attachments/assets/1e96b662-404b-4a9c-abb8-244e07a5a931" width="200"/>

<img src="https://github.com/user-attachments/assets/f62325ed-9296-4e2b-b429-344bb32ec73c" width="200"/>

<img src="https://github.com/user-attachments/assets/80360f4c-21d0-4800-9b36-8f6fda60e68e" width="200"/>

<img src="https://github.com/user-attachments/assets/f7e3f4d9-75ca-475b-a735-8c069af2a2ae" width="200"/>

<img src="https://github.com/user-attachments/assets/cff954b5-e887-4179-bfb0-5cfad6720ed8" width="200"/>


## ✨ Key Features

- **📚 Book Discovery**: Search and explore books across different subjects and categories
- **🔐 Secure Authentication**: Firebase-powered user authentication with email/password
- **❤️ Personal Library**: Save and manage favorite books in your personal collection
- **🎨 Modern UI**: Clean, intuitive interface built with SwiftUI
- **🔍 Advanced Search**: Comprehensive search functionality with real-time results
- **📖 Detailed Book Info**: View comprehensive book details including covers, authors, and publication info

## 🏗️ Architecture & Technical Highlights

### Clean Architecture Implementation
- **MVVM Pattern**: Clear separation of concerns with ViewModels managing business logic
- **Use Cases**: Dedicated use case classes for specific business operations
- **Repository Pattern**: Abstracted data layer with networking and local storage
- **Dependency Injection**: Loosely coupled components for better testability

### Technology Stack
- **Frontend**: SwiftUI with native iOS components
- **Backend**: Firebase Authentication & Firestore
- **Networking**: Custom URLSession-based networking layer
- **Architecture**: MVVM + Clean Architecture
- **Data Management**: Codable models with robust error handling

### Code Quality Features
- **Error Handling**: Comprehensive error management with custom error types
- **Logging System**: Custom logger for debugging and monitoring
- **Type Safety**: Leveraging Swift's strong type system
- **Async/Await**: Modern concurrency with async/await patterns
- **Code Organization**: Modular structure with clear folder hierarchy

## 📂 Project Structure

```
Leaf/
├── 🎯 Core/                    # Main app structure
│   ├── RootView.swift          # App entry point with auth flow
│   └── TabBarView.swift        # Main navigation
├── 🔐 Authentication/          # User authentication
│   ├── AuthService.swift       # Firebase auth service
│   └── AuthError.swift         # Authentication error handling
├── 📊 Models/                  # Data models
│   ├── Book.swift              # Book data structure
│   ├── DBUser.swift            # User data model
│   └── UserFavoriteBook.swift  # Favorites management
├── 🌐 Networking/              # Network layer
│   ├── NetworkService.swift    # HTTP client
│   ├── Endpoint.swift          # API endpoints
│   └── APIError.swift          # Network error handling
├── 🎭 UseCases/                # Business logic
│   ├── SearchBooksUseCase.swift
│   ├── GetBooksBySubjectUseCase.swift
│   └── FetchBookCoverUseCase.swift
├── 🔥 Firestore/               # Firebase integration
│   └── UserManager.swift       # User data management
└── 🛠️ Utilities/               # Helper classes
    └── Logger.swift            # Custom logging system
```

## 🚀 Getting Started

### Prerequisites
- Xcode 14.0+
- iOS 15.0+
- Swift 5.7+
- Firebase project setup

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/Leaf.git
   cd Leaf
   ```

2. **Firebase Setup**
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable Authentication (Email/Password)
   - Enable Firestore Database
   - Download `GoogleService-Info.plist` and add it to the project

3. **Open in Xcode**
   ```bash
   open Leaf.xcodeproj
   ```

4. **Build and Run**
   - Select your target device/simulator
   - Press `Cmd + R` to build and run

## 🎨 Screenshots

<!-- Add your app screenshots here -->
*Screenshots coming soon - showcasing the beautiful SwiftUI interface*

## 🔧 Technical Implementation Details

### Authentication Flow
- **Secure Login**: Firebase Authentication with email/password
- **Auto-login**: Persistent authentication state management
- **Password Management**: Reset and update password functionality

### Data Management
- **Real-time Sync**: Firestore for real-time data synchronization
- **Local Caching**: Efficient data caching for offline experience
- **Model Validation**: Robust data validation and error handling

### Networking Layer
- **RESTful API**: Clean API integration with proper endpoint management
- **Error Handling**: Comprehensive network error management
- **Async Operations**: Modern async/await for non-blocking operations

## 🎯 Development Practices

- ✅ **Clean Code**: Following Swift best practices and conventions
- ✅ **SOLID Principles**: Maintainable and extensible code architecture
- ✅ **Error Handling**: Comprehensive error management throughout the app
- ✅ **Performance**: Optimized for smooth user experience
- ✅ **Accessibility**: iOS accessibility standards compliance

## 🔮 Future Enhancements

- [ ] **Book Reviews**: User review and rating system
- [ ] **Social Features**: Book recommendations and sharing
- [ ] **Offline Mode**: Enhanced offline functionality
- [ ] **Widget Support**: iOS home screen widgets
- [ ] **Apple Watch App**: Companion watchOS application

## 👨‍💻 About the Developer

**Mohamed Atallah** - iOS Developer

This project demonstrates proficiency in:
- Modern iOS development with SwiftUI
- Clean architecture and design patterns
- Firebase integration and backend services
- RESTful API integration and networking
- User experience and interface design
- Code quality and best practices

---
*Built with ❤️ using SwiftUI and Firebase*



