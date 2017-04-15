module Msgs exposing (..)

import Models exposing (Player)
import Navigation exposing (Location)
import RemoteData exposing (WebData)
import Http
import Material


type alias Mdl =
    Material.Model


type Msg
    = OnFetchPlayers (WebData (List Player))
    | ChangeLocation String
    | OnLocationChange Location
    | ChangeLevel Player Int
    | OnPlayerSave (Result Http.Error Player)
    | Mdl (Material.Msg Msg)
