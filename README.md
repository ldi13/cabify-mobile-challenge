# Cabify Mobile Challenge

## Description
- Chosen architecture: `Composable Architecture` with SwiftUI: Views holding `Stores`, passing events to `Reducers` in charge of state mutations and throwing `Effects`.
- All documentation available here: https://www.pointfree.co/collections/composable-architecture
- One module "ChallengeCore" to hold models
- Dependency management with SPM to deal with external dependencies
- Unit testing done in `ChallengeTests.swift`
- NB: Not all the business logic is covered, it's just to highlight how we can cover it by implementing this architecture
