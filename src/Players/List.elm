module Players.List exposing (..)

import Html exposing (..)
import Msgs exposing (Msg)
import Models exposing (Player)
import RemoteData exposing (WebData)
import Routing exposing (playerPath)
import Material.Card as Card
import Material.Table as Table
import Material.Button as Button
import Material.Options exposing (css)
import Material.Color as Color


view : Models.Model -> Html Msg
view model =
    Card.view [ css "width" "100%" ]
        [ Card.title
            [ Color.background (Color.color Color.Grey Color.S500) ]
            [ Card.head [ Color.text Color.white ] [ text "Players" ] ]
        , Card.text [] [ maybeList model ]
        ]


maybeList : Models.Model -> Html Msg
maybeList model =
    case model.players of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success players ->
            list players model

        RemoteData.Failure error ->
            text (toString error)


nav : Html Msg
nav =
    Card.view
        [ css "width" "100%"
        , Color.background (Color.color Color.Grey Color.S500)
        ]
        [ Card.title [] [ Card.head [ Color.text Color.white ] [ text "Players" ] ]
        ]


list : List Player -> Models.Model -> Html Msg
list players model =
    Table.table [ css "width" "600px" ]
        [ Table.thead []
            [ Table.tr []
                [ Table.th [] [ text "Id" ]
                , Table.th [] [ text "Name" ]
                , Table.th [] [ text "Level" ]
                , Table.th [] [ text "Actions" ]
                ]
            ]
        , Table.tbody [] (List.map (playerRow model) players)
        ]


playerRow : Models.Model -> Player -> Html Msg
playerRow model player =
    Table.tr []
        [ Table.td [] [ text player.id ]
        , Table.td [] [ text player.name ]
        , Table.td [] [ text (toString player.level) ]
        , Table.td [] [ editBtn model player ]
        ]


editBtn : Models.Model -> Player -> Html Msg
editBtn model player =
    let
        path =
            playerPath player.id
    in
        Button.render Msgs.Mdl
            [ 0 ]
            model.mdl
            [ Material.Options.onClick (Msgs.ChangeLocation path)
            , Button.raised
            ]
            [ text "Edit" ]
