module View exposing (view)

import Bricks exposing (..)
import Constants exposing (..)
import Element exposing (column, el, empty, layout, link, row, screen, text, within)
import Element.Attributes exposing (px, percent, alignBottom, alignRight, center, height, padding, spacing, spacingXY, verticalCenter, width)
import Html exposing (Html)
import Messages exposing (..)
import Model exposing (..)
import StyleSheet exposing (..)


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
            [ center, height (px 400), width (percent 100) ]
            [ row Text
                [ height (px 52), spacing 80, alignBottom ]
                [ text (toString model.score)
                , text (toString model.lives)
                ]
            , column Game
                [ width (px 500), height (px 300) ]
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
        (Bricks (assignBrickColour b.rank))


assignBrickColour rank =
    case rank of
        0 ->
            One

        1 ->
            Two

        2 ->
            Three

        3 ->
            Four

        4 ->
            Five

        5 ->
            Six

        _ ->
            One


makeBlock x_ y_ width_ height_ styleClass =
    el
        styleClass
        [ Element.Attributes.width (Element.Attributes.px width_)
        , Element.Attributes.height (Element.Attributes.px height_)
        , spacingXY x_ y_
        ]
        empty
