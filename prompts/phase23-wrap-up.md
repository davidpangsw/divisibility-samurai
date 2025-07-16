## Phase23: Wrap up
- HelpDialogue
    - In the example, we used a row to list the BasicNumberBlock. But when the screen is too small, we cannot see the rightmost one.
        - Change the  coordinates of block and the size of block area, such that they layout vertically.
    - Change the top right helpbutton, to show the text "How To Play"
    - In the starting screen of the game, include a How To Play button alongside Start Game button

- DivisorHintCard
    - In the divisibility hints, use BasicNumberBlock (wrapped in a same-sized block area) to display the dividends.
        - Dividend means the number

- Game overlay : This class is large now, let's refactor it:
    - Create a folder, purely for making game overlay, under game_widget
    - Play the game overly class into the folder
    - Split some meaningful component of game overlay into several file, in the same folder.

- Widget and view model are both using Sound manager, which may not be a good practice, refactor it.