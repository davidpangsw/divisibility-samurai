## Phase08: Game life cycle
Level proceeding and win game
1. Now, implement the level proceeding:
    a. If enough correct blocks being slashed in the current level, the current level is completed. Currently the number is 10, but it should be configurable in the config file.
    b. If all levels are completed, the user wins the game and is shown a winning dialog, including all the details of the completed game. Give them a button to restart the game; if a level is completed but not all levels are completed, proceed to the next level.
    c. When proceeding to the next level, clear all the number blocks immediately, and let the user to wait for several seconds (configurable) because the new level starts.
2. Make sure the game state and lifecycle is managed properly.
