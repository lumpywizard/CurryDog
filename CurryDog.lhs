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

> runGame :: IO ()
> runGame = do SDL.init [SDL.InitEverything]
>              SDL.setVideoMode 1280 720 32 [SWSurface]
>              gameLoop NodeList "GameState" [ BoolLeaf   "quit_game"    False
>                                            , NodeList   "pressed_keys" []
>                                            , StringLeaf "Caption"      "Game"
>                                            ]
>              SDL.quit
>           where
>              gameLoop gamestate = SDL.waitEventBlocking >>= do keys <- checkKeys --This is broken.
>                                                                if (leafBool $ head $ namedProperties "quit_game" $ nodeList gamestate) then
>                                                                   return
>                                                                else
>                                                                   gameLoop gamestate
>                                                                   return