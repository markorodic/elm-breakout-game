module Update.Bricks
    exposing
        ( hasBallHitBrick
        , notCollidedBricks
        , updateNumberOfBricks
        )

import Constants exposing (..)
import Model exposing (Model)
import Model.Ball exposing (Ball, BallValue)
import Model.Bricks exposing (Brick)


hasBallHitBrick : BallValue -> Brick -> Bool
hasBallHitBrick ballPosition brick =
    let
        brickStartX =
            brick.position.x

        brickEndX =
            brick.position.x + brickAttributes.width

        brickStartY =
            brick.position.y

        brickEndY =
            brick.position.y + brickAttributes.height

        ballCenterX =
            ballPosition.x + round (0.5 * ballAttributes.width)
    in
    ballCenterX > brickStartX && ballCenterX < brickEndX && ballPosition.y + ballAttributes.height > brickStartY && ballPosition.y < brickEndY


notCollidedBricks : List Brick -> Ball -> List Brick
notCollidedBricks bricks ball =
    List.filter (\brick -> not (hasBallHitBrick ball.position brick)) bricks


updateNumberOfBricks : Model -> Model
updateNumberOfBricks model =
    let
        { ball, bricks } =
            model

        remainingBricks =
            notCollidedBricks bricks ball
    in
    { model | bricks = remainingBricks }
