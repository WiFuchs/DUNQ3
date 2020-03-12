module Example exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import Main exposing (..)

topEnv : Env 
topEnv = [(Binding "+" (PrimV "+"))]

suite : Test
suite =
    describe "Interp Tests"
    [test "numbers"
        (\_ -> Expect.equal 4 (2+2)),
    test "add 1"
        (\_ -> Expect.equal 3 (add1 2)),
    test "test NumV"
        (\_ -> Expect.equal (interp (NumC 2) topEnv) (NumV 2)),
    test "test StringV"
        (\_ -> Expect.equal (interp (StringC "test") topEnv) (StringV "test")),
    test "test IdC"
        (\_ -> Expect.equal (interp (IdC "t") (extendEnv (Binding "t" (StringV "test")) topEnv)) (StringV "test")),
    test "test LamC"
        (\_ -> Expect.equal (interp (LamC (Lam ["x"] (StringC "test"))) topEnv) (CloV (Clo ["x"] (StringC "test") topEnv)))]
