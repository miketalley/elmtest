module Main exposing (..)

import Html exposing (Html, div, text, program)
import Mouse
import Keyboard

-- Model
type alias Model =
  { count : Int
  , event : String
  }

initialModel =
  { count = 0
  , event = "None"
  }

init : ( Model, Cmd Msg )
init =
  ( initialModel, Cmd.none )

-- Messages
type Msg
  = MouseMsg Mouse.Position
  | KeyMsg Keyboard.KeyCode

-- View
view : Model -> Html Msg
view model =
  div []
    [ text (toString model.count)
    , text (toString model.event)
    ]

-- Update
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    MouseMsg position ->
      ( { model |
          count = model.count + 1,
          event = "Mouse Click"
        }, Cmd.none )
    KeyMsg code ->
      ( { model |
          count = model.count + 2,
          event = "Key Press"
        }, Cmd.none )

-- Subscriptions
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ Mouse.clicks MouseMsg
    , Keyboard.downs KeyMsg
    ]

-- Main
main : Program Never Model Msg
main =
  program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
