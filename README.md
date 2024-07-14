# War Game

## Introduction
This is a War Game application written in Swift. The game involves a player competing against the computer. The player's position (either east or west) is determined based on their geographical location relative to a specified midpoint latitude. The game features automatic card flipping with images of varying strengths, and scores are updated accordingly.

## Features
- **Player Registration**: Enter your name the first time you log in. Subsequent logins only require entering the name.
- **Geographical Positioning**: Determines player’s side (east or west) based on their location relative to the midpoint latitude: 34.817549168324334.
- **Automatic Gameplay**: Cards are automatically flipped every 5 seconds, with each card being visible for 3 seconds.
- **Scoring System**: Scores are updated based on the strength of the card images.

## Requirements
- iOS device with location services enabled.
- Swift 5.0 or higher.
- Xcode 11.0 or higher.

## Installation
1. Clone the repository:
   ```bash
   git clone [https://github.com/your-repo/war-game-app.git](https://github.com/YardenCherry/WarGame.git)
   ```
2. Open the project in Xcode:
   ```bash
   cd war-game-app
   open WarGameApp.xcodeproj
   ```
3. Build and run the project on your iOS device or simulator.

## Usage

### First-Time Login
1. Launch the app.
2. Click the button to enter your name.
3. Your location will be sampled to determine your side (east or west).

### Subsequent Logins
1. Enter your name.
2. The app will sample your location to determine your side.

### Gameplay
1. Once the location is received, the location request stops.
2. The UI updates to display the start button and the determined side (east or west).
3. The game starts automatically, with cards flipping every 5 seconds.
4. Each card image has a strength value. Scores are updated based on which card is stronger.
5. The game continues with the scores being updated every turn.

## Dependencies
- CoreLocation: To manage location services.
- UIKit: For the user interface components.

## Future Enhancements
- Add multiplayer support.
- Enhance UI with animations and sound effects.
- Implement different difficulty levels.
- Add more card images with varying strengths.

https://github.com/user-attachments/assets/45fd5835-1f56-4def-97d2-1123f476ef45

![Simulator Screenshot - iPhone 14 Pro - 2024-07-14 at 22 50 42](https://github.com/user-attachments/assets/90948b69-9f58-4b07-a0a1-6226c497eb43)

![Simulator Screenshot - iPhone 14 Pro - 2024-07-14 at 22 51 05](https://github.com/user-attachments/assets/e27a63c9-f22d-48dd-b718-f278303c74ed)

![Simulator Screenshot - iPhone 14 Pro - 2024-07-14 at 22 51 09](https://github.com/user-attachments/assets/a9a68c83-a7cf-421a-8087-1d5ddbf933dc)

![Simulator Screenshot - iPhone 14 Pro - 2024-07-14 at 22 51 31](https://github.com/user-attachments/assets/4c645c76-b0ad-45c6-b9ba-236a9e212276)
