module Update.Collisions exposing (..)

import Constants exposing (..)
import Model exposing (Model)
import Model.Ball exposing (Ball)
import Update.Bricks exposing (..)


doesBallHitWall : Ball -> Bool
doesBallHitWall ball =
    ball.x <= 0 || ball.x + ballAttributes.width >= gameAttributes.width


doesBallHitCeiling : Ball -> Bool
doesBallHitCeiling ball =
    ball.y <= 0


doesBallHitPaddle : Model -> Bool
doesBallHitPaddle model =
    let
        ballCenter =
            model.ballPosition.x + round (0.5 * ballAttributes.width)
    in
    ballCenter
        > model.paddlePositionX
        && ballCenter
        < model.paddlePositionX
        + paddleAttributes.width
        && model.ballPosition.y
        + ballAttributes.height
        >= paddleAttributes.yPosition


doesBallHitBrick : Model -> Bool
doesBallHitBrick model =
    not (model.bricks == notCollidedBricks model)
