module Update.Paddle
    exposing
        ( movePaddle
        , stopPaddle
        , updatePaddle
        )

import Constants exposing (gameAttributes, paddleAttributes)
import Model exposing (..)
import Model.Game exposing (GameState(..))
import Model.Paddle exposing (InitPaddle)


updatePaddle : Model -> Model
updatePaddle model =
    let
        { paddle } =
            model
    in
    { model | paddle = { paddle | position = addVelocityToPosition paddle } }


addVelocityToPosition : InitPaddle -> Int
addVelocityToPosition paddle =
    let
        { position, velocity } =
            paddle
    in
    if paddleCanMove position velocity then
        position + velocity
    else
        position


paddleCanMove : Int -> Int -> Bool
paddleCanMove position velocity =
    let
        paddlePositionEnd =
            gameAttributes.width - paddleAttributes.width - 6

        paddleCanMoveLeft =
            position > 5 && velocity == -5

        paddleCanMoveRight =
            position < paddlePositionEnd && velocity == 5
    in
    paddleCanMoveLeft || paddleCanMoveRight


movePaddle : InitPaddle -> Int -> InitPaddle
movePaddle paddle updateVelocityFromInput =
    { paddle | velocity = updateVelocityFromInput }


stopPaddle : InitPaddle -> InitPaddle
stopPaddle paddle =
    { paddle | velocity = 0 }
