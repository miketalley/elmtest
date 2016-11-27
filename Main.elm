module Main exposing (..)

import Html exposing (Html, program)
import Widget

-- Model
type alias AppModel =
  { widgetModel : Widget.Model
  }

initialModel : AppModel
initialModel =
  { widgetModel = Widget.initialModel
  }

init : ( AppModel, Cmd Msg )
init =
  ( initialModel, Cmd.none )

-- Messages
type Msg
  = WidgetMsg Widget.Msg

-- View
view : AppModel -> Html Msg
view model =
  Html.div []
    [ Html.map WidgetMsg (Widget.view model.widgetModel)
    ]

-- Update
update : Msg -> AppModel -> ( AppModel, Cmd Msg )
update message model =
  case message of
    WidgetMsg subMsg ->
      let
        ( updateWidgetModel, widgetCmd ) =
          Widget.update subMsg model.widgetModel
      in
        ( { model | widgetModel = updateWidgetModel }, Cmd.map WidgetMsg widgetCmd)

-- Subscriptions
subscriptions : AppModel -> Sub Msg
subscriptions model =
  Sub.none

-- App
main : Program Never AppModel Msg
main =
  program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
