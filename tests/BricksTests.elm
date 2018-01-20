module BricksTests exposing (bricks)

import Bricks exposing (..)
import Constants exposing (..)
import Expect exposing (..)
import Model exposing (..)
import Test exposing (Test, describe, test)
import Update exposing (..)


bricks : Test
bricks =
    describe "Test brick initialization and removal"
        [ test "assign first brick position" <|
            \() ->
                { position = { x = 0, y = 0 }, size = { width = 28, height = 10 }, row = 0 }
                    |> assignBrickPosition 0
                    |> Expect.equal { position = { x = 0, y = 30 }, size = { width = 28, height = 10 }, row = 0 }
        , test "assign last brick position" <|
            \() ->
                { position = { x = 0, y = 0 }, size = { width = 28, height = 10 }, row = 0 }
                    |> assignBrickPosition 83
                    |> Expect.equal { position = { x = 364, y = 80 }, size = { width = 28, height = 10 }, row = 5 }
        , test "bricks are filterd on collision" <|
            \() ->
                { model | ballPosition = { x = 50, y = 30 } }
                    |> notCollidedBricks
                    |> List.length
                    |> Expect.equal (brickLayout.numberOfBricks - 1)
        ]
