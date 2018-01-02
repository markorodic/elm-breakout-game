module BallTests exposing (ballUpdates)

import Constants exposing (..)
import Expect exposing (..)
import Fuzz exposing (Fuzzer)
import Fuzzers exposing (..)
import Model exposing (..)
import Test exposing (Test, describe, fuzz, test)


ballUpdates : Test
ballUpdates =
    describe "Test ball updates"
        [ describe "Positional changes"
            [ fuzz ballInPlay "Velocity is added to position when ball is within game bounds" <|
                \ballPosition ->
                    let
                        updatedPosition =
                            { x = ballPosition.x + 4, y = ballPosition.y + 4 }
                    in
                    { model | ballPosition = ballPosition, ballVelocity = { x = 4, y = 4 } }
                        |> updateBallPosition
                        |> Expect.equal { model | ballPosition = updatedPosition, ballVelocity = { x = 4, y = 4 } }
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
        , describe "Velocity changes due to collisions"
            [ fuzz ballNotColliding "Velocity does not change when ball is not colliding and within game bounds" <|
                \ballPosition ->
                    { model | ballPosition = ballPosition, ballVelocity = { x = 4, y = 4 } }
                        |> updateBallVelocity
                        |> Expect.equal { model | ballPosition = ballPosition, ballVelocity = { x = 4, y = 4 } }
            , fuzz ballCollidingLeftWall "X velocity changes to positive on left wall collision" <|
                \ballPosition ->
                    { model | ballPosition = ballPosition, ballVelocity = { x = -4, y = 4 } }
                        |> updateBallVelocity
                        |> Expect.equal { model | ballPosition = ballPosition, ballVelocity = { x = 4, y = 4 } }
            , fuzz ballCollidingRightWall "X velocity changes to negative on right wall collision" <|
                \ballPosition ->
                    { model | ballPosition = ballPosition, ballVelocity = { x = 4, y = 4 } }
                        |> updateBallVelocity
                        |> Expect.equal { model | ballPosition = ballPosition, ballVelocity = { x = -4, y = 4 } }
            , test "Y velocity changes to positive on ceiling collision" <|
                \() ->
                    { model | ballPosition = { x = 200, y = 0 }, ballVelocity = { x = 4, y = -4 } }
                        |> updateBallVelocity
                        |> Expect.equal { model | ballPosition = { x = 200, y = 0 }, ballVelocity = { x = 4, y = 4 } }
            , test "Y velocity changes to positive on paddle collision" <|
                \() ->
                    { model | ballPosition = { x = 75, y = 395 }, ballVelocity = { x = 4, y = 4 }, paddleX = 70 }
                        |> updateBallVelocity
                        |> Expect.equal { model | ballPosition = { x = 75, y = 395 }, ballVelocity = { x = 4, y = -4 }, paddleX = 70 }
            , test "Y velocity changes to positive on brick collision" <|
                \() ->
                    { model | ballPosition = { x = 11, y = 6 }, ballVelocity = { x = 4, y = -4 } }
                        |> updateBallVelocity
                        |> Expect.equal { model | ballPosition = { x = 11, y = 6 }, ballVelocity = { x = 4, y = 4 } }
            ]
        ]
