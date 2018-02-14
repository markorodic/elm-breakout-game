module Model.Bricks exposing (..)

import Constants exposing (brickAttributes, brickLayout)


type alias Brick =
    { position : Position
    , size : Size
    , row : Int
    }


type alias Position =
    { x : Int
    , y : Int
    }


type alias Size =
    { width : Int
    , height : Int
    }


emptyBrickList : List Brick
emptyBrickList =
    let
        initialBricks =
            List.repeat brickLayout.numberOfBricks
                { position = { x = 0, y = 0 }
                , size = { width = brickAttributes.width, height = brickAttributes.height }
                , row = 0
                }
    in
    initialBricks


assignBrickPosition index b =
    let
        x =
            rem index brickLayout.bricksPerLine * b.size.width

        y =
            (index // brickLayout.bricksPerLine) * b.size.height + brickLayout.yMargin

        setRow =
            index // brickLayout.bricksPerLine
    in
    { b | position = { x = x, y = y }, row = setRow }


initBricks : List Brick
initBricks =
    let
        positionedBricks =
            List.indexedMap assignBrickPosition emptyBrickList
    in
    positionedBricks
