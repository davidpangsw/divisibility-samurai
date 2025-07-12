## Phase07: Life deduction and score
Now, we need to implement the game logic.

- Create a GameViewModel under the folder "lib/view_models". It is the only class in our app to extend ChangeNotifier. Do not implement anything yet.

- Implement the necessary view models under the folder "lib/view_models". Each view model contains information for widgets to render.
    a. GameViewModel: The main view model that controls the game flow. It is the only class in our app to extend ChangeNotifier.
        - Controls the lifecycle of the games, including starting and ending the games. 
        - Contains the GameStateViewModel, which truly contains the game state of a single game. 
        - Game always start automatically, and no pause allowed.
    b. GameStateViewModel: The view model that contains the game state of a single game. DO NOT extend ChangeNotifier!
        - Contains the game state of a single game. 
        - Scores, lives, current level, etc.
        - Provides method(s) to allow deducting lives or increasing score when a block is slashed

- When a block is slashed:
    - If it is a correct slash, increase score. DO NOT proceed levels yet, we will do it later.
    - If it is an incorrect slash deduct a life point. DO NOT end the game if life point goes to zero, we will do it later. Just let the life points drops to negative.

- Fix bugs:
    - In phase 6, some blocks seems doesn't appear properly but still be able to get slashed. See if it is fixed.
    - Refactor Play Area properly (if not yet), to separate the concerns, that you can fix the bugs easier.

- Increase the maximum allowed blocks from 1 to 3
    - There will be 0-3 blocks on the play area sometimes. (You can do it in your own style. Just make sure not just 1)

- Fix the config
    - The config file may have some repeated/unused config values.
    - The divisors should be a list of [2,3,4,5,6], not setting min or max.
    - Some hard-coded values are potentially configurable. Make your own judgement and move them to config file.