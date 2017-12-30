module Tests exposing (..)

import BallTests exposing (ballUpdates)
import BricksTests exposing (bricks)
import GameTests exposing (gameMechanics)
import Test exposing (Test, describe)


suite : Test
suite =
    describe "All tests"
        [ bricks
        , ballUpdates
        , gameMechanics
        ]
