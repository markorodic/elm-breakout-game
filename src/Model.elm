module Model exposing (..)

import Keyboard exposing (KeyCode)
import Messages exposing (Msg(..))
import Model.Ball exposing (Ball, initBall)
import Model.Bricks exposing (Brick, initBricks)
import Model.Game exposing (GameState, InitGame, initGame)
import Model.Paddle exposing (InitPaddle, initPaddle)
import Time exposing (Time)


init : ( Model, Cmd Msg )
init =
    ( model, Cmd.none )


type alias Model =
    { paddle : InitPaddle
    , ball : Ball
    , bricks : List Brick
    , game : InitGame
    }


model : Model
model =
    { paddle = initPaddle
    , ball = initBall
    , bricks = initBricks
    , game = initGame
    }
