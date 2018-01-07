module Constants exposing (..)


gameAttributes =
    { width = 448
    , height = 400
    , score = 0
    , lives = 3
    }


paddleAttributes =
    { width = 60
    , height = 5
    , yPosition = 270
    , startPosition = 194
    }


ballAttributes =
    { width = 5
    , height = 5
    , velocity = 4
    , startPosition = { x = 224, y = 150 }
    }


brickAttributes =
    { width = 32
    , height = 10
    }


brickLayout =
    { numberOfBricks = 84
    , xMargin = 0
    , yMargin = 30
    , padding = 0
    , bricksPerLine = 14
    }
