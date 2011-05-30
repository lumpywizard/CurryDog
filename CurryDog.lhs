TODO CurryDog.lhs:
1. gameLoop function injector. Needs to use the gamestate nodelist base with a FunctionLeaf called userfunction.
2. Timer.

> module CurryDog
> where
> import CurryDog.Data as CurryDog
> import CurryDog.Input as CurryDog
> import Graphics.UI.SDL as SDL

> runGame :: Maybe PropertyTree -> IO ()
> runGame gamestate = do SDL.init [SDL.InitEverything]
>                        SDL.setVideoMode 1280 720 32 [SWSurface]
>                        SDL.quit
>                        where
>                            gameLoop gamestate = SDL.waitEventBlocking >>= (\ event -> return $ checkEvent event gamestate )