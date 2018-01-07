module Constants exposing (..)


gameAttributes =
    { width = 448
    , height = 400
    }


paddleAttributes =
    { width = 60
    , height = 5
    , yPosition = 270
    }


ballAttributes =
    { width = 5
    , height = 5
    , velocity = 4
    , startPosition = { x = 200, y = 200 }
    }


brickAttributes =
    { width = 32
    , height = 10
    }


brickLayout =
    { numberOfBricks = 84
    , xMargin = 0
    , yMargin = 40
    , padding = 0
    , bricksPerLine = 14
    }
