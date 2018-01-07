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
    | Bricks
    | Paddle
    | Ball


colours =
    { grey = Color.rgb 142 142 142
    , red = Color.rgb 198 73 75
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
            [ Border.all 25
            , Border.bottom 0
            , Color.border colours.grey
            ]
        , Style.style Ball
            [ Color.background colours.red
            ]
        , Style.style Paddle
            [ Color.background colours.red
            ]
        , Style.style Bricks
            [ Color.background black
            ]
        ]
