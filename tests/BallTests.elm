module BallTests exposing (ballUpdates)

import Constants exposing (..)
import Expect exposing (..)
import Fuzz exposing (Fuzzer)
import Model exposing (..)
import Test exposing (Test, describe, fuzz, test)


ballUpdates : Test
ballUpdates =
    describe "Test ball updates"
        [ fuzz allBallPositions "fuzz test" <|
            \ballPosition ->
                let
                    updatedPosition =
                        { x = ballPosition.x + 4, y = ballPosition.y + 4 }
                in
                { model | ballPosition = ballPosition, ballVelocity = { x = 4, y = 4 } }
                    |> updateBallPosition
                    |> Expect.equal { model | ballPosition = updatedPosition, ballVelocity = { x = 4, y = 4 } }
        , test "Change ball y velocity to positive on left wall collision" <|
            \() ->
                { model | ballPosition = { x = 0, y = 100 }, ballVelocity = { x = -4, y = 4 } }
                    |> updateBallVelocity
                    |> Expect.equal { model | ballPosition = { x = 0, y = 100 }, ballVelocity = { x = 4, y = 4 } }
        , test "Change ball x velocity to negative on right wall collision" <|
            \() ->
                { model | ballPosition = { x = 400, y = 100 }, ballVelocity = { x = 4, y = 4 } }
                    |> updateBallVelocity
                    |> Expect.equal { model | ballPosition = { x = 400, y = 100 }, ballVelocity = { x = -4, y = 4 } }
        , test "Change ball velocity on ceiling collision" <|
            \() ->
                { model | ballPosition = { x = 200, y = 0 }, ballVelocity = { x = 4, y = -4 } }
                    |> updateBallVelocity
                    |> Expect.equal { model | ballPosition = { x = 200, y = 0 }, ballVelocity = { x = 4, y = 4 } }
        , test "Change ball velocity on paddle hit" <|
            \() ->
                { model | ballPosition = { x = 75, y = 395 }, ballVelocity = { x = 4, y = 4 }, paddleX = 70 }
                    |> updateBallVelocity
                    |> Expect.equal { model | ballPosition = { x = 75, y = 395 }, ballVelocity = { x = 4, y = -4 }, paddleX = 70 }
        , test "Change ball velocity on brick hit" <|
            \() ->
                { model | ballPosition = { x = 11, y = 6 }, ballVelocity = { x = 4, y = -4 } }
                    |> updateBallVelocity
                    |> Expect.equal { model | ballPosition = { x = 11, y = 6 }, ballVelocity = { x = 4, y = 4 } }
        , test "Reset ball position on fall" <|
            \() ->
                { model | ballPosition = { x = 200, y = 400 } }
                    |> updateBallPosition
                    |> Expect.equal { model | ballPosition = { x = 200, y = 200 } }
        , test "Stop ball velocity on fall" <|
            \() ->
                { model | ballPosition = { x = 200, y = 400 }, ballVelocity = { x = 4, y = 4 } }
                    |> updateBallVelocity
                    |> Expect.equal { model | ballPosition = { x = 200, y = 400 }, ballVelocity = { x = 0, y = 0 } }
        ]


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
