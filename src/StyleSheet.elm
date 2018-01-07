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


colours =
    { grey = Color.rgb 142 142 142
    }


stylesheet =
    Style.styleSheet
        [ Style.style Background
            [ Color.text colours.grey
            , Color.background black
            ]
        , Style.style Game
            [ Border.all 25
            , Border.bottom 0
            , Color.border colours.grey
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
