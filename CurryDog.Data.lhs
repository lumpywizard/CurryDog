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

A Property is a type of hashmap in which we can store useful name/value combinations. Take for instance:

 example = Entity [ PropertyList "Character Sheet" [ StringProperty "Name" "Roger Dodger"
                                                   , IntegerProperty "Hit Points" 24
                                                   , PropertyList "Class/Level" [ IntegerProperty "Rogue" 1
                                                                                , IntegerProperty "Fighter" 1
                                                                                ]
                                                   , PropertyList "ABILITY SCORES" [ IntegerProperty "STR" 14
                                                                                   , IntegerProperty "CON" 13
                                                                                   , IntegerProperty "DEX" 18
                                                                                   , IntegerProperty "INT" 10
                                                                                   , IntegerProperty "WIS"  9
                                                                                   , IntegerProperty "CHA" 16 ] ]
                  , VectorProperty "Location" (Vector2 0 0) ]

 location_example = head $ entityNamedProperties "Location" example

 ability_score_example = namedProperties "ABILITY SCORES" $ propertyList $ head (entityNamedProperties "Character Sheet" example)

Add birdtracks to see the examples in action. In this example, we have an Entity, example. It has a [Property].
The first value is a PropertyList, which nests a [Property]. In this nested [Property] we have a variety of data,
such as Name, Hit Points, Class/Level, and ABILITY SCORES. On the Entity [Property] level, we also have Location,
which specifies a Vector2.

> data Property = StringProperty   String String
>               | IntegerProperty  String Integer
>               | FloatProperty    String Float
>               | VectorProperty   String Vector
>               | NestedProperty   String Property
>               | PropertyList     String [Property]
>                    deriving ( Show )

Getting a property's name is akin to getting a hashkey from a hashtable entry.
To extend storable types, simply add that type to the following 2 sections.

> propertyName :: Property -> String
> propertyName ( StringProperty  name _ ) = name
> propertyName ( IntegerProperty name _ ) = name
> propertyName ( FloatProperty   name _ ) = name
> propertyName ( VectorProperty  name _ ) = name
> propertyName ( NestedProperty  name _ ) = name
> propertyName ( PropertyList    name _ ) = name

Each of the following get the value from a property and return that value in it's own format.

> propertyString :: Property -> String
> propertyString (  StringProperty _  value) = value
> propertyInteger :: Property -> Integer
> propertyInteger ( IntegerProperty _ value) = value
> propertyFloat :: Property -> Float
> propertyFloat ( FloatProperty _  value ) = value
> propertyVector :: Property -> Vector
> propertyVector ( VectorProperty _ value ) = value
> nestedProperty :: Property -> Property
> nestedProperty ( NestedProperty _ value ) = value
> propertyList :: Property -> [Property]
> propertyList ( PropertyList _ value) = value

Named property takes a string and a property list, then returns the property with that name.
It won't recurse multiple levels.

> namedProperties :: String -> [Property] -> [Property]
> namedProperties name properties = [ x | x <- properties, propertyName x == name ]

Think of an Entity as a sort of final root to all properties.
It isn't really anything particularly useful, but serves as a logical organization.

> data Entity = Entity [Property] deriving ( Show )

> getProperties :: Entity -> [Property]
> getProperties (Entity properties) = properties

Since setting the properties of an Entity gives you a new entity anyway,
it makes the most sense for setProperties to be a synonym for Entity.

> setProperties :: [Property] -> Entity
> setProperties = Entity

Shortcut function to access lowest level properties by name.

> entityNamedProperties :: String -> Entity -> [Property]
> entityNamedProperties name (Entity properties) = namedProperties name properties