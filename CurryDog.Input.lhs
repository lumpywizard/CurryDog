This file will house all of the functions to do with input that will be run through the game loop.

> module CurryDog.Input
> where
> import Graphics.UI.SDL as SDL

checkEvent takes and returns a [SDLKey]. It represents all the keys that are currently pressed.
> checkEvent :: Event -> [SDLKey] -> [SDLKey]
> checkEvent ( KeyDown ( Keysym key _ _ )) registeredKeys = registerKey   registeredKeys key
> checkEvent ( KeyUp   ( Keysym key _ _ )) registeredKeys = deregisterKey registeredKeys key

Add a key to the registered keys.
> registerKey   :: [SDLKey] -> SDLKey -> [SDLKey]
> registerKey   keys key = keys ++ [key]

Remove a key from the registered keys.
> deregisterKey :: [SDLKey] -> SDLKey -> [SDLKey]
> deregisterKey keys key = filter (/=key) keys
