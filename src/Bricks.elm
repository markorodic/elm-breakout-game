module Bricks exposing (..)

import Constants exposing (..)


initBricks : List Brick
initBricks =
    let
        initial =
            List.repeat 90
                { position = { x = 0, y = 0 }
                , size = { width = brickAttributes.width, height = brickAttributes.height }
                }

        positioned =
            List.indexedMap assignBrickPosition initial
    in
    positioned


assignBrickPosition index b =
    let
        xOffset =
            10

        yOffset =
            5

        padding =
            5

        lineLength =
            15

        x =
            rem index lineLength * (b.size.width + padding) + xOffset

        y =
            (index // lineLength) * (b.size.height + padding) + yOffset
    in
    { b | position = { x = x, y = y } }


type alias Brick =
    { position : Position
    , size : Size
    }


type alias Position =
    { x : Int
    , y : Int
    }


type alias Size =
    { width : Int
    , height : Int
    }
