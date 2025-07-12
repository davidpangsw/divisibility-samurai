## Phase 5: Animation of NumberBlock
In this phase, we need to implement the animation of NumberBlock.
1. Edit NumberBlock.dart
    b. NumberBlockAnimation is replaced by CorrectNumberBlockAnimation and WrongNumberBlockAnimation, depending on the isCorrect parameter.
    c. NumberBlock, no matter correct or wrong, should be blue.
    d. DO NOT do other things in NumberBlock.

2. Go to the internet to make sure you know the latest way to write an Animation. Do not learn outdated / wrong things.

3. `.../number_blocks/NumberBlockAnimation.dart`: Provides a base class for the correct and wrong number block animation.
    a. The child is supplied to the constructor, and is wrapped.
    b. It consists of a 400ms controller, that will animate two tween: one is determined by the child class, last for 100ms. The other is a fade out animation, last for 300ms.
    c. When the child is hovered, the animation is triggered once. DO NOT reset after animation.
    d. DO NOT do other things in the animation.
    e. SingleTickerProviderStateMixin may not be enough for your task. You may need to use TickerProviderStateMixin.
    

4. `.../number_blocks/WrongNumberBlockAnimation.dart` extends NumberBlockAnimation.
    a. The change in NumberBlock should be from minimal to none.
    b. Keep the Animation file as simple as possible.
    c. The animation is like this:
        i. start color and end color are also supplied in the constructor.
        ii. The animation starts from the start color (would be supplied as blue)
        iii. The animation ends at end color (would be supplied as red, NOT green).
        iv. The above animation is 100ms, followed by another 300ms animation that the opacity changes from 1 to 0. (Already set in the superclass)
            
5. `.../number_blocks/CorrectNumberBlockAnimation.dart` extends NumberBlockAnimation.
    a. The change in NumberBlock should be from minimal to none.
    b. Keep the Animation file as simple as possible.
    c. This animation is like this:
        i. We want to animate the "slashing" of a child. The child is supposed to already have fixed height and width, like SizedBox
        ii. In constructor, given the width and height of the child, it calculates the Line using Line.randomSlashing(width, height).
        iii. During the animation, it animates the line from start to end point. (duration as a static final variable). Partial of the line, evaluated by Line class, is drawn until complete.
        iv. The above animation is 100ms, followed by another 300ms animation that the opacity (of the block and the line) changes from 1 to 0.