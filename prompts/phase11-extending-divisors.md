## Phase 11: Extending divisors and levels; Small changes in HelpDialog and StatsBar; Picture taking in GameResultDialog
Currently, we only allow divisors 2,3,4,5,6, extend the game to have 2,3,4,5,6,8,9,10,12. Also, I am going to reformat the levels:
- Bronze levels (2 digit numbers)
- Silver levels (3 digit numbers)
- Gold levels (4 digit numbers)
Each of them consist of all divisors above.

- While user waiting for the next level, also display the next level's
    - Bronze/Silver/Gold
    - Divisor, displayed in a big red BasicNumberBlock (NOT Number block!! Basic Number Block has no animation)
        - Remember to fix the size of BasicNumberBlock properly
    - If Lives refilled, tell "Lives Refilled"
    - Keep the information display as simple as possible. Use icons or emoji if possible. Remember, user has very few time to read it.

- Deduct scores if player slashes a wrong answer.
- Refill lives when player process to silver or gold.
- In the level in the stats bar, bronze/silver/gold is also shown (use proper emoji or icon)
- In HelpDialog
    - Mention the live refill
    - Do not mention about the level structure (too long, nobody reads)
    - Don't need to explain the physics-based!
    - Keep the game rule small and precise, only describe what user actually HAVE to know and CANNOT know without reading.
        - They don't need to know how many block to slash, they have to slash anyway
        - They don't care about points. Only mention they lose lives if incorrect.

- In StatsBar
    - Display the number of lives in hearts symbol. For example, Use 10 heart emojis to represent 10 lives.
    - Make the stats bar a column of fields. The text are left-aligned to avoid movement.
    - Level is displayed as "Level: (Tier symbol) (Level divisor)
    - No need to display divisior. It is already in the "level"
    - Has the same width as PlayArea

- PlayArea
    - Make it 480x480
    - The blocks suppose to reach 40% to 80% of the height

- Game widget should layout the child starting from the top. Not middle. It should be scrollable if total height of children exceeded.

- Add a button in GameResultDialog:
    - When use click this button, a simple image of the game result is generated to allow user to save it to their computer. (User chooses the location)
    