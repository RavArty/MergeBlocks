# MergeBlocks

2D game based on merging blocks (core functionality for a future game).

After releasing two video games on Unity, we decided to develop third game on Swift.
It will be a simple, meditative game. Main idea is to merge blocks with the same color.

### Prerequisites

* macOS 10.x
* Xcode 10.0 beta or later

## Acknowledgments

* MergeBlocks uses MVC architecture
* Model files contain 2D grid of objects, and the rest of the game logic (detecting shapes if you have more than 2 adjacent blocks with the same color, etc.)
* GameScene file is a view. This file is responsible for showing objects on the screen and handling touches
* GameViewController is coordinator between models and view (as in classic MVC app)
