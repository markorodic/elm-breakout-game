module Model
    exposing
        ( ArrowKey(..)
        , Brick
        , Model
        , Msg(..)
        , init
        )

import Constants exposing (..)
import Time exposing (Time)


-- MODEL


type alias Model =
    { paddleX : Int
    , ballPosition : Ball
    , ballVelocity : Velocity
    , bricks : List Brick
    }


initBricks : List Brick
initBricks =
    let
        initial =
            List.repeat 90
                { position = { x = 0, y = 0 }
                , size = { width = 20, height = 7 }
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
    { b | position = { x = toFloat x, y = toFloat y } }


type alias Brick =
    { position : Position
    , size : Size
    }


type alias Position =
    { x : Float
    , y : Float
    }


type alias Size =
    { width : Int
    , height : Int
    }


model : Model
model =
    { paddleX = 0
    , ballPosition = { x = 60, y = 50 }
    , ballVelocity = { x = -ballAttributes.velocity, y = -ballAttributes.velocity }
    , bricks = initBricks
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


type Msg
    = ArrowPressed ArrowKey
    | TickUpdate Time


type ArrowKey
    = NoKey
    | LeftKey
    | RightKey
    | SpaceKey
