## Phase 1: Layout
In Phase 1, we will display the homepage with some basic widgets.

1. Create a config file `lib/configs/config.dart` to store all the configurable parameters.
2. Implement the necessary widgets under the folder `lib/widgets`. Each widget is responsible for rendering a specific part of the UI.
    a. Homepage: The homepage of the game. It contains the game title, the HelpButton, and the GameWidget.
    b. HelpButton: Just include a help button with no effect. The help button would be at the top left of the homepage, with a "help" icon. Explained later.
    c. GameWidget: The widget that contains the game. It should takes all the remaining space of the screen. For now, just implement it with a placeholder with a proper border. I will explain later.
3. For now, do not implement the game yet.
4. Remember to implement your `main.dart` to display the homepage.
