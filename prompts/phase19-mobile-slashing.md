## Phase 19: Mobile-slashing
Currently, the slashing in mobile is bug and you can't even understand it. I will guide you.
- First, let's remove all the mouse/region/touch/hover/movement trigger or gesture in NumberBlockAnimation. Let's pretend we haven't implemented any event trigger.
    - The trigger will be outside. (PlayArea will trigger the animation later)

- Create a class BlockArea (that will seperate some concerns of PlayArea):
    - It is a rectangular fixed area that detects mouse/pointer movement.
        - If the mouse/pointer (pressed or not) hovers a block, a slash is triggered.
    - It stores all the blocks inside, with their position, such that it can check collision and call corresponding triggers.
    - It does not create/update/remove the blocks by itself. But it provides direct method to do these things (to manage the blocks)
    - In help dialogue, use one block area to contain the examples.
    - Do not update PlayArea yet.

