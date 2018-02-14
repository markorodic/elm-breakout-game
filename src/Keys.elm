module Keys exposing (keyDown, keyUp)

import Constants exposing (paddleAttributes)
import Keyboard exposing (KeyCode)
import Model exposing (Model)
import Update.Game exposing (startGame)
import Update.Paddle exposing (movePaddle, stopPaddle)


keyDown : KeyCode -> Model -> Model
keyDown keyCode model =
    case keyCode of
        37 ->
            movePaddle model paddleAttributes.velocity.left

        39 ->
            movePaddle model paddleAttributes.velocity.right

        32 ->
            startGame model

        _ ->
            model


keyUp : KeyCode -> Model -> Model
keyUp keyCode model =
    case keyCode of
        37 ->
            stopPaddle model

        39 ->
            stopPaddle model

        32 ->
            model

        _ ->
            model
