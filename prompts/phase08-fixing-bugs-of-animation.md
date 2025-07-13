## Phase08: Fixing bugs of animation
Before you fix the bugs, let's refactor some bad design first.
- Physics engine should not have knowledge about Animated number block. Let's fix it:
    - In utils, create a class Vector that is just a tuple of (x, y). It can represent either position or velocity, and basic operations like addition, subtractions, or scalar multiplication (depends on our needs)
    - physics engine should not accept a list of AnimatedNumberBlock. Instead, it should accept position and acceleration, and return new position and acceleration.
    - the for loop should the concerns of the caller. Physics engine only deal with one block.

- Your block removal sounds very complicated. Let me explain my view and see if it works for you:
    1. If a block is hovered or fell off screen, mark it "removed" immediately.
    2. If it is removed due to "hovered", perform animation
    3. If a block is removed. No more interactions and motions are there. The block is immediately removed from the block list in the game (though you may need to perform an animation)



- Currently, there are some bugs in the animation in play area. Some bugs happen quite randomly, go through the code and try to pin point the problem. Don't force yourself to change code -- if you can't find it, just say you can't find.
    1. Sometimes, a block suddenly disappears in the middle of motion. It seems being affected by slashing of other blocks. Make sure the slashing of blocks don't affect each other. If it is already fixed, proceed.
    2. A block is supposed to be slashed ONCE only. But it turns out we can slash a block multiple times. If it is already fixed, proceed.
    3. Sometimes, no more blocks appear. If it is already fixed, proceed.
    4. It seems like you haven't set the key of positioned to preserve the identity.

