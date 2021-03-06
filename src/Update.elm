module Update exposing (..)

import Msgs exposing (Msg)
import Models exposing (Model, Player)
import Routing exposing (parseLocation)
import Navigation exposing (newUrl)
import Commands exposing (savePlayerCmd)
import RemoteData
import Material


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchPlayers response ->
            ( { model | players = response }, Cmd.none )

        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )

        Msgs.ChangeLocation path ->
            ( model, Navigation.newUrl path )

        Msgs.ChangeLevel player level ->
            let
                updatedPlayer =
                    { player | level = player.level + level }
            in
                ( model, savePlayerCmd updatedPlayer )

        Msgs.OnPlayerSave (Ok player) ->
            ( updatePlayer model player, Cmd.none )

        Msgs.OnPlayerSave (Err player) ->
            ( model, Cmd.none )

        Msgs.Mdl msg_ ->
            Material.update Msgs.Mdl msg_ model


updatePlayer : Model -> Player -> Model
updatePlayer model updatedPlayer =
    let
        pick currentPlayer =
            if updatedPlayer.id == currentPlayer.id then
                updatedPlayer
            else
                currentPlayer

        updatePlayerList players =
            List.map pick players

        -- RemoteData.map applies only when RemoteData.success
        updatedPlayers =
            RemoteData.map updatePlayerList model.players
    in
        { model | players = updatedPlayers }
