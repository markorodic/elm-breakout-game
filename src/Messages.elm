module Messages exposing (Msg(..))

import Keyboard exposing (KeyCode)
import Time exposing (Time)


type Msg
    = KeyDown KeyCode
    | KeyUp KeyCode
    | TickUpdate Time
