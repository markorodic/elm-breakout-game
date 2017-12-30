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
                { model | ballPosition = { x = 200, y = 400 } }
                    |> updateGame
                    |> Expect.equal { model | ballPosition = { x = 200, y = 400 }, lives = 2 }
        , test "Increase score on brick collision" <|
            \() ->
                { model | ballPosition = { x = 11, y = 6 } }
                    |> updateGame
                    |> Expect.equal { model | ballPosition = { x = 11, y = 6 }, score = 1 }
        ]
