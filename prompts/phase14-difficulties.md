## Phase14: Difficulties and Hints; fixing bgm; start/stop; game result revamp
- Currently, the game maybe is too hard, and too few time for player to apply what they've learnt.
    - Reduce gravity to 200.
    - Adjust initial veritical velocity properly (still reaches 50%~80% of the height)
    - Show 2 blocks at max on the play area


- Need to introduce new Hint Card
    - Rename previous hint cards to DivisorHintCard. Remember also changes the filename correspondingly.
    - Add a hint card about "Necessary conditions"
        - Hint the player that, they can also derive ways to determine NOT to slash (some "necessary condition")
        - For example, if a number is divisible 4, it must necessary be an even number. An odd number cannot be divided by 4 and 8.
    - Add a hint card about "Partitioning method" (There maybe a proper name, you may look for it)
        - Partitioning method: Split a number x into block of numbers, if each block is divisible by d, then x is divisible by d
        - Example: 1236 = 12 and 36 (don't use "+" to mean "and")
        - Why this works:
            - Take 3|1236 
            - 1236 = 12*100 + 36, and 3 divides 12 and 36, which means we take out the contents 3 by 3 (we call it mod), no remainder is left
        - Note that the converse is not true: 1335 cannot be splitted into two parts divisible by 3. But it is still divisible.
        - Since this hint card is advanced, and should be below the divisor hints.

- Set a block limit. If player cannot proceed to next level before certain number of CORRECT blocks disappeared, lose!
    - Bronze: 5 correct blocks before 30 correct blocks disappear
    - Silver: 5 correct blocks before 30 correct blocks disappear, gravity is now 150
    - Gold: 5 correct blocks before 30 correct blocks disappear, gravity is now 100
    - Make sure you show the remaining counts in Stats bar
    - Note that in different tier, you need to adjust initial veritical velocity properly (still reaches 50%~80% of the height)

- Game Result Revamp
    - Win or lose title just as same as now.
    - Button Section:
        - No headings, just two buttons
        - First button is "Play Again"
        - Second button is "Save Image". The saveed file name should be timestamped util seconds
        - Make sure Save Image correct save the game result we are going to correct here
    - Stats Section:
        - Score
        - Total blocks missed
        - Last level "[Bronze emoji]2" for example, always use a emoji for tiers!!
    - Correct Answers Section
        - As there could be many, just write them as symbols. For example "[Bronze emoji]2 | 12,24,16,20,30" in the line of Bronze 2. The correct answer section doesn't need to be scrollable
    - Wrong Answers Section
        - Similar as Correct Answers Section, use the "does not divide" symbol I provided before.
    - Make the Game Result Dialog Scrollable

- The sound starts with 50% and bgm  starts with 25%. Persist between browsing (like storing in cookies, whatever)

- Fix the bug of bgm. Sometimes it doesn't play, sometimes it plays multiple.

- Stop playing music when the game ends
- Start playing music when the game starts, not when the player slashes.
- Don't start game automatically. Provide a button to start.

- Display divisor in stats bar. Format: Just a simple text row "Divisor: 2" Below level. no need fancy.
    - Keep the level text as "[Tier emoji]$divisor" in all places through the webpage