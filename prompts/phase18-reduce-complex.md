## Phase 18: Reduce complex code
- Create a class Rectangle (under utils) that represents a rectangle of given width and height
    - Make your usage in config file.

- Revamp PhysicsEngine
    - PhysicsEngine should not know anything about the Config.
    - Instead, the fixed parameters should be passed in constructor.
    - PlayArea owns a PhysicsEngine.
    - The parameters include: (Rectangle playAreaRectangle, Rectangle blockRectangle, bounce damping).
    - PhysicsEngine should be under utils
    - shouldRemoveBlock should not be a method under physics Engine
    - It also should not have delta time as static variable. It is a parameter passed into methods.

- Create a class GameLevel, under config
    - From now on, do not store game level config in config.dart. Store them as static constant of GameLevel
    - The constructor should be private.
    - A GameLevel has all the parameters about a game level:
        - tier (Make it an enum, with string name and string emoji)
        - divisor
        - number range
        - gravity
        - Number of block required / block limit
        - min/max velocity
        - other parameters may apply (I forget)
    - Contains some methods that are extremely clear:
        - toDisplayString() => "$tierEmoji $divisor"
    - It has a static constant of all levels. from easiest to hardest.
        - Do not create static constants for each level. Just one list is okay.
        - Order, number of levels, ... is determined by the index and size of list.
    - Config has some useless methods like getLevel tier, get level divisor... these are useless now. Delete them all. Either make use of GameLevel properly, or add some static helper in GameLevel

