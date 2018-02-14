module Subscriptions exposing (subscriptions)

import AnimationFrame exposing (diffs)
import Keyboard exposing (downs, ups)
import Messages exposing (Msg(..))
import Model exposing (Model)
import Time exposing (Time)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [ tick, keyDown, keyUp ]


tick : Sub Msg
tick =
    diffs TickUpdate


keyDown =
    downs KeyDown


keyUp =
    ups KeyUp
