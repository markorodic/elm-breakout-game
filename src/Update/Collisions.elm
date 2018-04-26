module Update.Collisions exposing (..)

import Constants exposing (..)
import Model exposing (Model)
import Model.Ball exposing (BallValue)
import Update.Bricks exposing (..)


doesBallHitWall : BallValue -> Bool
doesBallHitWall ballPosition =
    ballPosition.x <= 0 || ballPosition.x >= gameAttributes.width


doesBallHitCeiling : BallValue -> Bool
doesBallHitCeiling ballPosition =
    ballPosition.y <= 0


doesBallHitPaddle : BallValue -> Int -> Bool
doesBallHitPaddle ballPosition paddlePosition =
    let
        ballCenter =
            ballPosition.x + round (0.5 * ballAttributes.width)
    in
    ballCenter
        > paddlePosition
        && ballCenter
        < paddlePosition
        + paddleAttributes.width
        && ballPosition.y
        + ballAttributes.height
        >= paddleAttributes.yPosition


doesBallHitBrick : Model -> Bool
doesBallHitBrick model =
    not (model.bricks == notCollidedBricks model)
