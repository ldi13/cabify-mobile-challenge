# Cabify Mobile Challenge

## Requirements
- Install and run it on Xcode 13
- iOS 15.0 simulator

## Description
- Chosen architecture: `Composable Architecture` with SwiftUI: Views holding `Stores`, passing events to `Reducers` in charge of state mutations and throwing `Effects`.
- All documentation available here: https://www.pointfree.co/collections/composable-architecture
- One module "ChallengeCore" to hold models
- Dependency management with SPM to deal with external dependencies
- Unit testing done in `ChallengeTests.swift`
- NB: Not all the business logic is covered, it's just to highlight how we can cover it by implementing this architecture

## Screeshots
### Main view
<img src="https://user-images.githubusercontent.com/11734827/135828699-09300949-ddf7-48a6-8463-8154a2a8940e.png" width="390" height="844">

### Products view
<img src="https://user-images.githubusercontent.com/11734827/135828698-0da9c939-8f92-4bec-8993-c2235bd26b63.png" width="390" height="844">

### Cart view
<img src="https://user-images.githubusercontent.com/11734827/135828688-3494d4ed-8d35-462c-8d42-df8f71428774.png" width="390" height="844">
