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
