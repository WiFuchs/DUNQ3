module Main exposing (..)


import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)



-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- Data definitions

type alias Number = Int

type alias Env = List Binding

type alias Lam = { args: List String,
                    body: ExprC}

type alias Clo = { params: List String,
                    body: ExprC,
                    env: Env}

type alias IfC = { if: ExprC,
                    then: ExprC,
                    else: ExprC}

type Binding = Binding String Value

type Value = NumV Number
           | StringV String
           | PrimV String
           | CloV Clo

type ExprC = NumC Number
           | StringC String
           | IdC String
           | LamC Lam
           | IfC IfC


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
    
    IfC one two els ->
      

{--[(IfC if then else) (define checker (interp if env))
                        (cond
                          [(boolV? checker)
                           (cond
                             [(equal? #true (boolV-bool checker))
                              (interp then env)]
                             [else (interp else env)])]
                          [else (error 'DUNQ "error in interp, condition was not a boolean")])] --}

-- deconstruct record with {record_field,record_field,...}
    LamC {args, body} ->
    -- create record with (record_name args ...)
      CloV (Clo args body env)












-- ignore everything below this line, it is from the demo code
type alias Model = Int

init : Model
init =
  0

add1 : Int -> Int
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



-- VIEW


view : Model -> Html ExprC
view model =
  div []
    [ button [ onClick (NumC 5) ] [ text "numC" ]
    , div [] [ text (String.fromInt model) ]
    , button [ onClick (StringC "string") ] [ text "stringC" ]
    ]