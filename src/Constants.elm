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
    , velocity = 2
    , startPosition = { x = 180, y = 200 }
    }


brickAttributes =
    { width = 26
    , height = 10
    }


brickLayout =
    { numberOfBricks = 84
    , yMargin = 30
    , bricksPerLine = 14
    }


brickPoints =
    { low = 1
    , middle = 4
    , high = 7
    }
