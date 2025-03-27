
# BeStories App

## Overview
This is a humble coded version for the **Instagram-like Stories feature** exercice using **SwiftData and SwiftUI**. Users can view stories, mark them as seen, like/unlike stories, and navigate between the story list and story details.

## Architecture
The project implements the **MVVM (Model-View-ViewModel)** architecture following the clean Architecture principles. It uses seperates the codes into different modules for better scalability and maintainability. I tried to use the recent addition in SwiftUI as the **NavigationStack**, **Observable** objects all along with **SwiftData**

## What could be improved

### More and more tests: 
- add more unit and integration test
- implement a CI/CD solution

### Better Error management: 
- implement more sexy error Views and alert toasts

### Dependency Injection
- create custom Environment values
- use a DI library ( [**Factory**](https://github.com/hmlongco/Factory) Maybe ?? why not )

### Stories Navigation
- implement better solution to navigate between stories without going back (Maybe use the new **ScrollTargetBehavior** api)

### Logs, Analytics and crash detection
- add a proper Logger, anlytics and Crash detection library (**Firebase/Crashlytics**)

### Code formatting
- Maybe add a code linter such as **SwiftLint**

### .xcodeproj Managment
- Maybe use **xcodegen**


