## Phase 19: Mobile-slashing
Currently, the slashing in mobile is bug and you can't even understand it. I will guide you.
- First, let's remove all the mouse/region/touch/hover/movement trigger or gesture in NumberBlockAnimation. Let's pretend we haven't implemented any event trigger.
    - The trigger will be outside. (BlockArea will trigger the animation later)

- AnimatedNumberBlock
    - Add a method bool isContain(Offset offset) to return if the block contains that offset.

- Create a class BlockArea (that will seperate some concerns of PlayArea):
    - It is a rectangular fixed area that detects mouse/pointer movement.
        - If the mouse/pointer (pressed or not) hovers a block, a slash is triggered.
    - It stores all the blocks inside, with their position, such that it can check collision and call corresponding triggers.
    - It does not create/update/remove the blocks by itself. But it provides direct method to do these things (to manage the blocks)
    - It also allows to apply gravities based on our physics engine. However, it is not a must. The will be a field in constructor to tell if it applies.
    - In help dialogue, use one block area to contain the examples.
        - (The tick and cross below will not be aligned. If you can fix it, fix. If not, just remove them)
    - Do not update PlayArea yet.

- Now, edit PlayArea to make use of BlockArea.
    - what does "hasBeenCounted" mean? this is a useless flag (duplicated with isRemoved)
    - The code is so confusing, can you simplify it? Or add comments to explain how these boolean flags work, as they are very confusing.
    - Fix your bugs introduced after your edit..

- Physics Engine
    - Instead of passing gravity everytime, make a field in constructor.
    - Also, provide a setter such that, whenever we need to change the gravity, we just set it to need value.