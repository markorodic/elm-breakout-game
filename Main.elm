module Main exposing (..)

import Constants exposing (..)
import Html
import Keyboard
import Model exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time)
import View


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = View.view
        , update = update
        , subscriptions = subscriptions
        }



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
    if model.ballPosition.x < 0 then
        { model | ballVelocity = newVelocityX }
    else if model.ballPosition.x > gameAttributes.width then
        { model | ballVelocity = newVelocityX }
    else if model.ballPosition.y < 0 then
        { model | ballVelocity = newVelocityY }
    else if model.ballPosition.y > gameAttributes.height then
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



--[ rect [ width (toString ballAttributes.width), height (toString ballAttributes.height), x ballPositionX, y ballPositionY ] []
--, rect [ width (toString paddleAttributes.width), height (toString paddleAttributes.height), x paddlePosition, y (toString paddleAttributes.yPosition) ] []
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
