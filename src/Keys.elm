module Keys exposing (keyDown, keyUp)

import Constants exposing (paddleAttributes)
import Keyboard exposing (KeyCode)
import Model exposing (Model)
import Model.Ball exposing (initBall)
import Model.Bricks exposing (initBricks)
import Model.Game exposing (GameState(..), initGame)
import Model.Paddle exposing (initPaddle)
import Update.Paddle exposing (movePaddle, stopPaddle)


keyDown : KeyCode -> Model -> Model
keyDown keyCode model =
    let
        { game, paddle } =
            model
    in
    case keyCode of
        37 ->
            { model | paddle = movePaddle paddle -5 }

        -- movePaddle velocity paddleAttributes.velocity.left
        39 ->
            { model | paddle = movePaddle paddle 5 }

        -- movePaddle velocity paddleAttributes.velocity.right
        32 ->
            startBall model

        _ ->
            model


startBall model =
    let
        newGame =
            model.game

        newBall =
            model.ball
    in
    case model.game.state of
        Start ->
            { model | game = { newGame | state = Play }, ball = { newBall | velocity = { x = 2, y = 2 } } }

        Play ->
            model

        -- { model | game = { newGame | state = Pause }, ball = { newBall | velocity = { x = 0, y = 0 } } }
        -- Pause ->
        --     { model | game = { newGame | state = Play }, ball = { newBall | velocity = { x = 2, y = 2 } } }
        Gameover ->
            -- { model | game = { newGame | state = Start, score = 0, lives = 3 }, ball = { newBall | velocity = { x = 0, y = 0 } } }
            resetGame model


resetGame model =
    { model | game = initGame, ball = initBall, bricks = initBricks, paddle = initPaddle }


keyUp : KeyCode -> Model -> Model
keyUp keyCode model =
    let
        { paddle } =
            model
    in
    case keyCode of
        37 ->
            { model | paddle = stopPaddle paddle }

        39 ->
            { model | paddle = stopPaddle paddle }

        32 ->
            model

        _ ->
            model
