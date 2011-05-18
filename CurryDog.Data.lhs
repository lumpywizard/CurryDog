This file will house most of the important data structures. Defined first are Graphical structures.

> module CurryDog.Data ( Vector, vectorX, vectorY, vectorZ, Color, colorRed, colorGreen, colorBlue, colorAlpha )
> where

> import Data.Word ( Word8 )

A Vector is the main unit of 2d and 3d games. So here, we're defining a vector as either a 2d or 3d vector.

> data Vector = Vector2 Float Float
>             | Vector3 Float Float Float
>             deriving ( Show )

> vectorX :: Vector -> Float
> vectorX (  Vector2 x _   ) = x
> vectorX (  Vector3 x _ _ ) = x

> vectorY :: Vector -> Float
> vectorY (  Vector2 _ y   ) = y
> vectorY (  Vector3 _ y _ ) = y

> vectorZ :: Vector -> Float
> vectorZ (  Vector2   _ _   ) = error "Vector2 does not have a Z"
> vectorZ (  Vector3   _ _ z ) = z

Color is defined as ColorRGB, ColorRGBA, ColorBGR, ColorABGR

> data Color = ColorRGB  Word8 Word8 Word8
>            | ColorRGBA Word8 Word8 Word8 Word8
>            | ColorBGR  Word8 Word8 Word8
>            | ColorABGR Word8 Word8 Word8 Word8
>            deriving ( Show )
 
> colorRed   :: Color -> Word8
> colorRed   ( ColorRGB  r _ _   ) = r
> colorRed   ( ColorRGBA r _ _ _ ) = r
> colorRed   ( ColorBGR  _ _ r   ) = r
> colorRed   ( ColorABGR _ _ _ r ) = r

> colorGreen :: Color -> Word8
> colorGreen ( ColorRGB  _ g _   ) = g
> colorGreen ( ColorRGBA _ g _ _ ) = g
> colorGreen ( ColorBGR  _ g _   ) = g
> colorGreen ( ColorABGR _ _ g _ ) = g

> colorBlue  :: Color -> Word8
> colorBlue  ( ColorRGB  _ _ b   ) = b
> colorBlue  ( ColorRGBA _ _ b _ ) = b
> colorBlue  ( ColorBGR  b _ _   ) = b
> colorBlue  ( ColorABGR _ b _ _ ) = b

> colorAlpha :: Color -> Word8
> colorAlpha ( ColorRGB  _ _ _   ) = 255
> colorAlpha ( ColorRGBA _ _ _ a ) = a
> colorAlpha ( ColorBGR  _ _ _   ) = 255
> colorAlpha ( ColorABGR a _ _ _ ) = a

> data Pixel = Pixel Vector Color deriving ( Show )
> type Image = [Pixel]
