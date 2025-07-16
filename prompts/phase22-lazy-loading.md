## Phase22: Asset loading
- Currently, if the network is slow, the webpage loads EXTREMELY slow. This is very bad UX. Let change the loading:
    - AssetManager
        - Add a static method `preloadImages() async` to preload all images
        - Add a static method `preloadSoundEffects() async` to preload all sound effects (except music)
        - Add a static method `preloadSoundMusics() async` to preload all music
        - Sound manager should not handle assets preloading. but it handles sound playing or volume control.

    - Use NativeSplash
        - Serve one samurai images.
        - Serve a spinning circle. Make sure it is cleaned after loading.
        - Preserve until `await preloadImagesAndSounds()`
    
    - when initialize the app, also `preloadSoundMusics()` without await just before you remove splash. musics are loaded in the order of study -> bronze -> silver -> gold
        - Music plays whenever suitable and loaded

    
    - SoundManager
        - This file is too huge, and some methods should be in AssetManager.
        - It shouldn't know there are multiple or one sound file. It is handled in AssetManager. It just require the path or file from AssetManager! (Using folder path as some kind of "id")
        - campfire is not a tier
        - If you want to convert string to a tier, write that logic in tier.


- Note: Claude is really bad at writing the FlutterNativeSplash and initializeApp(). I don't know why. So I search for my answers, and provide the code here:
```dart

void main() async {
  var binding = WidgetsFlutterBinding.ensureInitialized();
  
  // Preserve native splash until assets are loaded
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  
  runApp(const MyApp());
}
// ...
  Future<void> _initializeApp() async {
    // ...
    try {
        // Preload images and sound effects first
        await AssetManager.preloadImages();
        await AssetManager.preloadSoundEffects();
        AssetManager.preloadSoundMusics();
        
        // Initialize sound manager
        await SoundManager.initialize();
        
    } finally {
        // Remove native splash now that critical assets are loaded
        FlutterNativeSplash.remove();
        if (mounted) {
            setState(() {
                _isLoading = false;
            });
        }
    }
    // ...
  }
// ...
```