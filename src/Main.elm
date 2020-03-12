module Main exposing (..)


import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)



-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- Data definitions

type alias Number = Float

type alias Env = List Binding

type alias Lam = {args: List String,
                  body: ExprC}

type alias Clo = {params: List String,
                  body: ExprC,
                  env: Env}

type alias App = {fun: ExprC,
                  args: List ExprC}

type Binding = Binding String Value

type Value = NumV Number
           | StringV String
           | PrimV String
           | CloV Clo

type ExprC = NumC Number
           | StringC String
           | IdC String
           | LamC Lam
           | AppC App


extendEnv : Binding -> Env -> Env
extendEnv binding env =
  binding :: env

lookupEnv : String -> Env -> Value
lookupEnv id env =
  case env of
    ((Binding sym val) :: xs) ->
      if id == sym then
        val
      else
        (lookupEnv id xs)
    _ ->
      (StringV ("Unbound identifier: " ++ id))

--  type annotation goes above function
interp : ExprC -> Env -> Value
interp expr env =
  case expr of
    NumC num ->
      NumV num

    StringC str ->
      StringV str

    IdC id ->
      lookupEnv id env

    AppC {fun, args} ->
      let
        interpedFun = interp fun env
        -- lambda uses a "\" to start
        -- interpedArgs = map (\arg -> (interp arg env)) args
        interpedArgs = List.map (\arg -> (interp arg env)) args
      in
        case interpedFun of
          PrimV op ->
            case ((StringV op) :: interpedArgs) of
              [ (StringV "+"), (NumV l), (NumV r) ] ->
                NumV (l + r)
              [ (StringV "-"), (NumV l), (NumV r) ] ->
                NumV (l - r)
              [ (StringV "/"), (NumV l), (NumV r) ] ->
                NumV (l / r)
              [ (StringV "*"), (NumV l), (NumV r) ] ->
                NumV (l * r)
              _ ->
                StringV "unimplemented"

          _ ->
            StringV "Also unimplemented"


-- deconstruct record with {record_field,record_field,...}
    LamC {args, body} ->
    -- create record with (record_name args ...)
      CloV (Clo args body env)












-- ignore everything below this line, it is from the demo code
type alias Model = Number

init : Model
init =
  0

add1 : Number -> Number
add1 num = 
    num + 1


update : ExprC -> Model -> Model
update expr model =
  case expr of
    NumC num ->
      model + num

    StringC str ->
      model - 1

    IdC id ->
      model - 1

    LamC _ ->
      model - 1
    
    _ ->
      model - 1



-- VIEW


view : Model -> Html ExprC
view model =
  div []
    [ button [ onClick (NumC 5) ] [ text "numC" ]
    , div [] [ text (String.fromFloat model) ]
    , button [ onClick (StringC "string") ] [ text "stringC" ]
    ]