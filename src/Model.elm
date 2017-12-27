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
        |> updateBallHitBrick
        |> updatePaddleHitBall
        |> doesBallHitWall
        |> updateBall


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
            notCollidedBricks model.ballPosition model.bricks

        newVelocity =
            if model.bricks == remainingBricks then
                currentVelocity
            else
                invertVelocity
    in
    { model | bricks = remainingBricks, ballVelocity = newVelocity }


notCollidedBricks : Ball -> List Brick -> List Brick
notCollidedBricks ball bricks =
    List.filter (\brick -> not (hasBallHitBrick ball brick.position)) bricks


hasBallHitBrick ball brick =
    let
        brickStartX =
            brick.x

        brickEndX =
            brick.x + brickAttributes.width

        brickStartY =
            brick.y

        brickEndY =
            brick.y + brickAttributes.height
    in
    ball.x > brickStartX && ball.x < brickEndX && ball.y > brickStartY && ball.y < brickEndY


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


updateBall : Model -> Model
updateBall model =
    let
        positionX =
            model.ballPosition.x + model.ballVelocity.x

        positionY =
            model.ballPosition.y + model.ballVelocity.y
    in
    { model | ballPosition = { x = positionX, y = positionY } }


doesBallHitWall : Model -> Model
doesBallHitWall model =
    let
        currentVelocity =
            model.ballVelocity

        newVelocityX =
            { currentVelocity | x = currentVelocity.x * -1 }

        newVelocityY =
            { currentVelocity | y = currentVelocity.y * -1 }
    in
    if model.ballPosition.x < 0 then
        { model | ballVelocity = newVelocityX }
    else if model.ballPosition.x > gameAttributes.width then
        { model | ballVelocity = newVelocityX }
    else if model.ballPosition.y < 0 then
        { model | ballVelocity = newVelocityY }
    else if model.ballPosition.y > gameAttributes.height then
        { model | ballVelocity = { x = 0, y = 0 }, ballPosition = ballAttributes.startPosition, playing = False }
    else
        model


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
