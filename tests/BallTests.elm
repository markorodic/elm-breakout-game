module BallTests exposing (ballUpdates)

import Constants exposing (..)
import Expect exposing (..)
import Model exposing (..)
import Test exposing (Test, describe, test)


ballUpdates : Test
ballUpdates =
    describe "Test ball updates"
        [ test "Add velocity to ball position" <|
            \() ->
                { model | ballPosition = { x = 0, y = 0 }, ballVelocity = { x = 2, y = 2 } }
                    |> updateBallPosition
                    |> Expect.equal { model | ballPosition = { x = 2, y = 2 }, ballVelocity = { x = 2, y = 2 } }
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
