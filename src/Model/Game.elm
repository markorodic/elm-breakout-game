module Model.Game
    exposing
        ( GameState(..)
        , InitGame
        , initGame
        )


type alias InitGame =
    { score : Int
    , lives : Int
    , state : GameState
    }


initGame : InitGame
initGame =
    { score = 0
    , lives = 3
    , state = Start
    }


type GameState
    = Start
    | Play
    | Gameover



-- | Pause
