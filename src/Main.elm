module Main exposing (..)

import Html
import Messages exposing (..)
import Model exposing (..)
import Subscriptions exposing (..)
import View


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = View.view
        , update = update
        , subscriptions = subscriptions
        }
