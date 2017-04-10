module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (PlayerId, Route(..))
import UrlParser exposing (..)


-- import Json.Decode as Decode
-- import Html exposing (Attribute)
-- import Html.Events exposing (onWithOptions)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map PlayersRoute top
        , map PlayerRoute (s "players" </> string)
        , map PlayersRoute (s "players")
        ]


parseLocation : Location -> Route
parseLocation location =
    -- case (parsePath matchers location) of
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


playersPath : String
playersPath =
    -- "/"
    "#players"


playerPath : PlayerId -> String
playerPath playerId =
    -- "/players/" ++ playerId
    "#players/" ++ playerId



-- this is for path parser
-- onLinkClick : msg -> Attribute msg
-- onLinkClick msg =
--     let
--         options =
--             { stopPropagation = False
--             , preventDefault = True
--             }
--     in
--         onWithOptions "click" options (Decode.succeed msg)
