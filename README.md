# Additional homework - 3D Adventure Game  

A simple 3D adventure game built in **Godot** where the player explores a natural environment, collects items, and wins by reaching a goal.  

## Features  
- **3D World:** Trees, rocks, fences, and collectibles  
- **Player Controls:** Move, jump, and explore  
- **Timer System:** Complete the game before time runs out  
- **Win & Game Over UI:** Display messages when the player wins or loses   

## How to Play  
- Move with **WASD**  
- Jump with **Space**  
- Collect items to increase score  
- Reach the goal before time runs out  

## Project Structure  
game_project/ │── assets/ # Textures, models, and other assets
│── scenes/ # Godot scene files
│ ├── main.tscn # Main game scene
│ ├── player.tscn # Player character scene
│ ├── environment.tscn # Trees, rocks, and terrain
│ ├── UI.tscn # UI elements (score, timer, win/game over screens)
│── scripts/ # GDScript files
│ ├── player.gd # Player movement logic
│ ├── game_manager.gd # Controls game state and logic
│ ├── ui_manager.gd # Manages UI updates
│── project.godot # Godot project file


## Running the Game  
1. Open the project in **Godot Engine**  
2. Run the `main.tscn` scene  

