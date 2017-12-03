module View exposing (view)

import Constants exposing (..)
import Html exposing (Html, div, program, text)
import Html.Attributes exposing (style)
import Messages exposing (..)
import Model exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)


-- VIEW


view : Model -> Html Msg
view model =
    let
        --        paddlePosition =
        --            toString model.paddleX
        --        ballPositionX =
        --          toString model.ballPosition.x
        --    ballPositionY =
        --      toString model.ballPosition.y
        nodes =
            pad model.paddleX
                :: ball model.ballPosition.x model.ballPosition.y
                :: List.map brick model.bricks
    in
    svg [ width (toString gameAttributes.width), height (toString gameAttributes.height), Html.Attributes.style [ ( "background-color", "#efefef" ) ] ]
        nodes


pad : Int -> Svg Msg
pad x =
    block (toFloat x) paddleAttributes.yPosition paddleAttributes.width paddleAttributes.height


ball : Int -> Int -> Svg Msg
ball x y =
    block (toFloat x) (toFloat y) ballAttributes.width ballAttributes.height


brick : Brick -> Svg Msg
brick b =
    block b.position.x b.position.y b.size.width b.size.height


block : Float -> Float -> Int -> Int -> Svg Msg
block x_ y_ width_ height_ =
    rect
        [ x (toString x_)
        , y (toString y_)
        , width (toString width_)
        , height (toString height_)
        ]
        []
