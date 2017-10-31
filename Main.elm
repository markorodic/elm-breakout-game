module Main exposing (..)

import Html exposing (Html, div, program, text)
import Keyboard
import Svg exposing (..)
import Svg.Attributes exposing (..)


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
    }


model : Model
model =
    { paddleX = 0
    , ballPosition = { x = 50, y = 50 }
    }

type alias Ball =
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



-- UPDATE


type Msg
    = ArrowPressed ArrowKey


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ArrowPressed key ->
            ( keyDown key model, Cmd.none )



keyDown : ArrowKey -> Model -> Model
keyDown key model =
    case key of
        LeftKey ->
            { model | paddleX = model.paddleX - 5 }

        RightKey ->
            { model | paddleX = model.paddleX + 5 }

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
        [ svg [ viewBox "0 0 100 100", width "400px" ]
            [ rect [ width "1", height "1", x positionBallX, y positionBallY ] []
            , rect [ width "20", height "1", x positionPad, y "95" ] []
            ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    arrowChanged




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

        default ->
            ArrowPressed NoKey
