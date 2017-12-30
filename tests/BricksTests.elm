module BricksTests exposing (bricks)

import Bricks exposing (..)
import Constants exposing (..)
import Expect exposing (..)
import Model exposing (..)
import Test exposing (Test, describe, test)


bricks : Test
bricks =
    describe "Test brick initialization and removal"
        [ test "assign first brick position" <|
            \() ->
                { position = { x = 0, y = 0 }, size = { width = 20, height = 7 } }
                    |> assignBrickPosition 0
                    |> Expect.equal { position = { x = 10, y = 5 }, size = { width = 20, height = 7 } }
        , test "assign last brick position" <|
            \() ->
                { position = { x = 0, y = 0 }, size = { width = 20, height = 7 } }
                    |> assignBrickPosition 89
                    |> Expect.equal { position = { x = 360, y = 65 }, size = { width = 20, height = 7 } }
        , test "bricks are filterd on collision" <|
            \() ->
                { model | ballPosition = { x = 11, y = 6 } }
                    |> notCollidedBricks
                    |> List.length
                    |> Expect.equal (brickLayout.numberOfBricks - 1)
        ]
