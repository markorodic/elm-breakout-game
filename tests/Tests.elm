module Tests exposing (..)

import Bricks exposing (assignBrickPosition)
import Constants exposing (..)
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Model exposing (..)
import Test exposing (..)


suite : Test
suite =
    describe "Basic tests for game"
        [ describe "Initialise bricks"
            [ test "assign first brick position" <|
                \() ->
                    let
                        brick =
                            { position = { x = 0, y = 0 }
                            , size = { width = 20, height = 7 }
                            }
                    in
                    Expect.equal (assignBrickPosition 0 brick) { position = { x = 10, y = 5 }, size = { width = 20, height = 7 } }
            , test "assign last brick position" <|
                \() ->
                    let
                        brick =
                            { position = { x = 0, y = 0 }
                            , size = { width = 20, height = 7 }
                            }
                    in
                    Expect.equal (assignBrickPosition 89 brick) { position = { x = 360, y = 65 }, size = { width = 20, height = 7 } }
            , test "bricks are filterd on collision" <|
                \() ->
                    let
                        ballPosition =
                            { x = 11, y = 6 }

                        oneBrickMissing =
                            brickLayout.numberOfBricks - 1
                    in
                    Expect.equal (List.length (notCollidedBricks ballPosition model.bricks)) oneBrickMissing
            ]
        ]
