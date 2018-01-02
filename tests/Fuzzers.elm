module Fuzzers exposing (..)

import Fuzz exposing (Fuzzer)
import Model exposing (..)


allBallPositions : Fuzzer Ball
allBallPositions =
    Fuzz.map2 serializePosition
        (Fuzz.intRange 0 400)
        (Fuzz.intRange 0 399)


nonCollidingBallPositions : Fuzzer Ball
nonCollidingBallPositions =
    Fuzz.map2 serializePosition
        ballPositionX.notColliding
        ballPositionY.notColliding


serializePosition : Int -> Int -> Ball
serializePosition xPos yPos =
    { x = xPos
    , y = yPos
    }


ballPositionX =
    { moving = Fuzz.intRange 0 400
    , notColliding = Fuzz.intRange 1 399
    }


ballPositionY =
    { moving = Fuzz.intRange 0 399
    , notColliding = Fuzz.intRange 72 394
    }
