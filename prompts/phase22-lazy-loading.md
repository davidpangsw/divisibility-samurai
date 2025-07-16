## Phase22: Lazy loading
- Currently, if the network is slow, the webpage loads EXTREMELY slow. This is very bad UX. Let change the loading:
    - Serve a spinning circle IMMEDIATELY when user access the page. No emoji! Just text.
    - Before serving the page, load all the images, pictures and sounds first. While loading, present a spinning circle. DO NOT LOAD ANY MUSIC
    - After all images are loaded, serve the page immediately, while simultaneously loads the music in background. In the order of study -> bronze -> silver -> gold
    - Music plays whenever suitable and loaded

- Tell me a way to test the webpage under slow network conditions.

- Flutter seems to load a lot of shits before giving a spinning circle. Is it unsolvable?