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
    }


model : Model
model =
    { paddleX = 0
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
    in
    svg [ viewBox "0 0 100 100", width "400px" ]
        [ rect [ width "20", height "1", x positionPad, y "95" ] []
        ]

        --, Html.text (toString model.ballVelocity)
        --, Html.text (toString model.ballPosition)
        --, Html.text (toString model.paddleX)



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
