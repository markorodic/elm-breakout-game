module Update.Collisions exposing (..)

import Constants exposing (..)
import Model exposing (Model)
import Model.Ball exposing (Ball, BallValue)
import Model.Bricks exposing (Brick)
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


doesBallHitBrick : List Brick -> Ball -> Bool
doesBallHitBrick bricks ball =
    not (bricks == notCollidedBricks bricks ball)
