module StyleSheet exposing (..)

import Color exposing (..)
import Style exposing (..)
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font


type MyStyles
    = Background
    | Text
    | Game
    | Paddle
    | Ball
    | Bricks Ranks


type Ranks
    = One
    | Two
    | Three
    | Four
    | Five
    | Six


colours =
    { grey = Color.rgb 142 142 142
    , red = Color.rgb 198 73 75
    , tomato = Color.rgb 196 108 64
    , orange = Color.rgb 179 121 56
    , yellow = Color.rgb 162 161 54
    , green = Color.rgb 75 159 76
    , purple = Color.rgb 67 77 197
    }


stylesheet =
    Style.styleSheet
        [ Style.style Background
            [ Color.text colours.grey
            , Color.background black
            ]
        , Style.style Text
            [ Font.size 40
            , Font.typeface
                [ Font.importUrl { url = "https://fonts.googleapis.com/css?family=Press+Start+2P", name = "Press Start 2P" } ]
            ]
        , Style.style Game
            [ Border.all 26
            , Border.bottom 0
            , Color.border colours.grey
            ]
        , Style.style Ball
            [ Color.background colours.red
            ]
        , Style.style Paddle
            [ Color.background colours.red
            ]
        , Style.style (Bricks One)
            [ Color.background colours.red
            ]
        , Style.style (Bricks Two)
            [ Color.background colours.tomato
            ]
        , Style.style (Bricks Three)
            [ Color.background colours.orange
            ]
        , Style.style (Bricks Four)
            [ Color.background colours.yellow
            ]
        , Style.style (Bricks Five)
            [ Color.background colours.green
            ]
        , Style.style (Bricks Six)
            [ Color.background colours.purple
            ]
        ]
