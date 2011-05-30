This file is currently only a placeholder.

TODO ExampleGameBase.lhs:
1. Instead of the window flashing away, it would be nice if it stayed open, fixing CurryDog.gameLoop should do.

> module Main
> where
> import CurryDog as CurryDog
> import CurryDog.Data as CurryDog
> import CurryDog.Input as CurryDog
> import CurryDog.Physics2d as CurryDog

> myFunc :: PropertyTree -> PropertyTree
> myFunc x = x

> main :: IO ()
> main = runGame (Just $ NodeList "gamestate" [ BoolLeaf "quitgame" False
>                                             , CurryDog.NodeList "pressedkeys" []
>                                             , CurryDog.FunctionLeaf "userfunction" myFunc ])