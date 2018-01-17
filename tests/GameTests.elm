module GameTests exposing (gameMechanics)

import Constants exposing (..)
import Expect exposing (..)
import Model exposing (..)
import Test exposing (Test, describe, test)


gameMechanics : Test
gameMechanics =
    describe "Test game mechanics"
        [ test "Decrease lives on ball fall" <|
            \() ->
                { model | ballPosition = { x = 10, y = 500 }, gameState = Playing }
                    |> updateGame
                    |> Expect.equal { model | ballPosition = { x = 10, y = 500 }, lives = 2, gameState = BallFall }
        , test "Increase score on brick collision" <|
            \() ->
                { model | ballPosition = { x = 80, y = 6 }, score = 1, gameState = Playing }
                    |> updateGame
                    |> Expect.equal { model | ballPosition = { x = 80, y = 6 }, score = 1, gameState = Playing }
        ]
