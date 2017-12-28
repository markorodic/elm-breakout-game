module Model exposing (..)

import Bricks exposing (..)
import Constants exposing (..)
import Messages exposing (ArrowKey(..), Msg(..))


-- MODEL


type alias Model =
    { paddleX : Int
    , ballPosition : Ball
    , ballVelocity : Velocity
    , bricks : List Brick
    , playing : Bool
    , score : Int
    , lives : Int
    }


model : Model
model =
    { paddleX = 0
    , ballPosition = ballAttributes.startPosition
    , ballVelocity = { x = 0, y = 0 }
    , bricks = initBricks
    , playing = False
    , score = 0
    , lives = 3
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
        ArrowPressed key ->
            ( keyDown key model, Cmd.none )

        TickUpdate dt ->
            ( gameLoop model, Cmd.none )


gameLoop : Model -> Model
gameLoop model =
    model
        |> updateBallVelocity
        |> updateNumberOfBricks
        |> updateBallPosition


updateNumberOfBricks : Model -> Model
updateNumberOfBricks model =
    let
        remainingBricks =
            notCollidedBricks model
    in
    { model | bricks = remainingBricks }


changeBallVelocity : Model -> Model
changeBallVelocity model =
    let
        currentVelocity =
            model.ballVelocity

        changeVelocityY =
            { currentVelocity | y = currentVelocity.y * -1 }

        newVelocityY =
            if notCollidedBricks model == model.bricks then
                changeVelocityY
            else
                currentVelocity
    in
    { model | ballVelocity = newVelocityY }


updateBallHitBrick : Model -> Model
updateBallHitBrick model =
    let
        ballPositionX =
            model.ballPosition.x

        ballPositionY =
            model.ballPosition.y

        currentVelocity =
            model.ballVelocity

        invertVelocity =
            { currentVelocity | y = currentVelocity.y * -1 }

        remainingBricks =
            notCollidedBricks model

        newVelocity =
            if model.bricks == remainingBricks then
                currentVelocity
            else
                invertVelocity
    in
    { model | bricks = remainingBricks, ballVelocity = newVelocity }


updatePaddleHitBall : Model -> Model
updatePaddleHitBall model =
    let
        positionX =
            model.ballPosition.x + model.ballVelocity.x

        positionY =
            model.ballPosition.y + model.ballVelocity.y

        paddlePositionX =
            model.paddleX

        currentVelocity =
            model.ballVelocity

        newVelocityY =
            { currentVelocity | y = currentVelocity.y * -1 }
    in
    if positionX > paddlePositionX && positionX < paddlePositionX + paddleAttributes.width && positionY >= paddleAttributes.yPosition then
        { model | ballVelocity = newVelocityY }
    else
        model


updateBallPosition : Model -> Model
updateBallPosition model =
    let
        positionX =
            model.ballPosition.x + model.ballVelocity.x

        positionY =
            model.ballPosition.y + model.ballVelocity.y
    in
    { model | ballPosition = { x = positionX, y = positionY } }


updateBallVelocity : Model -> Model
updateBallVelocity model =
    let
        ball =
            model.ballPosition

        updateVelocityX =
            if doesBallHitWall ball then
                model.ballVelocity.x * -1
            else
                model.ballVelocity.x

        updateVelocityY =
            if doesBallHitCeiling ball || doesBallHitPaddle model || doesBallHitBrick model then
                model.ballVelocity.y * -1
            else
                model.ballVelocity.y
    in
    { model | ballVelocity = { x = updateVelocityX, y = updateVelocityY } }


doesBallHitWall : Ball -> Bool
doesBallHitWall ball =
    ball.x <= 0 || ball.x >= gameAttributes.width


doesBallHitCeiling : Ball -> Bool
doesBallHitCeiling ball =
    ball.y <= 0


doesBallHitPaddle : Model -> Bool
doesBallHitPaddle model =
    model.ballPosition.x
        > model.paddleX
        && model.ballPosition.x
        < model.paddleX
        + paddleAttributes.width
        && model.ballPosition.y
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
    in
    ball.x > brickStartX && ball.x < brickEndX && ball.y > brickStartY && ball.y < brickEndY


keyDown : ArrowKey -> Model -> Model
keyDown key model =
    case key of
        LeftKey ->
            { model | paddleX = model.paddleX - 5 }

        RightKey ->
            { model | paddleX = model.paddleX + 5 }

        SpaceKey ->
            let
                currentVelocity =
                    model.ballVelocity

                newVelocityX =
                    { currentVelocity | x = currentVelocity.x * -1 }

                newVelocityY =
                    { currentVelocity | y = currentVelocity.y * -1 }
            in
            if not model.playing then
                { model | ballPosition = ballAttributes.startPosition, ballVelocity = { x = ballAttributes.velocity, y = ballAttributes.velocity }, playing = True }
            else
                model

        _ ->
            model
