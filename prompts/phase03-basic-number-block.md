## Phase 3: BasicNumberBlock in HelpDialog Example section; line utilities
In Phase 3, we will implement the number block and add it to the example section of the help dialog.
1. Implement the number block under `lib/widgets/number_blocks/`:
    a. BasicNumberBlock: It is a rectangular block that contains a number on it. The color, the fonts, etc. DO NOT implement any SIZE here. It is just a block of number.
2. Show examples using several NumberBlock in HelpDialog Example section, use a fixed-size widget to contain the number block for now. We will talk about the wrapping widget later.

3. `lib/utils/line.dart`, Line: It is an utility class that represents a line. (Preparation for the later phases)
    a. `Line(x1, y1, x2, y2)`: Constructor with starting and ending points
    b. `Line.randomSlashing(width, height)`: Given the width and height of a rectangle
        i. It randomly selects one of the four corners of it.
        ii. It then randomly selects the starting point around that corner. The point must be at the edge (Not inside the box), but it can be as far as in the middle of an edge. Not necessarily very close to the corner. This point is x1, y1.
        iii. It also note the opposite corner of the selected corner. Topleft is opposite to bottomright, topright is opposite to bottomleft.
        iv. Then it randomly selects the end point around the opposite corner. The point must be at the edge (Not inside the box), but it can be as far as in the middle of an edge. Not necessarily very close to the corner. This point is x2, y2. 
        v. Returns a new line. 
    c. `(x1, y1) evaluate(t)`: Given a parameter t, it returns the point on the line at that parameter. t is between 0 and 1.
