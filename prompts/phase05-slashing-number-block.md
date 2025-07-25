## Phase 5: Animation of NumberBlock
In this phase, we need to implement the animation of NumberBlock.
1. Edit NumberBlock.dart
    b. NumberBlockAnimation is replaced by CorrectNumberBlockAnimation and WrongNumberBlockAnimation, depending on the isCorrect parameter.
    d. DO NOT do other things in NumberBlock. The color, size, and other things should appear the same before animation.

2. `.../number_blocks/NumberBlockAnimation.dart`: Provides a base class for the correct and wrong number block animation.
    a. A child widget is supplied to the constructor, and is wrapped.
    b. It consists of a 400ms controller, that will animate two tween: one is determined by the child class, last for 100ms. The other is a fade out animation, last for 300ms.
    c. When the child is hovered, the animation is triggered once. DO NOT reset after animation.
    d. DO NOT do other things in the animation.
    e. SingleTickerProviderStateMixin may not be enough for your task. You may need to use TickerProviderStateMixin. But you should think it yourself.

4. `.../number_blocks/WrongNumberBlockAnimation.dart` extends NumberBlockAnimation.
    a. The change in NumberBlock should be from minimal to none.
    b. Keep the Animation file as simple as possible.
    c. The animation is like this:
        i. start color and end color are also supplied in the constructor.
        ii. The animation starts from the start color (would be supplied as blue)
        iii. The animation ends at end color (would be supplied as red in parent).
        iv. The above animation is 100ms
        v. followed by another 300ms animation that the opacity changes from 1 to 0. (Already set in the superclass)
            
5. `.../number_blocks/CorrectNumberBlockAnimation.dart` extends NumberBlockAnimation.
    a. The change in NumberBlock should be from minimal to none.
    b. Keep the Animation file as simple as possible.
    c. This animation is like this:
        i. We want to animate the "slashing" of a child. The child is supposed to already have fixed height and width, like SizedBox
        ii. In constructor, given the width and height of the child, it calculates the Line using Line.randomSlashing(width, height).
        iii. During the animation, it animates the line from start to end point. (duration as a static final variable). Partial of the line, evaluated by Line class, is drawn until complete. The line must be shown in foreground.
        iv. The above animation is 100ms
        v. followed by another 300ms animation that the opacity (of the block and the line) changes from 1 to 0.

6. Check carefully (if wrong, fix):
    - The line should start and end in opposite corners, top-left is opposite to bottom-right, top-right is opposite to bottom-left. Other pairs are not considered opposite
    - The color change in wrong number should ends with RED color. Make sure it is not overriden or something. Remember, basic number block should have no color.