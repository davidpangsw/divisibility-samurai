## Phase09: Game life cycle
- Time configuration: I see you usually use millisecond number to configure the app. Why do you prefer ms int rather than a Duration object? If you think Duration is better, change it. If not, explain the pros and cons.

- widgets/GameResultDialog
    - This is a dialog that contains all the game ending information, including all the details (win or lose, score, level, all the wrong pairs of number and divisor ) of the completed game.
    - It also includes a button to restart the game

- Losing implementation.
    - If lives drop to zero, the player loses. 
    - Stop all block generation immediately. 
    - Clear the whole PlayArea immediately.
    - Stop all the animations and the whole game immediately.
    - Display the GameResultDialog

- Level proceeding and win game. Now, we implement the level proceeding:
    a. If enough correct blocks being slashed in the current level, the current level is completed. Currently the number of correct blocks required is 10, but it should be configurable in the config file.
    b. If a level is completed, and not all levels are completed:
        - Stop all block generation immediately. 
        - Clear the whole PlayArea immediately.
        - Stop all animations and reset the play area immediately
        - let the user to wait for several seconds (Configurable). Display something to tell user to wait.
        - A new level starts, scores are preserved, level++, lives preserved, a new divisor
        - If not all levels are completed, proceed to the next level
    c. If a level is completed, and all levels are completed:
        - Stop all block generation immediately. 
        - Clear the whole PlayArea immediately.
        - Stop all animations and reset the play area immediately
        - the user wins the game and is shown the Game Result Dialog.

- Make sure the game state and lifecycle is managed properly.

- Block generation change
    - With a uniform distribution, it is quite hard to get a number divisible by large divisor, so I need to change the algorithm.
    - First, with some probability (0.5 for now, configurable), the number block generated is divisible by the divisor.
    - After we know it is divisible or not, we generate the actually number within the range.
    - In that case, of 0.5 chance we get a divisible block.

- For testing purpose, reduce the block required to proceed to 3, and the lives to 5.