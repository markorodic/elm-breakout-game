module Update.Bricks
    exposing
        ( hasBallHitBrick
        , notCollidedBricks
        , updateNumberOfBricks
        )

import Constants exposing (..)
import Model exposing (Model)
import Model.Ball exposing (Ball)
import Model.Bricks exposing (Brick)


hasBallHitBrick : Ball -> Brick -> Bool
hasBallHitBrick ball brick =
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
            ball.x + round (0.5 * ballAttributes.width)
    in
    ballCenterX > brickStartX && ballCenterX < brickEndX && ball.y + ballAttributes.height > brickStartY && ball.y < brickEndY


notCollidedBricks : Model -> List Brick
notCollidedBricks model =
    List.filter (\brick -> not (hasBallHitBrick model.ballPosition brick)) model.bricks


updateNumberOfBricks : Model -> Model
updateNumberOfBricks model =
    let
        remainingBricks =
            notCollidedBricks model
    in
    { model | bricks = remainingBricks }
