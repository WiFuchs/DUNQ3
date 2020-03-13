module Example exposing (..)

import Expect
import Main exposing (..)
import Test exposing (..)


topEnv : Env
topEnv =
    [ Binding "+" (PrimV "+")
    , Binding "-" (PrimV "-")
    , Binding "*" (PrimV "*")
    , Binding "/" (PrimV "/")
    ]


suite : Test
suite =
    describe "Interp Tests"
        [ test "numbers"
            (\_ -> Expect.equal 4 (2 + 2))
        , test "add 1"
            (\_ -> Expect.equal 3 (add1 2))
        , test "test NumV"
            (\_ -> Expect.equal (interp (NumC 2) topEnv) (NumV 2))
        , test "test StringV"
            (\_ -> Expect.equal (interp (StringC "test") topEnv) (StringV "test"))
        , test "test IdC"
            (\_ -> Expect.equal (interp (IdC "t") (extendEnv (Binding "t" (StringV "test")) topEnv)) (StringV "test"))
        , test "test LamC"
            (\_ -> Expect.equal (interp (LamC (Lam [ "x" ] (StringC "test"))) topEnv) (CloV (Clo [ "x" ] (StringC "test") topEnv)))
        , test "test AppC with +"
            (\_ -> Expect.equal (interp (AppC (App (IdC "+") [ NumC 5, NumC 3 ])) topEnv) (NumV 8))
        , test "test AppC with -"
            (\_ -> Expect.equal (interp (AppC (App (IdC "-") [ NumC 5, NumC 3 ])) topEnv) (NumV 2))
        , test "test AppC with *"
            (\_ -> Expect.equal (interp (AppC (App (IdC "*") [ NumC 5, NumC 3 ])) topEnv) (NumV 15))
        , test "test AppC with /"
            (\_ -> Expect.equal (interp (AppC (App (IdC "/") [ NumC 6, NumC 3 ])) topEnv) (NumV 2))
        , test "If Test with error msg"
            (\_ -> Expect.equal (interp (IfC (If (BoolC True) (IdC "a") (IdC "b"))) topEnv) (StringV "Unbound identifier: a"))
        , test "If Test without error msg"
            (\_ -> Expect.equal (interp (IfC (If (BoolC True) (IdC "+") (IdC "-"))) topEnv) (PrimV "+"))
        , test "test AppC with LamC"
            (\_ -> Expect.equal (interp (AppC (App (LamC (Lam [ "x" ] (StringC "test"))) [ NumC 6 ])) topEnv) (StringV "test"))
        , test "test AppC with LamC 2"
            (\_ -> Expect.equal (interp (AppC (App (LamC (Lam [ "x", "y" ] (AppC (App (IdC "+") [ IdC "x", IdC "y" ])))) [ NumC 6, NumC 5 ])) topEnv) (NumV 11))
        ]
 