# Overview
In this math game written in Flutter, a player has to determine some numbers are divisible by another number or not. The game is supposed to be played on web or mobile phone.

## Game Rules
1. There will be a fixed size of PlayArea on screen. The size should be compatible with most of the devices.
2. In PlayArea, there will be some numbers blocks appear and move randomly onthe screen. The number blocks behave like this:
    a. Initial position is at the bottom of the screen randomly.
    b. Initial velocity is up, and also has a small horizontal component randomly from left to right.
    c. Subject to a downward acceleration, just like gravity.
    d. Bounce off the top/left/right edges of the PlayArea.
    e. Drop off the screen finally. If the block is off the PlayArea, it disappears. No penalty.
    f. Has a number on it. The number is a random number between 10 and 100. Configurable.
3. If a number is hovered by the player, it is "slashed" and considered out of the game. An animation should be applied and the block may seem to be there, but the block should not have any more interaction with the player.

4. The game has 5 levels, each level has a different divisor from 2 to 6. Configurable.

5. If a number is slashed, the game will check if the number is divisible by the divisor of the current level. If it is, the player scores a point. If it is not, the player loses a life.

6. If a user break 10 correct number blocks in a level, the level is considered to be complete. In that case, if the user already completes all levels, the user wins the game; otherwise, the user proceeds to the next level.

7. The user has 10 life points in the whole game, configurable. If the user loses all lives, the game is over. 


You don't have to write any code yet. If you understand, say you understand. 