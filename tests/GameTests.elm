module GameTests exposing (gameMechanics)

import Constants exposing (..)
import Expect exposing (..)
import Fuzz exposing (Fuzzer)
import Fuzzers exposing (..)
import Model exposing (..)
import Test exposing (Test, describe, fuzz, test)


gameMechanics : Test
gameMechanics =
    describe "Test game mechanics"
        [ describe "Lives"
            [ test "Game begins with 3 lives" <|
                \() ->
                    model.lives
                        |> Expect.equal 3
            , test "Decrease lives on ball fall" <|
                \() ->
                    { model | ballPosition = { x = 10, y = 500 }, gameState = Playing }
                        |> updateGame
                        |> Expect.equal { model | ballPosition = { x = 10, y = 500 }, lives = 2, gameState = BallFall }
            , test "Reset lives to 3 on game restart" <|
                \() ->
                    { model | lives = 2, gameState = Start }
                        |> updateGame
                        |> Expect.equal { model | lives = 3, gameState = Start }
            ]
        , describe "Score"
            [ test "Game begins with 0 score" <|
                \() ->
                    model.score
                        |> Expect.equal 0
            , test "Increase score on brick collision" <|
                \() ->
                    { model | ballPosition = { x = 10, y = 80 }, score = 0, gameState = Playing }
                        |> updateGame
                        |> Expect.equal { model | ballPosition = { x = 10, y = 80 }, score = 1, gameState = Playing }
            , test "Reset score on game restart" <|
                \() ->
                    { model | score = 1, gameState = Start }
                        |> updateGame
                        |> Expect.equal { model | score = 0, gameState = Start }
            ]
        , describe "Game states"
            [ test "GameOver when no more remaining lives" <|
                \() ->
                    { model | lives = 0, gameState = Playing }
                        |> updateGame
                        |> Expect.equal { model | lives = 0, gameState = Dead }
            , fuzz ballFalls "BallFall when the ball falls" <|
                \ballPosition ->
                    { model | ballPosition = ballPosition, gameState = Playing }
                        |> updateGame
                        |> Expect.equal { model | ballPosition = ballPosition, lives = 2, gameState = BallFall }
            ]
        ]
