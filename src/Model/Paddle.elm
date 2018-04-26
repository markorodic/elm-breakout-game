module Model.Paddle exposing (..)


type alias InitPaddle =
    { position : Int
    , velocity : Int
    }


initPaddle : InitPaddle
initPaddle =
    { position = 200
    , velocity = 0
    }
