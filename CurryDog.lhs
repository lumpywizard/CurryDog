This file is a skeleton.

TODO CurryDog.lhs:
1. Fix gameLoop.
2. gameLoop function injection, so CurryDog user can easily insert their own function into the game loop.
3. Timer.

> module CurryDog
> where
> import CurryDog.Data as CurryDog
> import CurryDog.Input as CurryDog
> import Graphics.UI.SDL as SDL

> runGame = do SDL.init [SDL.InitEverything]
>              SDL.setVideoMode 1280 720 32 [SWSurface]
>              SDL.setCaption "Game" "Game"
>              --gameLoop False []
>              SDL.quit
>           {-where
>              gameLoop quitFired pressed_keys = SDL.waitEventBlocking >>= do
>                                                                      let keys = (\ event ->  event )
>                                                                      if quitFired then
>                                                                         return
>                                                                      else
>                                                                         gameLoop False keys
>                                                                         return -}