This file will house all of the functions to do with input that will be run through the game loop.

> module CurryDog.Input
> where
> import Graphics.UI.SDL as SDL

> checkEvent :: [SDLKey] -> Event -> [SDLKey]
> checkEvent pressed_keys ( KeyDown ( Keysym key _ _ ) ) = key:pressed_keys
> checkEvent pressed_keys ( KeyUp   ( Keysym key _ _ ) ) = filter (/=key) pressed_keys