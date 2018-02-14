module Model exposing (..)

import Constants exposing (ballAttributes, gameAttributes, paddleAttributes)
import Keyboard exposing (KeyCode)
import Messages exposing (Msg(..))
import Model.Ball exposing (Ball)
import Model.Bricks exposing (Brick, initBricks)
import Time exposing (Time)


init : ( Model, Cmd Msg )
init =
    ( model, Cmd.none )


type alias Model =
    { paddlePositionX : Int
    , paddleVelocity : Int
    , ballPosition : Ball
    , ballVelocity : Velocity
    , bricks : List Brick
    , score : Int
    , lives : Int
    , gameState : GameState
    , pausedVelocity : Velocity
    }


model : Model
model =
    { paddlePositionX = paddleAttributes.startPosition
    , paddleVelocity = 0
    , ballPosition = ballAttributes.startPosition
    , ballVelocity = { x = 0, y = 0 }
    , bricks = initBricks
    , score = gameAttributes.score
    , lives = gameAttributes.lives
    , gameState = Start
    , pausedVelocity = { x = 0, y = 0 }
    }


type alias Velocity =
    { x : Int
    , y : Int
    }


type GameState
    = Start
    | Playing
    | Paused
    | BallFall
    | Dead
