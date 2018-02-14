module View.StyleSheet exposing (..)

import Color exposing (..)
import Style exposing (..)
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font


type MyStyles
    = WindowBackground
    | GameBackground
    | Text
    | Game
    | Paddle
    | Ball
    | Bricks Colours
    | GameOver


type Colours
    = Purple
    | Green
    | Yellow
    | Orange
    | Tomato
    | Red


colours =
    { black = Color.rgb 0 0 0
    , offBlack = Color.rgb 20 20 20
    , grey = Color.rgb 142 142 142
    , red = Color.rgb 198 73 75
    , tomato = Color.rgb 196 108 64
    , orange = Color.rgb 179 121 56
    , yellow = Color.rgb 162 161 54
    , green = Color.rgb 75 159 76
    , purple = Color.rgb 67 77 197
    }


stylesheet =
    Style.styleSheet
        [ Style.style WindowBackground
            [ Color.background colours.black
            ]
        , Style.style GameBackground
            []
        , Style.style Text
            [ Color.background colours.offBlack
            , Color.text grey
            , Border.left 4
            , Border.right 4
            , Color.background colours.offBlack
            , Color.border colours.black
            , Font.size 40
            , Font.typeface
                [ Font.importUrl { url = "https://fonts.googleapis.com/css?family=Press+Start+2P", name = "Press Start 2P" } ]
            ]
        , Style.style Game
            [ Border.left 4
            , Border.right 4
            , Color.background colours.offBlack
            , Color.border colours.black
            , Color.text white
            , Font.size 30
            ]
        , Style.style GameOver
            [ Font.size 30
            , Font.typeface
                [ Font.importUrl { url = "https://fonts.googleapis.com/css?family=Press+Start+2P", name = "Press Start 2P" } ]
            ]
        , Style.style Ball
            [ Color.background colours.red
            ]
        , Style.style Paddle
            [ Color.background colours.red
            ]
        , Style.style (Bricks Purple)
            [ Color.background colours.purple
            ]
        , Style.style (Bricks Green)
            [ Color.background colours.green
            ]
        , Style.style (Bricks Yellow)
            [ Color.background colours.yellow
            ]
        , Style.style (Bricks Orange)
            [ Color.background colours.orange
            ]
        , Style.style (Bricks Tomato)
            [ Color.background colours.tomato
            ]
        , Style.style (Bricks Red)
            [ Color.background colours.red
            ]
        ]
