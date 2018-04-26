module Update exposing (update)

import Keyboard exposing (KeyCode)
import Keys exposing (keyDown, keyUp)
import Messages exposing (Msg(..))
import Model exposing (Model)
import Model.Game exposing (GameState(..))
import Update.Ball exposing (updateBall)
import Update.Bricks exposing (updateNumberOfBricks)
import Update.Game exposing (updateGame)
import Update.Paddle exposing (updatePaddle)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        KeyDown keyCode ->
            ( keyDown keyCode model, Cmd.none )

        KeyUp keyCode ->
            ( keyUp keyCode model, Cmd.none )

        TickUpdate dt ->
            ( gameLoop model, Cmd.none )


gameLoop : Model -> Model
gameLoop model =
    model
        |> updateBall
        |> updateGame
        |> updateNumberOfBricks
        |> updatePaddle
