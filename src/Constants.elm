module Constants exposing (..)


gameAttributes =
    { width = 392
    , height = 500
    , score = 0
    , lives = 3
    }


paddleAttributes =
    { width = 60
    , height = 5
    , yPosition = 495
    , startPosition = 220
    }


ballAttributes =
    { width = 5
    , height = 5
    , velocity = 2
    , startPosition = { x = 160, y = 275 }
    }


brickAttributes =
    { width = 28
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
