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
            else
                ballVelocity.x

        updateVelocityY =
            if doesBallHitCeiling ballPosition || doesBallHitPaddle model || doesBallHitBrick model then
                ballVelocity.y * -1
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
    in
    { model | lives = updateLives, score = updateScore }


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
