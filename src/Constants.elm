module Constants exposing (..)


gameAttributes =
    { width = 500
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
