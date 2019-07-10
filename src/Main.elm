module Main exposing (Model, Msg(..), init, initialModel, main, update, view)

import Browser
import Counter
import Html exposing (Html, button, div, p, text)
import Html.Events exposing (onClick)
import Http


type Msg
    = Counter1Msg Counter.Msg
    | Counter2Msg Counter.Msg
    | Reset


type alias Model =
    { total : Int
    , counter1 : Counter.CounterModel
    , counter2 : Counter.CounterModel
    }


initialModel : Model
initialModel =
    { total = 0
    , counter1 = Counter.initialModel
    , counter2 = Counter.initialModel
    }


init : String -> ( Model, Cmd Msg )
init flags =
    ( initialModel, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ Counter.view model.counter1 |> Html.map Counter1Msg
        , Counter.view model.counter2 |> Html.map Counter2Msg
        , p [] []
        , String.fromInt model.total |> text
        , button [ onClick Reset ] [ text "RESET" ]
        ]


updateCounters : Counter.Msg -> Counter.CounterModel -> Counter.CounterModel -> ( Counter.CounterModel, Int )
updateCounters counterMsg counterA counterB =
    let
        newcounter =
            Counter.update counterMsg counterA

        newtotal =
            Counter.getCounterValue newcounter + Counter.getCounterValue counterB
    in
    ( newcounter, newtotal )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Counter1Msg counterMsg ->
            let
                ( newcounter1, newtotal ) =
                    updateCounters counterMsg model.counter1 model.counter2
            in
            ( { model | counter1 = newcounter1, total = newtotal }, Cmd.none )

        Counter2Msg counterMsg ->
            let
                ( newcounter2, newtotal ) =
                    updateCounters counterMsg model.counter2 model.counter1
            in
            ( { model | counter2 = newcounter2, total = newtotal }, Cmd.none )

        Reset ->
            ( initialModel, Cmd.none )


main : Program String Model Msg
main =
    Browser.element
        { view = view
        , init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }
