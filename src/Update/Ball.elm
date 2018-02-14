module Update.Ball
    exposing
        ( hasBallFallen
        , updateBallPosition
        , updateBallVelocity
        )

import Constants exposing (ballAttributes, gameAttributes)
import Model exposing (..)
import Model.Ball exposing (Ball)
import Update.Collisions exposing (doesBallHitBrick, doesBallHitCeiling, doesBallHitPaddle, doesBallHitWall)


updateBallVelocity : Model -> Model
updateBallVelocity model =
    let
        ballPosition =
            model.ballPosition

        ballVelocity =
            model.ballVelocity

        updateVelocityY =
            if doesBallHitPaddle model || doesBallHitBrick model then
                ballVelocity.y * -1
            else if doesBallHitCeiling ballPosition then
                round (toFloat ballVelocity.y * -1.2)
            else
                ballVelocity.y

        updateVelocityX =
            if doesBallHitWall ballPosition then
                ballVelocity.x * -1
            else
                ballVelocity.x

        updateVelocity =
            if hasBallFallen model || model.gameState == Dead then
                { x = 0, y = 0 }
            else
                { x = updateVelocityX
                , y = updateVelocityY
                }
    in
    { model | ballVelocity = updateVelocity }


updateBallPosition : Model -> Model
updateBallPosition model =
    let
        updatePosition =
            if hasBallFallen model then
                ballAttributes.startPosition
            else
                { x = model.ballPosition.x + model.ballVelocity.x
                , y = model.ballPosition.y + model.ballVelocity.y
                }
    in
    { model | ballPosition = updatePosition }


hasBallFallen : Model -> Bool
hasBallFallen model =
    model.ballPosition.y >= gameAttributes.height && model.gameState /= Dead
