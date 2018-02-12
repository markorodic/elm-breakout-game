module Subscriptions exposing (subscriptions)

import AnimationFrame exposing (..)
import Keyboard
import Messages exposing (..)
import Model exposing (..)
import Time exposing (Time)


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [ tick, keyDown, keyUp ]


tick : Sub Msg
tick =
    AnimationFrame.diffs TickUpdate


keyDown =
    Keyboard.downs KeyDown


keyUp =
    Keyboard.ups KeyUp
