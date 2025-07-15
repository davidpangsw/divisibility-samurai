## Phase 99: Brain storming
- This file is just some brain storming. They are potential future features. Read it for reference only.


- Change background in different tiers? Make the feeling different?
- Use click to generate block?
- UI/UX
    - Tune the game to become additive

- Animation / Picture
    - Cat samurai anime after each tier done. (Use AI to generate)

    - Playing with Mobile Browser, slash a block when finger "enters" the block. Can be a tap or swipe. Not just tap.
        - When the pointer enters the block . No matter the pointer is pressing or not.

- Let's fix some dumb code in PlayArea.
    - what does "hasBeenCounted" mean? this is a useless flag (duplicated with isRemoved)
    - The code is so confusing, can you simplify it? Or add comments to explain how these boolean flags work, as they are very confusing
    - In mobile (using a browser), a player is also allowed to "slash" a block when the pointer is pressed and hover through a block. This is tricky because the block may not detect this event. (It is pressed in play area, and then hover the block). To make sure the animation is consistent with what happen in browser hovering:
        - Detect movement inside the PlayArea. Call methods of NumberBlockAnimation to trigger the anime.
        - That means, PlayArea must know the positions of all NumberBlocks. (And check collision)
        - In help dialogue, you may need to wrap the example with mouse region.
        - Fix your bugs introduced after your edit..
## Deployment
1. Our game is done. Do not edit any classes. Teach me how to deploy it into firebase. Just generate your answers and commands involved into the chat.

