module Model
    exposing
        ( Brick
        , Model
        , init
        )

import Constants exposing (..)
import Messages exposing (ArrowKey(..), Msg(..))


-- MODEL


type alias Model =
    { paddleX : Int
    , ballPosition : Ball
    , ballVelocity : Velocity
    , bricks : List Brick
    , playing : Bool
    , score : Int
    , lives : Int
    }


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


model : Model
model =
    { paddleX = 0
    , ballPosition = ballAttributes.startPosition
    , ballVelocity = { x = 0, y = 0 }
    , bricks = initBricks
    , playing = False
    , score = 0
    , lives = 3
    }


type alias Ball =
    { x : Int
    , y : Int
    }


type alias Velocity =
    { x : Int
    , y : Int
    }


init : ( Model, Cmd Msg )
init =
    ( model, Cmd.none )
