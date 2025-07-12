## Phase06: GameWidget UI draft
- Let's create a folder `./lib/widgets/game_widget/` to contain our original GameWidget. In this folder, we have:
    - `GameWidget`, which we already created. We modify it to contains the widgets `StatsBar` and `PlayArea` below.
    - `StatsBar`, which contains the score, level, lives, divisor, etc. on the same row.
    - `PlayArea`, which is the main play area.
- The play area should be with fixed size compatible with most of the devices (mobiles and web). Details would be explained later. Make sure the width and height are fixed.

- Implement number block generation and animation in play area:
    a. The play area should have a maximum number of blocks allowed, configured at 1 now (in later phase we change it).
    b. If the maximum is not reached yet, generate a number block:
        - Initial position is at the bottom randomly from leftmost to rightmost.
        - Initial velocity is up, and also has a small horizontal component. The horizontal component ranges from left to right.
        - The initial speed should be large enough that the top edge of a block can reach at least the upper half of play area, and at most the top edge of the play area (randomize it).
        - Subject to a downward acceleration, just like gravity.
        - Bounce off the left/right edges of the PlayArea.
    c. If the whole number block drops below the bottom of play area, the animation is considered done. The block should disappear and be removed. Note: moving above the top is not considered disappeared. 

- The number blocks still have the hovering animation as before. If such hovering occurs:
    - The movement stopped immediately.
    - When the hovering animation is done, the block is considered removed.

- Make sure your solution is minimal.
