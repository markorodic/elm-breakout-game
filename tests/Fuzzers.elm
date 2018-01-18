module Fuzzers exposing (..)

import Constants exposing (..)
import Fuzz exposing (Fuzzer)
import Model exposing (..)


ballInPlay : Fuzzer Ball
ballInPlay =
    Fuzz.map2 deserializeBallPosition
        (Fuzz.intRange 0 392)
        (Fuzz.intRange 0 499)


ballNotColliding : Fuzzer Ball
ballNotColliding =
    Fuzz.map2 deserializeBallPosition
        ballPositionX.isNotColliding
        ballPositionY.isNotColliding


ballCollidingLeftWall : Fuzzer Ball
ballCollidingLeftWall =
    Fuzz.map2 deserializeBallPosition
        ballPositionX.isCollidingLeftWall
        ballPositionY.isNotColliding


ballCollidingRightWall : Fuzzer Ball
ballCollidingRightWall =
    Fuzz.map2 deserializeBallPosition
        ballPositionX.isCollidingRightWall
        ballPositionY.isNotColliding


ballCollidingCeiling : Fuzzer Ball
ballCollidingCeiling =
    Fuzz.map2 deserializeBallPosition
        ballPositionX.isNotColliding
        ballPositionY.isCollidingCeiling


ballCollidingPaddle : Fuzzer Ball
ballCollidingPaddle =
    Fuzz.map2 deserializeBallPosition
        ballPositionX.isCollidingPaddle
        ballPositionY.isCollidingPaddle


ballFalls : Fuzzer Ball
ballFalls =
    Fuzz.map2 deserializeBallPosition
        ballPositionX.isNotColliding
        ballPositionY.hasFallen


deserializeBallPosition : Int -> Int -> Ball
deserializeBallPosition xPos yPos =
    { x = xPos
    , y = yPos
    }


ballPositionX =
    { isInPlay = Fuzz.intRange 0 392
    , isNotColliding = Fuzz.intRange 1 391
    , isCollidingLeftWall = Fuzz.constant 0
    , isCollidingRightWall = Fuzz.constant 392
    , isCollidingPaddle = Fuzz.intRange 218 276
    }


ballPositionY =
    { isInPlay = Fuzz.intRange 0 499
    , isNotColliding = Fuzz.intRange 91 489
    , isCollidingCeiling = Fuzz.constant 0
    , isCollidingPaddle = Fuzz.constant 496
    , hasFallen = Fuzz.constant 501
    }
