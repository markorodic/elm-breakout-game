module Constants exposing (..)


gameAttributes =
    { width = 364
    , height = 400
    , score = 0
    , lives = 3
    }


paddleAttributes =
    { width = 60
    , height = 5
    , yPosition = 395
    , startPosition = round 152
    }


ballAttributes =
    { width = 5
    , height = 5
    , velocity = 4
    , startPosition = { x = 180, y = 200 }
    }


brickAttributes =
    { width = 26
    , height = 10
    }


brickLayout =
    { numberOfBricks = 84
    , xMargin = 0
    , yMargin = 30
    , padding = 0
    , bricksPerLine = 14
    }
