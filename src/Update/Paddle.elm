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
        paddlePositionEnd =
            gameAttributes.width - paddleAttributes.width - 6

        updateVelocity =
            if model.gameState == Paused || model.gameState == Dead then
                model.paddlePositionX
            else if model.paddlePositionX == 0 && model.paddleVelocity == -5 then
                model.paddlePositionX
            else if model.paddlePositionX > paddlePositionEnd && model.paddleVelocity == 5 then
                model.paddlePositionX
            else
                model.paddlePositionX + model.paddleVelocity
    in
    { model | paddlePositionX = updateVelocity }


movePaddle : Model -> Int -> Model
movePaddle model updateVelocityFromInput =
    { model | paddleVelocity = updateVelocityFromInput }


stopPaddle : Model -> Model
stopPaddle model =
    { model | paddleVelocity = 0 }
