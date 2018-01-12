module Model exposing (..)

import Bricks exposing (..)
import Constants exposing (..)
import Keyboard exposing (KeyCode)
import Messages exposing (Msg(..))


-- MODEL


type alias Model =
    { paddleX : Int
    , ballPosition : Ball
    , ballVelocity : Velocity
    , bricks : List Brick
    , playingStatus : Bool
    , score : Int
    , lives : Int
    }


model : Model
model =
    { paddleX = paddleAttributes.startPosition
    , ballPosition = ballAttributes.startPosition
    , ballVelocity = { x = 0, y = 0 }
    , bricks = initBricks
    , playingStatus = False
    , score = gameAttributes.score
    , lives = gameAttributes.lives
    }


type alias Ball =
    { x : Int
    , y : Int
    }


type alias Velocity =
    { x : Int
    , y : Int
    }


init : ( Model, Cmd Msg )
init =
    ( model, Cmd.none )



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
        ballPos =
            model.ballPosition

        ballVel =
            model.ballVelocity

        updatePosition =
            if hasBallFallen ballPos then
                ballAttributes.startPosition
            else
                { x = ballPos.x + ballVel.x
                , y = ballPos.y + ballVel.y
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

        updateVelocityX =
            if doesBallHitWall ballPosition then
                ballVelocity.x * -1
            else if doesBallHitCeiling ballPosition then
                round (toFloat ballVelocity.x * 1.2)
            else
                ballVelocity.x

        updateVelocityY =
            if doesBallHitPaddle model || doesBallHitBrick model then
                ballVelocity.y * -1
            else if doesBallHitCeiling ballPosition then
                round (toFloat ballVelocity.y * -1.2)
            else
                ballVelocity.y

        updateVelocity =
            if hasBallFallen ballPosition then
                { x = 0, y = 0 }
            else
                { x = updateVelocityX
                , y = updateVelocityY
                }
    in
    { model | ballVelocity = updateVelocity }


hasBallFallen : Ball -> Bool
hasBallFallen ball =
    ball.y >= gameAttributes.height


doesBallHitWall : Ball -> Bool
doesBallHitWall ball =
    ball.x <= 0 || ball.x >= gameAttributes.width


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
            if hasBallFallen model.ballPosition then
                model.lives - 1
            else
                model.lives

        updateScore =
            if doesBallHitBrick model then
                model.score + 1
            else
                model.score

        updatePlayingStatus =
            if hasBallFallen model.ballPosition then
                False
            else
                model.playingStatus
    in
    { model | lives = updateLives, score = updateScore, playingStatus = updatePlayingStatus }


keyDown : KeyCode -> Model -> Model
keyDown keyCode model =
    case keyCode of
        37 ->
            movePaddleLeft model

        39 ->
            movePaddleRight model

        32 ->
            launchBall model

        _ ->
            model


launchBall model =
    let
        currentVelocity =
            model.ballVelocity

        newVelocityX =
            { currentVelocity | x = currentVelocity.x * -1 }

        newVelocityY =
            { currentVelocity | y = currentVelocity.y * -1 }
    in
    if not model.playingStatus then
        { model | ballPosition = ballAttributes.startPosition, ballVelocity = { x = ballAttributes.velocity, y = ballAttributes.velocity }, playingStatus = True }
    else
        model


movePaddleLeft model =
    let
        updatePaddleLeftPos =
            if model.paddleX < 5 then
                0
            else
                model.paddleX - 10
    in
    { model | paddleX = updatePaddleLeftPos }


movePaddleRight model =
    let
        paddlePositionEnd =
            gameAttributes.width - paddleAttributes.width

        updatePaddleRightPos =
            if model.paddleX > (paddlePositionEnd - 5) then
                paddlePositionEnd
            else
                model.paddleX + 10
    in
    { model | paddleX = updatePaddleRightPos }
