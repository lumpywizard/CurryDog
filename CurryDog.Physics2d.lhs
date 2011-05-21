This file will house all the 2D physics functions that don't fit into a general purpose.

> module CurryDog.Physics2d
> where

> import Graphics.UI.SDL as SDL
> import CurryDog.Data as CurryDog

> data Frame = Frame { surface :: SDL.Surface
>                    , boundingBoxes :: [(String,SDL.Rect)]
>                    }

> boundingBoxCollision :: SDL.Rect -> SDL.Rect -> Bool
> boundingBoxCollision (SDL.Rect x1 y1 w1 h1) (SDL.Rect x2 y2 w2 h2) = x1 <= (x2+ w2) && x2 <= (x1+w1)
>                                                                   && y1 <= (y2+h2)  && x2 <= (x1+h1)