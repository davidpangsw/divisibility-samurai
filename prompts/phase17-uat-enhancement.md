## Phase17: UAT enhancement
- UI/UX
    - Do not show "Level" in statsbar, instead, Show Tier and Divisor seperately
    - Sometimes the page still showing "math_game" "Flutter project". This is so ugly. Where is the problem
    - The buttons at the top (Game rule, about, settings) have only icons. This is not clear. Should also show some text.
        - Make sure the help button is also with text "Help" clear shown (not block by others)
        - Move all the buttons to the right. the order from l to right is Help, Settings, About.
    - In statsbar, the block limit and block to go is not clear. Stats bar splits into two columns. Needed blocks and correct block left should moved to right hand side.
        - Blocks to slash: X
        - Correct Block Left: Y
    - The transition scene between levels are tototal wrong. Let's revamp:
        - Transition scene is supposed to be shown BEFORE every level starts. Not after. Currently, some cases like after campfire don't do it properly.
        - It should clearly show:
            i. The tier emoji of the coming level, following the text of the tier
            ii. The divisor of the coming level, displayed in a number block (good now). Following the text "Divisior: "
        - Make sure the BasicNumberBlock of transition scene is CORRECTLY SHOWING the upcoming divisor


- The page loading is very very slow. Show a circle before loading done. Also, apply some lazy loading if possible. (If not, that's fine)
