## Phase 13: More sounds, contributions, settings to turn on/off
- Provide two more buttons to the top left:
    - button to open AboutDialog, explained below
    - button to open SettingsDialog, explained below

- AboutDialog: Include all the miscellous stuff.
    - Thanks for the sound from pixabay.com
        - Sound Effect by <a href="https://pixabay.com/users/freesound_community-46691455/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=36274">freesound_community</a> from <a href="https://pixabay.com//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=36274">Pixabay</a>
        - Music by <a href="https://pixabay.com/users/ulhassan123-24977311/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=309756">Naveed Ul hassan</a> from <a href="https://pixabay.com//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=309756">Pixabay</a>
        - Music by <a href="https://pixabay.com/users/hitslab-47305729/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=272176">Ievgen Poltavskyi</a> from <a href="https://pixabay.com/music//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=272176">Pixabay</a>
        - Music by <a href="https://pixabay.com/users/sigmamusicart-36860929/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=368633">Mikhail Smusev</a> from <a href="https://pixabay.com//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=368633">Pixabay</a>
    - Other stuff will be added later

- SettingsDialog: Settings for user to configure.
    - BGM volume: Default 50%
    - SFX volume: Default 50%
    - Other stuff will be added later

- update the configuration of path to play slash sound effect using the file.in assets/sounds/effects/slash/
    - choose whatever file inside. If multiple files, randomly select one each time.

- play bronze-bgm/*.mp3 silver-bgm/*.mp3 gold-bgm/*.mp3 as BGM in corresponding levels. The bgm is repeating forever.
    - choose one of the file under each folder. If there are multiple, randomly select one.

- Make sure the BGM and sound effects are played correctly.
- Make sure the volume state is implemented correctly.