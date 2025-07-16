## Phase20: Decoration
- BasicNumberBlock texture
    - I want it look like a wood.

- Asset config
    - under configs, add a class to store the path / list of path and of all our assets
    - It should be a map. 
        - <direct parent folder> -> <list of files>
    - The direct parent folder serves an "id", because when we want a file, we access that "id" and randomly choose a file from the list.
        - Implement this in config.
        - This id may be coded as static constants here.

- Custom Asset Manager
    - Isolate a class for assessing Assets
    - The asset system of flutter is so buggy, also with assets/assets/ and inconsistent between local and build.
    - This class is purely for fixing the problem of flutter stupid file system.
    - getRandomAsset(string id) // get a random file from a path
    - We will use getRandomAsset(...) almost all the time. Don't allow caller the get asset file direct from a path

- PlayArea Background (watermark feeling)
    - I already downloaded the background of widget for each tier. (Under ./assets/images)
    - Make sure you don't hard code the path:
        - for example, study tier should randomly choose one picture from study-background/
        - The path is set in config.
        - If the picture is too large, scale and trim the excess.
        - Make sure no widget will block the background
        - The background should be a watermark with very high transparency, to make sure it doesn't affect the game.
        - Make sure it works on both local and web browser. The `assets/assets/` bug is always annoying.

-  Can you read through the whole lib/ and see any things you can improve? Aim for refactoring and reducing code

- Samurai picture
    - I added several picture. Include them into assets. (Also attributions, don't forget)
    - Also, make the samurai picture widget bigger (because I added some larger assets)