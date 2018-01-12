module Subscriptions exposing (subscriptions)

import AnimationFrame exposing (..)
import Keyboard
import Messages exposing (..)
import Model exposing (..)
import Time exposing (Time)


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [ arrowChanged, tick ]


tick : Sub Msg
tick =
    AnimationFrame.diffs TickUpdate


arrowChanged : Sub Msg
arrowChanged =
    Keyboard.downs KeyDown
