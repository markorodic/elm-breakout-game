module BallTests exposing (ballUpdates)

import Constants exposing (..)
import Expect exposing (..)
import Fuzz exposing (Fuzzer)
import Fuzzers exposing (..)
import Model exposing (..)
import Test exposing (Test, describe, fuzz, test)
import Update exposing (..)


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
                    { model | ballPosition = { x = 200, y = 500 } }
                        |> updateBallPosition
                        |> Expect.equal { model | ballPosition = { x = 160, y = 275 } }
            , test "Stop ball velocity on fall" <|
                \() ->
                    { model | ballPosition = { x = 200, y = 500 }, ballVelocity = { x = 4, y = 4 } }
                        |> updateBallVelocity
                        |> Expect.equal { model | ballPosition = { x = 200, y = 500 }, ballVelocity = { x = 0, y = 0 } }
            ]
        , describe "Velocity changes due to collisions"
            [ fuzz ballNotColliding "Velocity does not change when ball is not colliding and within game bounds" <|
                \ballPosition ->
                    { model | ballPosition = ballPosition, ballVelocity = { x = 4, y = 4 }, gameState = Playing }
                        |> updateBallVelocity
                        |> Expect.equal { model | ballPosition = ballPosition, ballVelocity = { x = 4, y = 4 }, gameState = Playing }
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
            , fuzz ballCollidingCeiling "Y velocity changes to positive on ceiling collision" <|
                \ballPosition ->
                    { model | ballPosition = ballPosition, ballVelocity = { x = 4, y = -4 } }
                        |> updateBallVelocity
                        |> Expect.equal { model | ballPosition = ballPosition, ballVelocity = { x = 5, y = 5 } }
            , fuzz ballCollidingPaddle "Y velocity changes to positive on paddle collision" <|
                \ballPosition ->
                    { model | ballPosition = ballPosition, ballVelocity = { x = 4, y = 4 } }
                        |> updateBallVelocity
                        |> Expect.equal { model | ballPosition = ballPosition, ballVelocity = { x = 4, y = -4 } }
            , test "Y velocity changes to positive on brick collision" <|
                \() ->
                    { model | ballPosition = { x = 5, y = 30 }, ballVelocity = { x = 4, y = -4 } }
                        |> updateBallVelocity
                        |> Expect.equal { model | ballPosition = { x = 5, y = 30 }, ballVelocity = { x = 4, y = 4 } }
            ]
        ]
