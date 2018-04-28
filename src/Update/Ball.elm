module Update.Ball
    exposing
        ( hasBallFallen
        , updateBall
        )

import Constants exposing (ballAttributes, gameAttributes)
import Model exposing (..)
import Model.Ball exposing (Ball, BallValue)
import Model.Bricks exposing (Brick)
import Model.Game exposing (GameState(..))
import Update.Collisions exposing (doesBallHitBrick, doesBallHitCeiling, doesBallHitPaddle, doesBallHitWall)


updateBall : Model -> Model
updateBall model =
    model
        |> updatePosition
        |> updateVelocity


updatePosition : Model -> Model
updatePosition model =
    let
        { ball } =
            model
    in
    { model | ball = { ball | position = addVelocityToPosition ball } }


addVelocityToPosition : Ball -> BallValue
addVelocityToPosition ball =
    let
        { position, velocity } =
            ball

        positionPlusVelocity =
            { x = position.x + velocity.x
            , y = position.y + velocity.y
            }
    in
    if hasBallFallen position then
        ballAttributes.startPosition
    else
        positionPlusVelocity


updateVelocity : Model -> Model
updateVelocity model =
    let
        newBall =
            model.ball
    in
    { model | ball = { newBall | velocity = velocityFromCollisions model } }


velocityFromCollisions : Model -> BallValue
velocityFromCollisions model =
    let
        { ball, bricks } =
            model

        { position } =
            ball
    in
    if hasBallFallen position then
        { x = 0
        , y = 0
        }
    else
        { x = handleXCollisions ball
        , y = handleYCollisions bricks ball
        }


handleXCollisions : Ball -> Int
handleXCollisions ball =
    let
        { position, velocity } =
            ball
    in
    if doesBallHitWall position then
        velocity.x * -1
    else
        velocity.x


handleYCollisions : List Brick -> Ball -> Int
handleYCollisions bricks ball =
    let
        { position, velocity } =
            model.ball

        { bricks, ball } =
            model

        paddlePosition =
            model.paddle.position
    in
    if doesBallHitPaddle position paddlePosition || doesBallHitBrick bricks ball then
        velocity.y * -1
    else if doesBallHitCeiling position then
        round (toFloat velocity.y * -1.2)
    else
        velocity.y


hasBallFallen : BallValue -> Bool
hasBallFallen position =
    position.y >= gameAttributes.height
