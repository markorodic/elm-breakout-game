module Fuzzers exposing (..)

import Fuzz exposing (Fuzzer)
import Model exposing (..)


allBallPositions : Fuzzer Ball
allBallPositions =
    Fuzz.map2 serializePosition
        (Fuzz.intRange 0 400)
        (Fuzz.intRange 0 399)


serializePosition : Int -> Int -> Ball
serializePosition xPos yPos =
    { x = xPos
    , y = yPos
    }
