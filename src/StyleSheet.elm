module StyleSheet exposing (..)

import Color exposing (..)
import Style exposing (..)
import Style.Border as Border
import Style.Color as Color


type MyStyles
    = Background
    | Text
    | Game
    | Bricks
    | Paddle
    | Ball


stylesheet =
    Style.styleSheet
        [ Style.style Background
            [ Color.text black
            ]
        , Style.style Game
            [ Color.background grey
            ]
        , Style.style Ball
            [ Color.background black
            ]
        , Style.style Paddle
            [ Color.background black
            ]
        , Style.style Bricks
            [ Color.background black
            ]
        ]
