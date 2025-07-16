## Phase21: I am going to Tune the game to become additive
- UI/UX
    - Block generation algorithm
        - Now, blocks can be generated in 2 ways.
        - Blocks are generated randomly after some time. But if there are more than 3 blocks on screen, this generation will not trigger. (This is similar as before, but now it is 3)
        - Provide a button at the top of PlayArea to let user generate a new block manually. If there are more than 5 blocks, this generation will not trigger.
        - Again, make sure you don't hard code these limits. Keep them in config file.
    - Currently, if a block is wrongly slashed, the color should change, not keeping brown. Choose some color suitable. Fix the bug:
        - First, as basic number block already has the wooden color, whoever wrapping it should have a TRANSPARENT color
        - Second, for wrong block animation, the end color is set to red. (transparent -> red)
        - Make sure you overlay the color
        - Make sure I can really see the color if the animation is trigger.
        - Make sure correct / wrong block look same before slash.
    - Do not start game immediately after user Exit the Game Result Disalogue
        - Show the StartGame as the same as the page starts.



- Add my page (I am the author) into AboutDialog
    - https://linktr.ee/davidpangsw