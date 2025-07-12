



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



## Phase 5 Implementation (Slashing)
1. Implement slashing to the block generated in the playarea:
    - If a correct block is slashed, points incremented. Do not proceed level yet, we will implement it in later phase. Just add points.
    - If a wrong block is slashed, deduct life point.
    - If life points go to zero, tell the user the game is over, and provide a button for user to restart the game.
2. Remember to implement the slashing animation and sound we discussed.
3. Make sure the game state and lifecycle is managed properly.
4. Review your code, make sure it is correct and complete. No errors are allowed. 


## Phase 6 Implementation
## Phase 7 Deployment
1. Our game is done. Do not edit any classes. Teach me how to deploy it into firebase. Just generate your answers and commands involved into the chat.