module Update.Game exposing (updateGame)

import Constants exposing (ballAttributes, brickAttributes, brickLayout, brickPoints, paddleAttributes)
import Model exposing (..)
import Model.Ball exposing (BallValue)
import Model.Bricks exposing (initBricks)
import Model.Game exposing (GameState(..))
import Update.Ball exposing (hasBallFallen)
import Update.Collisions exposing (doesBallHitBrick)


updateGame : Model -> Model
updateGame model =
    let
        { game, ball } =
            model
    in
    model
        |> updateLives
        |> updateScore
        |> updateGameState


updateLives model =
    let
        { lives, state } =
            model.game

        { position } =
            model.ball

        newGame =
            model.game
    in
    if hasBallFallen position && state /= Gameover then
        { model | game = { newGame | lives = lives - 1 } }
        -- else if state == Gameover then
        --     { model | game = { newGame | lives = 3 } }
    else
        model


updateScore model =
    let
        { score, state } =
            model.game

        { position } =
            model.ball

        { ball, bricks } =
            model

        newGame =
            model.game
    in
    if doesBallHitBrick bricks ball then
        { model | game = { newGame | score = score + brickScore position } }
        -- else if state == Gameover then
        --     { model | game = { newGame | score = 0 } }
    else
        model


updateGameState model =
    let
        newState =
            if hasBallFallen model.ball.position then
                Start
            else if model.game.lives == 0 || List.length model.bricks == 0 then
                Gameover
            else
                model.game.state

        newGame =
            model.game
    in
    { model | game = { newGame | state = newState } }


brickScore : BallValue -> Int
brickScore ballPosition =
    if ballPosition.y < (brickLayout.yMargin + brickAttributes.height * 2) then
        brickPoints.high
    else if ballPosition.y < (brickLayout.yMargin + brickAttributes.height * 4) then
        brickPoints.middle
    else
        brickPoints.low
