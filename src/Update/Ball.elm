module Update.Ball
    exposing
        ( hasBallFallen
        , updateBallPosition
        , updateBallVelocity
        )

import Constants exposing (ballAttributes, gameAttributes)
import Model exposing (..)
import Model.Ball exposing (Ball)
import Update.Collisions exposing (doesBallHitBrick, doesBallHitCeiling, doesBallHitPaddle, doesBallHitWall)

updateBallPosition : Model -> Model
updateBallPosition model =
    { model | ballPosition = (addVelocityToPosition model) }

addVelocityToPosition : Model -> Ball
addVelocityToPosition model =
  if hasBallFallen model then
      ballAttributes.startPosition
  else
      { x = model.ballPosition.x + model.ballVelocity.x
      , y = model.ballPosition.y + model.ballVelocity.y
      }

updateBallVelocity : Model -> Model
updateBallVelocity model =
    { model | ballVelocity = updateVelocity model }

updateVelocity : Model -> Velocity
updateVelocity model =
    if model.gameState == Playing then
      { x = updateVelocityX model
      , y = updateVelocityY model
      }
    else
      { x = 0, y = 0 }

updateVelocityX : Model -> Int
updateVelocityX model =
    if doesBallHitWall model.ballPosition then
        model.ballVelocity.x * -1
    else
        model.ballVelocity.x

updateVelocityY : Model -> Int
updateVelocityY model =
    if doesBallHitPaddle model || doesBallHitBrick model then
        model.ballVelocity.y * -1
    else if doesBallHitCeiling model.ballPosition then
        round (toFloat model.ballVelocity.y * -1.2)
    else
        model.ballVelocity.y


hasBallFallen : Model -> Bool
hasBallFallen model =
    model.ballPosition.y >= gameAttributes.height && model.gameState /= Dead
