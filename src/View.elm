module View exposing (view)

import Bricks exposing (..)
import Constants exposing (..)
import Element exposing (column, el, empty, layout, link, row, screen, text, within)
import Element.Attributes exposing (alignBottom, alignRight, center, height, padding, spacing, spacingXY, verticalCenter, width)
import Html exposing (Html, div, program, span, text)
import Html.Attributes exposing (style)
import Messages exposing (..)
import Model exposing (..)
import StyleSheet exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)


-- VIEW


view : Model -> Html Msg
view model =
    let
        nodes =
            displayPaddle (toFloat model.paddleX)
                :: displayBall model.ballPosition.x model.ballPosition.y
                :: List.map displayBricks model.bricks
    in
    layout stylesheet <|
        column Background
            []
            [ row Text
                []
                [ Element.text "Lives: "
                , Element.text (toString model.score)
                , Element.text "Score: "
                , Element.text (toString model.lives)
                ]
            , column Game
                [ Element.Attributes.width (Element.Attributes.px 400), Element.Attributes.height (Element.Attributes.px 400) ]
                [ empty ]
                |> within
                    nodes
            ]


displayBall x y =
    makeBlock
        (toFloat x)
        (toFloat y)
        ballAttributes.width
        ballAttributes.height
        StyleSheet.Ball


displayPaddle x =
    makeBlock x paddleAttributes.yPosition paddleAttributes.width paddleAttributes.height Paddle


displayBricks b =
    makeBlock
        (toFloat b.position.x)
        (toFloat b.position.y)
        (toFloat b.size.width)
        (toFloat b.size.height)
        Bricks


makeBlock x_ y_ width_ height_ styleClass =
    el
        styleClass
        [ Element.Attributes.width (Element.Attributes.px width_)
        , Element.Attributes.height (Element.Attributes.px height_)
        , spacingXY x_ y_
        ]
        empty
