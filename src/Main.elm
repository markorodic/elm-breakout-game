module Main exposing (main)

import Html
import Messages exposing (Msg)
import Model exposing (Model, init)
import Subscriptions exposing (subscriptions)
import Update exposing (update)
import View


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = View.view
        , update = update
        , subscriptions = subscriptions
        }
