module Update.Game exposing (startGame, updateGame)

import Constants exposing (ballAttributes, brickAttributes, brickLayout, brickPoints, paddleAttributes)
import Model exposing (..)
import Model.Ball exposing (Ball)
import Model.Bricks exposing (initBricks)
import Update.Ball exposing (hasBallFallen)
import Update.Collisions exposing (doesBallHitBrick)


startGame : Model -> Model
startGame model =
    let
        currentVelocity =
            model.ballVelocity

        newVelocityX =
            { currentVelocity | x = currentVelocity.x * -1 }

        newVelocityY =
            { currentVelocity | y = currentVelocity.y * -1 }
    in
    case model.gameState of
        Start ->
            { model | ballVelocity = { x = ballAttributes.velocity, y = ballAttributes.velocity }, gameState = Playing }

        Playing ->
            { model | ballVelocity = { x = 0, y = 0 }, gameState = Paused, pausedVelocity = model.ballVelocity }

        Paused ->
            { model | ballVelocity = model.pausedVelocity, gameState = Playing }

        BallFall ->
            { model | ballVelocity = { x = ballAttributes.velocity, y = ballAttributes.velocity }, gameState = Playing }

        Dead ->
            { model | gameState = Start, bricks = initBricks, ballPosition = ballAttributes.startPosition, paddlePositionX = paddleAttributes.startPosition }


updateGame : Model -> Model
updateGame model =
    let
        updateLives =
            if hasBallFallen model then
                model.lives - 1
            else if model.gameState == Start then
                3
            else
                model.lives

        updateScore =
            if doesBallHitBrick model then
                model.score + brickScore model.ballPosition
            else if model.gameState == Start then
                0
            else
                model.score

        updateGameState =
            if hasBallFallen model then
                BallFall
            else if model.lives == 0 && model.gameState /= Start || List.length model.bricks == 0 then
                Dead
            else
                model.gameState
    in
    { model | lives = updateLives, score = updateScore, gameState = updateGameState }


brickScore : Ball -> Int
brickScore ball =
    if ball.y < (brickLayout.yMargin + brickAttributes.height * 2) then
        brickPoints.high
    else if ball.y < (brickLayout.yMargin + brickAttributes.height * 4) then
        brickPoints.middle
    else
        brickPoints.low
