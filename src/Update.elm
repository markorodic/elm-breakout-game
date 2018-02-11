module Update exposing (..)

import Bricks exposing (..)
import Constants exposing (..)
import Keyboard exposing (KeyCode)
import Messages exposing (Msg(..))
import Model exposing (..)


-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        KeyDown keyCode ->
            ( keyDown keyCode model, Cmd.none )

        TickUpdate dt ->
            ( gameLoop model, Cmd.none )


gameLoop : Model -> Model
gameLoop model =
    model
        |> updateGame
        |> updateBallVelocity
        |> updateNumberOfBricks
        |> updateBallPosition


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


updateNumberOfBricks : Model -> Model
updateNumberOfBricks model =
    let
        remainingBricks =
            notCollidedBricks model
    in
    { model | bricks = remainingBricks }


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


hasBallFallen : Model -> Bool
hasBallFallen model =
    model.ballPosition.y >= gameAttributes.height && model.gameState /= Dead


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
        > model.paddleX
        && ballCenter
        < model.paddleX
        + paddleAttributes.width
        && model.ballPosition.y
        + ballAttributes.height
        >= paddleAttributes.yPosition


doesBallHitBrick : Model -> Bool
doesBallHitBrick model =
    not (model.bricks == notCollidedBricks model)


notCollidedBricks : Model -> List Brick
notCollidedBricks model =
    List.filter (\brick -> not (hasBallHitBrick model.ballPosition brick)) model.bricks


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


keyDown : KeyCode -> Model -> Model
keyDown keyCode model =
    case keyCode of
        37 ->
            movePaddleLeft model

        39 ->
            movePaddleRight model

        32 ->
            startGame model

        _ ->
            model


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
            { model | gameState = Start, bricks = initBricks, ballPosition = ballAttributes.startPosition, paddleX = paddleAttributes.startPosition }


movePaddleLeft : Model -> Model
movePaddleLeft model =
    let
        updatePaddleLeftPos =
            if model.paddleX < 5 || model.gameState == Paused || model.gameState == Dead then
                model.paddleX
            else
                model.paddleX - 10
    in
    { model | paddleX = updatePaddleLeftPos }


movePaddleRight : Model -> Model
movePaddleRight model =
    let
        paddlePositionEnd =
            gameAttributes.width - paddleAttributes.width

        updatePaddleRightPos =
            if model.paddleX > (paddlePositionEnd - 5) || model.gameState == Paused || model.gameState == Dead then
                model.paddleX
            else
                model.paddleX + 10
    in
    { model | paddleX = updatePaddleRightPos }
