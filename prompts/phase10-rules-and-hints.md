## Phase 10: Rules and Hints.
Now, the game works as expected. I want to remedy some game explanations, and add hints.
- In HelpDialog:
    - As users always know the number of lives during the game, we don't need to tell them here.
    - We don't need to tell users how many blocks will be on screen.
    - Add a "Hint" Section, in this section, briefly describe how to determine a number is divisible by 2, 3, 4, 5, 6, 8, 9, 10 and 12:
        - 2: ends with 02468. Reason: x = 10a+b, 2|10
        - 3: add the digits, divisible by 3. Reason: x = a + 10b + 100c + ... = (a + b + c + ...) + (9b + 99c + ...), where the second bracket is divisible by 3
        - 4: last 2 digits divisible by 4. Reason: x = 100a+b, 4|100
        - 5: ends with 05. Reason: x = 10a+b, 5|10
        - 6: Check the conditions for both 2 and 3. Reason: gcd(2,3) = 1 and 2*3 = 6
        - 8: last 3 digits divisible by 8. Reason: x = 1000a+b, 8|1000
        - 9: add the digits, divisible by 9. Reason: x = a + 10b + 100c + ... = (a + b + c + ...) + (9b + 99c + ...), where the second bracket is divisible by 9.
        - 10: ends with 0, Reason: x = 10a+b
        - 12: Check the conditions for both 3 and 4. Reason: gcd(3, 4) = 1 and 3*4 = 12
    - Hint section should explain as clear and brief as possible, with visualized explanations.
    - Format (For each divisor Card):
        - Present two examples, one divisible, another not.
        - Write in green with a tick in divisible example; red with a cross in non-divisible example. tick and cross should be at the end.
        - The math format and notations should be clear:
            - Don't use comma.
            - Don't use single arrow (unless you really are describing a function, which is impossible here).
            - Use math symbol "|", "∤" to mean divides/ not divides
            - Use a double arrow to mean "thus" / "implies"
            - Use "and" means "and"
        - Bottom of each Card, explain the reason why the hint works. I already provide the reasons above. But make them english and readable.

- Create a folder `./lib/widgets/help_dialog/`
    - Move our original help_dialog.dart inside.
    - Extract out the HintCard as a seperate file and class.
    - Extract out the HintCardSection as a seperate file and class.
    - Extract out the ExampleSection as a seperate file and class.
    - Extract out the GameRuleSection as a seperate file and class.

- Make sure you each section headings shares the same font style.