module Msgs exposing (..)

import Models exposing (Player)
import Navigation exposing (Location)
import RemoteData exposing (WebData)
import Http


type Msg
    = OnFetchPlayers (WebData (List Player))
    | ChangeLocation String
    | OnLocationChange Location
    | ChangeLevel Player Int
    | OnPlayerSave (Result Http.Error Player)
