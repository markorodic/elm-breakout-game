module Messages exposing (ArrowKey(..), Msg(..))

import Time exposing (Time)


type Msg
    = ArrowPressed ArrowKey
    | TickUpdate Time


type ArrowKey
    = NoKey
    | LeftKey
    | RightKey
    | SpaceKey
