module Update.Paddle
    exposing
        ( movePaddle
        , stopPaddle
        , updatePaddlePosition
        )

import Constants exposing (gameAttributes, paddleAttributes)
import Model exposing (..)


updatePaddlePosition : Model -> Model
updatePaddlePosition model =
    let
        updatedVelocity =
            updatePaddleVelocity model
    in
    { model | paddlePositionX = updatedVelocity }


updatePaddleVelocity : Model -> Int
updatePaddleVelocity model =
    if gameIsActive model && paddleCanMove model then
        model.paddlePositionX + model.paddleVelocity
    else
        model.paddlePositionX


gameIsActive : Model -> Bool
gameIsActive model =
    model.gameState == Start || model.gameState == Playing || model.gameState == BallFall


paddleCanMove : Model -> Bool
paddleCanMove model =
    let
        paddlePositionEnd =
            gameAttributes.width - paddleAttributes.width - 6

        paddleCanMoveLeft =
            model.paddlePositionX > 5 && model.paddleVelocity == -5

        paddleCanMoveRight =
            model.paddlePositionX < paddlePositionEnd && model.paddleVelocity == 5
    in
    paddleCanMoveLeft || paddleCanMoveRight


movePaddle : Model -> Int -> Model
movePaddle model updateVelocityFromInput =
    { model | paddleVelocity = updateVelocityFromInput }


stopPaddle : Model -> Model
stopPaddle model =
    { model | paddleVelocity = 0 }
