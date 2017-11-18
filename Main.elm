module Main exposing (..)

import Html exposing (Html, div, program, text)
import Keyboard
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time)


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { paddleX : Int
    , ballPosition : Ball
    , ballVelocity : Velocity
    }


model : Model
model =
    { paddleX = 0
    , ballPosition = { x = 50, y = 50 }
    , ballVelocity = { x = -ballAttributes.velocity, y = -ballAttributes.velocity }
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


gameAttributes =
    { width = 400
    , height = 400
    }


paddleAttributes =
    { width = 30
    , height = 3
    , yPosition = 395
    }


ballAttributes =
    { width = 3
    , height = 3
    , velocity = 4
    }



-- UPDATE


type Msg
    = ArrowPressed ArrowKey
    | TickUpdate Time


type ArrowKey
    = NoKey
    | LeftKey
    | RightKey
    | SpaceKey


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
        |> doesBallHitWall
        |> updateBall


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
    if model.ballPosition.x == 0 then
        { model | ballVelocity = newVelocityX }
    else if model.ballPosition.x == gameAttributes.width then
        { model | ballVelocity = newVelocityX }
    else if model.ballPosition.y == 0 then
        { model | ballVelocity = newVelocityY }
    else if model.ballPosition.y == gameAttributes.height then
        { model | ballVelocity = newVelocityY }
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
            if model.ballPosition.x < 50 then
                { model | ballVelocity = newVelocityX }
            else if model.ballPosition.x > 50 then
                { model | ballVelocity = newVelocityX }
            else if model.ballPosition.y < 50 then
                { model | ballVelocity = newVelocityY }
            else if model.ballPosition.y > 50 then
                { model | ballVelocity = newVelocityY }
            else
                model

        _ ->
            model



-- VIEW


view : Model -> Html Msg
view model =
    let
        paddlePosition =
            toString model.paddleX

        ballPositionX =
            toString model.ballPosition.x

        ballPositionY =
            toString model.ballPosition.y
    in
    div []
        [ svg [ width (toString gameAttributes.width), height (toString gameAttributes.height) ]
            [ rect [ width (toString ballAttributes.width), height (toString ballAttributes.height), x ballPositionX, y ballPositionY ] []
            , rect [ width (toString paddleAttributes.width), height (toString paddleAttributes.height), x paddlePosition, y (toString paddleAttributes.yPosition) ] []
            ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [ arrowChanged, tick ]


tick : Sub Msg
tick =
    Time.every (100 * Time.millisecond) TickUpdate


arrowChanged : Sub Msg
arrowChanged =
    Keyboard.downs toArrowChanged


toArrowChanged : Keyboard.KeyCode -> Msg
toArrowChanged code =
    case code of
        37 ->
            ArrowPressed LeftKey

        39 ->
            ArrowPressed RightKey

        32 ->
            ArrowPressed SpaceKey

        default ->
            ArrowPressed NoKey
