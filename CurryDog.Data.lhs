    This file will house most of the important data structures.
    Defined first are Graphical structures.
    
> module CurryDog.Data
> where

> import Data.Word ( Word8 )
> import qualified Graphics.UI.SDL as SDL

    A Vector is the main unit of 2d and 3d games. So here, we're defining a
    vector as either a 2d or 3d vector.

> data Vector = Vector2 { vX :: Float, vY :: Float }
>             | Vector3 { vX :: Float, vY :: Float, vZ :: Float }
>             deriving ( Show )

    Color is defined as ColorRGB, ColorRGBA

> data Color = ColorRGB  { colorRed :: Word8, colorGreen :: Word8, colorBlue :: Word8 }
>            | ColorRGBA { colorRed :: Word8, colorGreen :: Word8, colorBlue :: Word8, colorAlpha :: Word8 }
>            deriving ( Show )

> data Pixel = Pixel Vector Color deriving ( Show )
> type Image = [Pixel]

> data Shape = Rectangle { rectangleX :: Float, rectangleY :: Float, rectangleWidth :: Float, rectangleHeight :: Float }
>            | Circle    { circleOriginX :: Float, circleOriginY :: Float, circleDiameter :: Float }
>            deriving ( Show )

> data Sprite = CollisionSprite { spriteSheet :: Image, collisionSpriteClips :: [(Shape,[Shape])] }
>             | ColorKeyedCollisionSprite { spriteSheet :: Image, collisionSpriteClips :: [(Shape,[Shape])], colorKey :: Color }
>             | PlainSprite { spriteSheet :: Image, spriteClips :: [Shape] }
>             | ColorKeyedPlainSprite { spriteSheet :: Image, spriteClips :: [Shape] }
>             deriving ( Show )

    A PropertyTree is an N-ary (n-way) data tree. All PropertyTree datatypes
    take a String (let's call it a Key) and a Value. The Value datatype a
    PropertyTree takes is dictated by name it's datatype. For example, an
    IntegerLeaf takes an Integer as a value. A VectorLeaf will take a
    Vector2 or Vector3. A NodeList will take a list of PropertyTrees as a
    value.

> example =  NodeList "GameState" [ NodeList "Character Sheet" [ StringLeaf  "Name"        "Rodger Dodger"
>                                                              , IntegerLeaf "Hit Points"  24
>                                                              , NodeList    "Class/Level" [ IntegerLeaf "Rogue"   1
>                                                                                          , IntegerLeaf "Fighter" 1 
>                                                                                          ]
>                                                              , NodeList        "ABILITY SCORES" [ IntegerLeaf "STR" 14
>                                                                                                 , IntegerLeaf "CON" 13
>                                                                                                 , IntegerLeaf "DEX" 18
>                                                                                                 , IntegerLeaf "INT" 10
>                                                                                                 , IntegerLeaf "WIS"  9
>                                                                                                 , IntegerLeaf "CHA" 16
>                                                                                                 ] ]
>                                 , VectorLeaf "Location" ( Vector2 0 0 )
>                                 ]

> abilityscores = traversePropertyTree ["Character Sheet","ABILITY SCORES"] example

> classlevels = traversePropertyTree ["Character Sheet", "Class/Level"] example

 location = leafVector $ head $ namedProperties "Location" $ nodeList example

    Add birdtracks to the above code to see it in action. In this example we
    have a GameState NodeList which houses all the game state variables in
    other PropertyTree's. In this nested NodeList we have a variety of data,
    such as Name, Hit Points, Class/Level, and ABILITY SCORES. On the same
    level as Character Sheet, we also have a Location, which is a VectorLeaf.

> data PropertyTree = BoolLeaf            String Bool
>                   | StringLeaf          String String
>                   | IntegerLeaf         String Integer
>                   | FloatLeaf           String Float
>                   | VectorLeaf          String Vector
>                   | NodeLeaf            String PropertyTree
>                   | ColorLeaf           String Color
>                   | ShapeLeaf           String Shape
>                   | SpriteLeaf          String Sprite
>                   | FunctionLeaf        String ( PropertyTree -> PropertyTree )
>                   | KeyLeaf             String SDL.SDLKey
>                   | NodeList            String [PropertyTree]

> instance Show PropertyTree where
>          show ( BoolLeaf a b )     = "BoolLeaf " ++ show a ++" " ++ show b
>          show ( StringLeaf a b )     = "StringLeaf " ++ show a ++" " ++ show b
>          show ( IntegerLeaf a b )     = "IntegerLeaf " ++ show a ++" " ++ show b
>          show ( FloatLeaf a b )     = "FloatLeaf " ++ show a ++" " ++ show b
>          show ( VectorLeaf a b )     = "VectorLeaf " ++ show a ++" " ++ show b
>          show ( NodeLeaf a b )     = "NodeLeaf " ++ show a ++" " ++ show b
>          show ( ColorLeaf a b )     = "ColorLeaf " ++ show a ++" " ++ show b
>          show ( ShapeLeaf a b )     = "ShapeLeaf " ++ show a ++" " ++ show b
>          show ( SpriteLeaf a b )     = "SpriteLeaf " ++ show a ++" " ++ show b
>          show ( FunctionLeaf a b ) = "FunctionLeaf " ++ show a ++ " (func :: PropertyTree -> PropertyTree)"
>          show ( KeyLeaf a b ) = "KeyLeaf " ++ a++ " " ++ show b
>          show ( NodeList a b )     = "NodeList " ++ show a ++" " ++ show b

    Getting a tree's name is akin to getting a hashkey from a hashtable entry.
    To extend storable types, simply add that type to the following 2 sections.

> leafName :: PropertyTree -> String
> leafName ( NodeList     name _ ) = name
> leafName ( BoolLeaf     name _ ) = name
> leafName ( StringLeaf   name _ ) = name
> leafName ( IntegerLeaf  name _ ) = name
> leafName ( FloatLeaf    name _ ) = name
> leafName ( VectorLeaf   name _ ) = name
> leafName ( ColorLeaf    name _ ) = name
> leafName ( ShapeLeaf    name _ ) = name
> leafName ( SpriteLeaf   name _ ) = name
> leafName ( FunctionLeaf name _ ) = name
> leafName ( KeyLeaf name _ ) = name
> leafName ( NodeLeaf     name _ ) = name

    Each of the following get the value from a leaf and return that value in it's
    own format.

> nodeList :: PropertyTree -> [PropertyTree]
> nodeList (  NodeList    _ value ) = value
> leafBool :: PropertyTree -> Bool
> leafBool (  BoolLeaf    _ value ) = value
> leafString :: PropertyTree -> String
> leafString (  StringLeaf  _ value ) = value
> leafInteger :: PropertyTree -> Integer
> leafInteger (  IntegerLeaf _ value ) = value
> leafFloat :: PropertyTree -> Float
> leafFloat (  FloatLeaf   _ value ) = value
> leafVector :: PropertyTree -> Vector
> leafVector (  VectorLeaf  _ value ) = value
> leafNode :: PropertyTree -> PropertyTree
> leafNode (  NodeLeaf    _ value ) = value
> leafColor :: PropertyTree -> PropertyTree
> leafColor (  NodeLeaf    _ value ) = value
> leafShape :: PropertyTree -> PropertyTree
> leafShape (  NodeLeaf    _ value ) = value
> leafSprite :: PropertyTree -> PropertyTree
> leafSprite (  NodeLeaf    _ value ) = value
> leafFunction :: PropertyTree -> PropertyTree -> PropertyTree
> leafFunction ( FunctionLeaf _ value ) x = value x
> leafKey :: PropertyTree -> SDL.SDLKey
> leafKey ( KeyLeaf _ value ) = value

    namedProperties takes a name and a PropertyTree list and returns a list of
    all PropertyTree's that match name.

> namedProperties :: String -> [PropertyTree] -> [PropertyTree]
> namedProperties name properties = [ x | x <- properties, leafName x == name ]

> traversePropertyTree :: [String] -> PropertyTree -> [PropertyTree]
> traversePropertyTree nodePath ( NodeList a b )
>                    | null nodePath = b
>                    | null b = []
>                    | null (namedProperties (head nodePath) b) = []
>                    | otherwise = traversePropertyTree (drop 1 nodePath) (head (namedProperties (head nodePath) b))
> traversePropertyTree nodePath _ = []

> insertIntoNode :: [String] -> PropertyTree -> PropertyTree -> PropertyTree
> insertIntoNode nodePath newNode oldTree
>              | null nodePath = NodeList (leafName oldTree)
>                                         ( newNode : (filter (\ x -> leafName    x /= leafName newNode )
>                                         (traversePropertyTree nodePath oldTree)))
>              | otherwise = insertIntoNode ( init nodePath )
>                                           ( NodeList ( last nodePath ) (newNode : ( filter (\ x -> leafName    x /= leafName newNode ) ( traversePropertyTree nodePath oldTree ))))
>                                           oldTree

> removeFromNode :: [String] -> String -> PropertyTree -> PropertyTree
> removeFromNode nodePath nodeName oldTree
>              | null nodePath = (NodeList (leafName oldTree) (filter (\ x -> leafName    x /= nodeName ) (traversePropertyTree nodePath oldTree)))
>              | otherwise = insertIntoNode (init nodePath) (NodeList (last nodePath) (filter (\ x -> leafName    x /= nodeName ) (traversePropertyTree nodePath oldTree))) oldTree
