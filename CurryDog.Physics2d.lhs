This file will house all the 2D physics functions that don't fit into a general purpose.

> module CurryDog.Physics2d
> where

> import CurryDog.Data as CurryDog

> boundingShapeCollision :: Shape -> Shape -> Bool
> boundingShapeCollision ( Rectangle x1 y1 w1 h1 ) ( Rectangle x2 y2 w2 h2 ) = x1 <= ( x2 + w2 ) && x2 <= ( x1 + w1 )
>                                                                      && y1 <= ( y2 + h2 ) && x2 <= ( x1 + h1 )
> boundingShapeCollision ( Circle cX1 cY1 d1 ) ( Circle cX2 cY2 d2 ) = False -- TODO
> boundingShapeCollision ( Circle cX1 cY1 d1 ) ( Rectangle x2 y2 w2 h2 ) = False -- TODO