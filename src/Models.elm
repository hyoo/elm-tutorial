module Models exposing (..)

import RemoteData exposing (WebData)
import Material


type alias Model =
    { players : WebData (List Player)
    , mdl : Material.Model
    , route : Route
    }


initialModel : Route -> Model
initialModel route =
    { players = RemoteData.Loading
    , mdl = Material.model
    , route = route
    }


type alias PlayerId =
    String


type alias Player =
    { id : PlayerId
    , name : String
    , level : Int
    }


type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute
