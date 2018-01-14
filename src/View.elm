module View exposing (view)

import Bricks exposing (..)
import Constants exposing (..)
import Element exposing (column, el, empty, layout, link, modal, row, screen, text, within)
import Element.Attributes exposing (alignBottom, center, fillPortion, height, padding, percent, px, spacing, spacingXY, verticalCenter, width)
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
        screen
            (el WindowBackground
                [ height (fillPortion 1), width (percent 100) ]
                (modal
                    GameBackground
                    [ center, verticalCenter, width (percent 100) ]
                    (column GameBackground
                        [ center, height (percent 100), width (percent 100) ]
                        [ row Text
                            [ height (px 52), width (px 400), center, spacing 80, alignBottom ]
                            [ text (toString model.score)
                            , text (toString model.lives)
                            ]
                        , column Game
                            [ center, verticalCenter, width (px 400), height (px 400) ]
                            [ if model.gameState == Dead then
                                text "Game Over"
                              else
                                empty
                            ]
                            |> within
                                nodes
                        ]
                    )
                )
            )


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
        (Bricks (assignBrickColour b.row))


assignBrickColour : Int -> Colours
assignBrickColour row =
    case row of
        0 ->
            Red

        1 ->
            Tomato

        2 ->
            Orange

        3 ->
            Yellow

        4 ->
            Green

        5 ->
            Purple

        _ ->
            Purple


makeBlock x_ y_ width_ height_ styleClass =
    el
        styleClass
        [ Element.Attributes.width (Element.Attributes.px width_)
        , Element.Attributes.height (Element.Attributes.px height_)
        , spacingXY x_ y_
        ]
        empty
