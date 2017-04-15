module Players.Edit exposing (..)

import Html exposing (..)
import Msgs exposing (Msg)
import Models exposing (Player)
import Routing exposing (playersPath)
import Material.Card as Card
import Material.Button as Button
import Material.Icon as Icon
import Material.Options
import Material.Elevation as Elevation
import Material.Grid exposing (grid, cell, size, Device(..))


view : Models.Model -> Player -> Html Msg
view model player =
    Card.view
        [ Material.Options.css "width" "600px"
        , Material.Options.css "flex-grow" "1"
        , Elevation.e2
        ]
        [ Card.title [] [ Card.head [] [ text player.name ] ]
        , Card.text [] [ formLevel model player ]
        , Card.actions [ Card.border ] [ listBtn model ]
        ]


formLevel : Models.Model -> Player -> Html Msg
formLevel model player =
    grid []
        [ cell [ size All 3 ] [ text "Level" ]
        , cell [ size All 4 ] [ text (toString player.level) ]
        , cell [ size All 5 ]
            [ btnLevelDecrease model player
            , btnLevelIncrease model player
            ]
        ]


btnLevelDecrease : Models.Model -> Player -> Html Msg
btnLevelDecrease model player =
    let
        message =
            Msgs.ChangeLevel player -1
    in
        Button.render Msgs.Mdl
            [ 0 ]
            model.mdl
            [ Button.minifab
            , Button.ripple
            , Material.Options.onClick message
            ]
            [ Icon.i "remove" ]


btnLevelIncrease : Models.Model -> Player -> Html Msg
btnLevelIncrease model player =
    let
        message =
            Msgs.ChangeLevel player 1
    in
        Button.render Msgs.Mdl
            [ 1 ]
            model.mdl
            [ Button.minifab
            , Button.ripple
            , Material.Options.onClick message
            ]
            [ Icon.i "add" ]


listBtn : Models.Model -> Html Msg
listBtn model =
    Button.render Msgs.Mdl
        [ 2 ]
        model.mdl
        [ Material.Options.onClick (Msgs.ChangeLocation playersPath)
        , Button.raised
        ]
        [ text "List" ]
