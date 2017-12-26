module Constants exposing (..)


gameAttributes =
    { width = 400
    , height = 400
    }


paddleAttributes =
    { width = 30
    , height = 3
    , yPosition = 395
    }


ballAttributes =
    { width = 3
    , height = 3
    , velocity = 4
    , startPosition = { x = 200, y = 200 }
    }


brickAttributes =
    { width = 20
    , height = 7
    }


brickLayout =
    { numberOfBricks = 90
    , xMargin = 10
    , yMargin = 5
    , padding = 5
    , bricksPerLine = 15
    }
