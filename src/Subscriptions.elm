module Subscriptions exposing (subscriptions)

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
