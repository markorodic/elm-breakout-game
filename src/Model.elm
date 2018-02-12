module Model exposing (..)

import Bricks exposing (..)
import Constants exposing (..)
import Messages exposing (Msg(..))


-- MODEL


type alias Model =
    { paddleX : Int
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
    { paddleX = paddleAttributes.startPosition
    , paddleVelocity = 0
    , ballPosition = ballAttributes.startPosition
    , ballVelocity = { x = 0, y = 0 }
    , bricks = initBricks
    , score = gameAttributes.score
    , lives = gameAttributes.lives
    , gameState = Start
    , pausedVelocity = { x = 0, y = 0 }
    }


type alias Ball =
    { x : Int
    , y : Int
    }


type alias Velocity =
    { x : Int
    , y : Int
    }


type alias Device =
    { width : Int
    , height : Int
    , phone : Bool
    , tablet : Bool
    , desktop : Bool
    , bigDesktop : Bool
    , portrait : Bool
    }


type GameState
    = Start
    | Playing
    | Paused
    | BallFall
    | Dead


init : ( Model, Cmd Msg )
init =
    ( model, Cmd.none )
