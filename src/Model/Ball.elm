module Model.Ball exposing (..)

import Constants exposing (ballAttributes)


type alias BallValue =
    { x : Int
    , y : Int
    }


type alias Ball =
    { position : BallValue
    , velocity : BallValue
    }


initBall : Ball
initBall =
    { position = ballAttributes.startPosition
    , velocity = { x = 0, y = 0 }
    }
