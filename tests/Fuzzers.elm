module Fuzzers exposing (..)

import Fuzz exposing (Fuzzer)
import Model exposing (..)


ballInPlay : Fuzzer Ball
ballInPlay =
    Fuzz.map2 serializePosition
        (Fuzz.intRange 0 400)
        (Fuzz.intRange 0 399)


ballNotColliding : Fuzzer Ball
ballNotColliding =
    Fuzz.map2 serializePosition
        ballPositionX.isNotColliding
        ballPositionY.isNotColliding


ballCollidingLeftWall : Fuzzer Ball
ballCollidingLeftWall =
    Fuzz.map2 serializePosition
        ballPositionX.isCollidingLeftWall
        ballPositionY.isNotColliding


ballCollidingRightWall : Fuzzer Ball
ballCollidingRightWall =
    Fuzz.map2 serializePosition
        ballPositionX.isCollidingRightWall
        ballPositionY.isNotColliding


serializePosition : Int -> Int -> Ball
serializePosition xPos yPos =
    { x = xPos
    , y = yPos
    }


ballPositionX =
    { isInPlay = Fuzz.intRange 0 400
    , isNotColliding = Fuzz.intRange 1 399
    , isCollidingLeftWall = Fuzz.constant 0
    , isCollidingRightWall = Fuzz.constant 400
    }


ballPositionY =
    { isInPlay = Fuzz.intRange 0 399
    , isNotColliding = Fuzz.intRange 72 394
    }
