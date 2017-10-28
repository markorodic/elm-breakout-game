module Main exposing (..)

import Html exposing (program, text)
import Svg exposing (..)
import Svg.Attributes exposing (..)


main =
    svg
        [ viewBox "0 0 100 100", width "300px" ]
        [ rect [ width "20", height "2", x "40", y "90" ] []
        ]
