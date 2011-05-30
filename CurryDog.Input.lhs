This file will house all of the functions to do with input that will be run through the game loop.

> module CurryDog.Input
> where
> import CurryDog.Data as CurryDog
> import Graphics.UI.SDL as SDL

> checkEvent :: Event -> PropertyTree -> PropertyTree
> checkEvent ( KeyDown ( Keysym key _ _ ) ) gamestate = insertIntoNode ["pressedkeys"] (KeyLeaf (show key) key) gamestate
> checkEvent ( KeyUp   ( Keysym key _ _ ) ) gamestate = removeFromNode ["pressedkeys"] (show key) gamestate