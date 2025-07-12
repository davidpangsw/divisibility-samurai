## Phase 4: Number Block and preparation for animation
1. NumberBlock: Create a new widget under `lib/widgets/number_blocks/number_block.dart`.
    a. Wrap each BasicNumberBlock with a SizedBox. Ensure the width and height are fixed properly.
    b. Wrap the SizedBox with animation, that applies ONCE ONLY when the SizedBox is hovered. The animation won't reset.
    c. The details of the animation will be described later. Just write a empty or simple Animation inside `lib/widgets/number_blocks/number_block_animation.dart`.
    d. All NumberBlocks should appear the same except for the number.
    e. DO NOT do other things in NumberBlock. (Do not add useless or stupid fields. Do not change the color of number blocks, do not do any stupid things)

2. BasicNumberBlock and HelpDialog
    a. Remove the padding EdgeInsets and rounded corner of BasicNumberBlock.
    b. Remove the color of BasicNumberBlock.
    c. In HelpDialog:
        i. Replace BasicNumberBlock by NumberBlock
        ii. Only use divisor=3 as examples. Some blocks should be divisible while some are not. (Do not split by divisors, this sounds very stupid. Just one divisor with several examples)
    d. DO NOT change other things in BasicNumberBlock
    e. Review HelpDialog. Remove repeated code or explanation or headings. Keep it as small as possible

3. `lib/util/line.dart`, Line: It is an utility class that represents a line. (Preparation for the next phase)
    a. `Line(x1, y1, x2, y2)`: Constructor with starting and ending points
    b. `Line.randomSlashing(width, height)`: Given the width and height of a rectangle
        i. It randomly selects one of the four corners of it.
        ii. It then randomly selects the starting point around that corner. The point must be at the edge (Not inside the box), but it can be as far as in the middle of an edge. Not necessarily very close to the corner. This point is x1, y1.
        iii. It also note the opposite corner of the selected corner. Topleft is opposite to bottomright, topright is opposite to bottomleft.
        iv. Then it randomly selects the end point around the opposite corner. The point must be at the edge (Not inside the box), but it can be as far as in the middle of an edge. Not necessarily very close to the corner. This point is x2, y2. 
        v. Returns a new line. 
    c. `(x1, y1) evaluate(t)`: Given a parameter t, it returns the point on the line at that parameter. t is between 0 and 1.

4. Make HelpDialog more simple
    - Only contain examples of divisor 3
    - Game rule more simple
    - Remove repeated code or explanation or headings