<div align="center">
  <h1>BBQuotes</h1>

  <p>
    <a href="https://developer.apple.com/swift/" target="_blank"><img src="https://img.shields.io/badge/Swift-5.10-585b70?logo=swift&style=for-the-badge&labelColor=313244&logoColor=fab387" alt="Swift 5.10"></a>
    <a href="https://developer.apple.com/xcode/"><img src="https://img.shields.io/badge/Xcode-15.4-585b70?logo=Xcode&style=for-the-badge&labelColor=313244&logoColor=89b4fa" alt="Xcode 15.4"></a>
    <a href="https://developer.apple.com/ios/"><img src="https://img.shields.io/badge/iOS-17-585b70?logo=apple&style=for-the-badge&labelColor=313244&logoColor=cdd6f4" alt="iOS 17"></a>
  </p>

  <h3>⚠️ SPOILER ALERT ⚠️</h3>
  <p>This app contains information about characters and events from Breaking Bad, Better Call Saul, and El Camino.</p>
  <p>...</p>
  <p>...</p>
  <p>...</p>
  <p>...</p>
  <p>...</p>
  <br>
  <div>
    <img src="_Demo/1-mockup-breaking-bad.png" width="30%" alt="Breaking Bad">&nbsp;&nbsp;&nbsp;
    <img src="_Demo/2-mockup-better-call-saul.png" width="30%" alt="Better Call Saul">&nbsp;&nbsp;&nbsp;
    <img src="_Demo/3-mockup-el-camino.png" width="30%" alt="El Camino">
    <br><br>
    <img src="_Demo/4-mockup-character-detail.png" width="30%" alt="Character Detail">&nbsp;&nbsp;&nbsp;
    <img src="_Demo/5-mockup-character-detail-status.png" width="30%" alt="Character Detail Status">
  </div>

</div>

## Overview
BBQuotes is a SwiftUI application that showcases quotes from the Breaking Bad universe, including Breaking Bad, Better Call Saul, and El Camino. The app allows users to view random quotes, character information, and explore details about their favorite characters from these iconic TV series.

Based on the Udemy course [iOS 18, SwiftUI 6, & Swift 6: Build iOS Apps From Scratch](https://www.udemy.com/course/ios-15-app-development-with-swiftui-3-and-swift-5/), **with the following implementations by myself**:

- Integration of additional [packages](#packages) to extend capabilities and streamline development
- [Project structure](#project-structure) for better organization
- [Unit tests](https://github.com/uhcakip/BBQuotes/tree/master/BBQuotesTests) for API client and view models
- Enhanced API client with [generic `makeRequest` function](https://github.com/uhcakip/BBQuotes/blob/12f7134b8e4e49b191049caba347f5b3e2a7d0a8/BBQuotes/Clients/APIClient.swift#L38)
- Improved error handling with [custom `APIError` messages](https://github.com/uhcakip/BBQuotes/blob/12f7134b8e4e49b191049caba347f5b3e2a7d0a8/BBQuotes/Clients/APIClient.swift#L70)

## Features
- Fetch and display random quotes from Breaking Bad, Better Call Saul, and El Camino
- View detailed character information, including images, occupations, and status
- Toggle between different TV series
- Error handling and user feedback

## Demo
<img src="_Demo/demo.gif" alt="BBQuotes Demo">

## Project Structure
```
.
├── BBQuotes
│   ├── BBQuotesApp.swift
│   ├── Clients
│   │   └── APIClient.swift
│   ├── Models
│   │   ├── Character.swift
│   │   ├── Death.swift
│   │   ├── Production.swift
│   │   └── Quote.swift
│   ├── Screens
│   │   ├── Character
│   │   │   └── Views
│   │   │       └── CharacterView.swift
│   │   ├── ContentView.swift
│   │   └── Quote
│   │       ├── ViewModels
│   │       │   └── QuoteViewModel.swift
│   │       └── Views
│   │           └── QuoteView.swift
│   └── Utils
│       └── MockData.swift
├── BBQuotesTests
│   ├── Clients
│   │   ├── APIClientIntegrationTests.swift
│   │   └── APIClientTests.swift
│   ├── Models
│   │   └── ProductionTests.swift
│   └── Screens
│       └── Quote
│           └── ViewModels
│               └── QuoteViewModelTests.swift
```

## Packages
This project uses Swift Package Manager (SPM) for dependency management. The following packages are included:

- [Inject](https://github.com/krzysztofzablocki/Inject) - Used for hot reloading during development
- [SwiftLint](https://github.com/realm/SwiftLint) - Used for code linting
- [SwiftFormat](https://github.com/nicklockwood/SwiftFormat) - Used for code formatting