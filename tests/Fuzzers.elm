module Fuzzers exposing (..)

import Fuzz exposing (Fuzzer)
import Model exposing (..)


ballInPlay : Fuzzer Ball
ballInPlay =
    Fuzz.map2 deserializeBallPosition
        (Fuzz.intRange 0 400)
        (Fuzz.intRange 0 399)


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


ballCollidingPaddle : Fuzzer PaddleBall
ballCollidingPaddle =
    Fuzz.map3 deserializeBallPaddlePosition
        ballPositionX.isCollidingPaddle
        ballPositionY.isCollidingPaddle
        paddlePosition


deserializeBallPosition : Int -> Int -> Ball
deserializeBallPosition xPos yPos =
    { x = xPos
    , y = yPos
    }


type alias PaddleBall =
    { ball : Ball
    , paddle : Int
    }


deserializeBallPaddlePosition : Int -> Int -> Int -> PaddleBall
deserializeBallPaddlePosition xPos yPos paddlePos =
    { ball = { x = xPos, y = yPos }
    , paddle = paddlePos
    }


ballPositionX =
    { isInPlay = Fuzz.intRange 0 400
    , isNotColliding = Fuzz.intRange 1 399
    , isCollidingLeftWall = Fuzz.constant 0
    , isCollidingRightWall = Fuzz.constant 400
    , isCollidingPaddle = Fuzz.intRange 71 99
    }


ballPositionY =
    { isInPlay = Fuzz.intRange 0 399
    , isNotColliding = Fuzz.intRange 72 394
    , isCollidingCeiling = Fuzz.constant 0
    , isCollidingPaddle = Fuzz.constant 395
    }


paddlePosition =
    Fuzz.constant 70
