

    
    
    It contains a scoreboard that display the StatsBar, which contains the score, level, lives, divisor, etc. on the same row. GameWidget also contains the PlayArea.
    e. PlayArea: This is the main play area with fixed size. Playable in mobiles and webs. The size should be compatible with most of the devices. Details would be explained later. Make sure the width and height are fixed.




## Phase 2 Implementation (GameViewModel)
3. Create a GameViewModel under the folder "lib/view_models". It is the only class in our app to extend ChangeNotifier. Do not implement anything yet.
1. Implement the necessary view models under the folder "lib/view_models". Each view model contains information for widgets to render.
    a. GameViewModel: The main view model that controls the game flow. It is the only class in our app to extend ChangeNotifier.
        - Controls the lifecycle of the games, including starting and ending the games. 
        - Contains a single game loop that runs at a fixed interval, configurable. The configuration is in the config file.
        - In the game loop, each time it will run a gameIteration(timeDelta), where timeDelta is the time elapsed since the previous iteration, measured in microseconds. This delta is inspired by the game development.
        - A gameIteration(timeDelta) is a function that will call the update(timeDelta) method of the GameStateViewModel, and also notifyListener().
        - Contains the GameStateViewModel, which truly contains the game state of a single game. 
        - Game always start automatically, and no pause allowed.
    b. GameStateViewModel: The view model that contains the game state of a single game. DO NOT extend ChangeNotifier!
        - Contains the game state of a single game. 
        - Scores, lives, current level, etc.
        - Provides update(timeDelta) to be called.
        - Do not provide unused methods in this phase!
2. Review your code, make sure it is correct and complete. No errors are allowed. 

## Phase 3 Implementation (GameStateViewModel generating NumberBlockViewModel)
1. Now let's implement the number block generation and movement.
    a. NumberBlockViewModel: The view model that represents one number block in the game. It contains the number block state. 
        - The position, velocity, acceleration, number, etc.
        - Provide update(timeDelta) to be update its state: position, velocity, etc.
        - Provide a way to generate itself at random position.
            - Initial position is at the bottom of the screen randomly from leftmost to rightmost.
            - Initial velocity is up, and also has a small horizontal component randomly from left to right.
            - Subject to a downward acceleration, just like gravity.
            - Bounce off the top/left/right edges of the PlayArea.
    b. GameStateViewModel:
        - Add a list of NumberBlockViewModels
        - In update(timeDelta), it should generate, update or remove number blocks as needed. For each number block:
            - If the block drops off the PlayArea, it is removed.
            - The block should NOT be removed unless it is off the screen
        - At most 3 number should appear at the same time, configurable.
2. Do not implement the game logic or hovering yet. Just generate number blocks with an initial velocity, let it move up and down, and bounce off the top/left/right edges of the PlayArea.
3. Do not make unnecessary changes to the works we have done in Phase 1 and 2.
    - DO NOT add unnecesary buttons, features, titles, etc.
4. Remember to implement the UI components to display the generated number blocks in play area.
5. Review your code, make sure it is correct and complete. No errors are allowed. 


## Phase 4: NumberBlock gravity animation
In Phase 4, we will implement the gravity animation of the number block inside PlayArea.
Make sure your changes are minimal. Do not add unnecessary buttons, features, titles, etc.
1. Implement GravityAnimation: It is a Widget that animates "gravity" of a child.
    - It is initialized with a position (x, y), and a velocity (vx, vy). The acceleration is fixed and point downwards. It will animate the child to move according to the physics of gravity.
2. Implement GravityNumberBlock: It is a widget that combines NumberBlock and GravityAnimation.
3. Implement PlayArea: It is a widget that contains a list of GravityNumberBlock.


## Phase 4 Implementation (Reorganizing help dialog)
1. The help dialog is a huge mess. I will guide you to reorganize it.
2. First, Extract out the whole AlertDialog into a new widget called HelpDialog.
3. Group the content of the HelpDialog into three sections. Each section corresponds to a class and written in the same file in HelpDialog:
    a. The "How to play" section that explain the rules of the game.
    b. The example section that display number blocks as examples to explain.
4. Make sure your help dialog is correct and complete. No errors are allowed. 
5. Removing unnecessary spacing SizedBox. Use proper technique.

## Phase 5 Implementation (Slashing animation)
1. Revamp the number block first.
    a. Now, NumberBlock is just a block of number, and should not contain about animation, position or any calculations. Do not animate ANY things or opacity. I don't want to see any Animation here
    b. Create a class, MovingNumberBlock, that actually do the moving and read the data of number_block_view_model.
    c. Fixed classes that depends on NumberBlock.
2. Define SlashingNumberBlock that will wrap and animate NumberBlock as follows:
    - When clicked, randomly draw a straight line from one side to another side, in 3 seconds.
    - During the animation, partial of the line is drawn until complete.
3. Add the SlashingNumberBlock to the top of homepage to test your animation.
4. Make sure your change is correct and complete. No errors are allowed.  No ParentDataWidget Error is allowed 

## Phase 5 Implementation (Slashing)
1. Implement slashing to the block generated in the playarea:
    - If a correct block is slashed, points incremented. Do not proceed level yet, we will implement it in later phase. Just add points.
    - If a wrong block is slashed, deduct life point.
    - If life points go to zero, tell the user the game is over, and provide a button for user to restart the game.
2. Remember to implement the slashing animation and sound we discussed.
3. Make sure the game state and lifecycle is managed properly.
4. Review your code, make sure it is correct and complete. No errors are allowed. 


## Phase 6 Implementation (Level proceeding and win game)
1. Now, implement the level proceeding:
    a. If enough correct blocks being slashed in the current level, the current level is completed. Currently the number is 10, but it should be configurable in the config file.
    b. If all levels are completed, the user wins the game. Give them a button to restart the game; if not all levels are completed, proceed to the next level.
    c. When proceeding to the next level, clear all the number blocks, and let the user to wait for several seconds (configurable) because the new level starts.
2. Make sure the game state and lifecycle is managed properly.
3. Review your code, make sure it is correct and complete. No errors are allowed. 

## Phase 7 Deployment
1. Our game is done. Do not edit any classes. Teach me how to deploy it into firebase. Just generate your answers and commands involved into the chat.