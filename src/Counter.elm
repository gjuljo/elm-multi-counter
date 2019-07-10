module Counter exposing (CounterModel, Msg(..), createCounterModel, getCounterValue, initialModel, update, view)

import Html exposing (..)
import Html.Events exposing (onClick)


type Msg
    = Increment
    | Decrement


type CounterModel
    = CounterModel Int


getCounterValue : CounterModel -> Int
getCounterValue (CounterModel value) =
    value


createCounterModel : Int -> CounterModel
createCounterModel a =
    CounterModel a


initialModel : CounterModel
initialModel =
    CounterModel 0


view : CounterModel -> Html Msg
view (CounterModel value) =
    div []
        [ button [ onClick Increment ] [ text "+" ]
        , String.fromInt value |> text
        , button [ onClick Decrement ] [ text "-" ]
        ]


update : Msg -> CounterModel -> CounterModel
update msg (CounterModel value) =
    case msg of
        Increment ->
            value + 1 |> CounterModel

        Decrement ->
            value - 1 |> CounterModel
