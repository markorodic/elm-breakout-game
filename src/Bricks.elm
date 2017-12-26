module Bricks exposing (..)

import Constants exposing (..)


emptyBrickList : List Brick
emptyBrickList =
    let
        initialBricks =
            List.repeat brickLayout.numberOfBricks
                { position = { x = 0, y = 0 }
                , size = { width = brickAttributes.width, height = brickAttributes.height }
                }
    in
    initialBricks


initBricks : List Brick
initBricks =
    let
        positionedBricks =
            List.indexedMap assignBrickPosition emptyBrickList
    in
    positionedBricks


assignBrickPosition index b =
    let
        x =
            rem index brickLayout.bricksPerLine * (b.size.width + brickLayout.padding) + brickLayout.xMargin

        y =
            (index // brickLayout.bricksPerLine) * (b.size.height + brickLayout.padding) + brickLayout.yMargin
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
