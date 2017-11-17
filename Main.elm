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
    , ballVelocity = { x = -2, y = -1 }
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


type ArrowKey
    = NoKey
    | LeftKey
    | RightKey
    | SpaceKey



-- UPDATE


type Msg
    = ArrowPressed ArrowKey
    | TickUpdate Time


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
    else if model.ballPosition.x == 100 then
        { model | ballVelocity = newVelocityX }
    else if model.ballPosition.y == 0 then
        { model | ballVelocity = newVelocityY }
    else if model.ballPosition.y == 100 then
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
        positionPad =
            toString model.paddleX

        positionBallX =
            toString model.ballPosition.x

        positionBallY =
            toString model.ballPosition.y
    in
    div []
        [ svg [ width "100", height "100" ]
            [ rect [ width "1", height "1", x positionBallX, y positionBallY ] []
            , rect [ width "20", height "1", x positionPad, y "95" ] []
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
