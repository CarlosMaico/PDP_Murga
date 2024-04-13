module Library where
import PdePreludat
import Data.Type.Equality (apply)
import GHC.Base (Double)

doble :: Number -> Number
doble numero = numero + numero


multiplicar :: Number -> Number -> Number
multiplicar num1 num2 = num1 * num2


--COMPOSICION
largoListon = 300

cuadruple :: Number -> Number
cuadruple num = num* 4
maderaParaCuadro = cuadruple

meAlcanza :: Number -> Bool
meAlcanza largo = largo <= largoListon

--puedoHacerCuadrDe lado = meAlcanza (maderaParaCuadro lado)

puedoHacerCuadroDe  =  meAlcanza.maderaParaCuadro

quePorcentajeSobra = porcentajeDeListon.cuantoMeSobra.maderaParaCuadro

cuantoMeSobra :: Number -> Number
cuantoMeSobra cantidad = largoListon - cantidad

porcentajeDeListon cantidad = (cantidad/largoListon) * 100

--

--Tarea

--1)

calcular' :: (Number, Number) -> (Number, Number)
calcular' (primer, segundo) = (duplicaPar primer, sumaUno segundo)

duplicaPar :: Number -> Number
duplicaPar num | even num   = num * 2
               | otherwise = num

sumaUno :: Number -> Number
sumaUno  num | odd num = num + 1
             | otherwise = num
            

--Ejercio2 clase

data Empleado = Comun {sueldoBasico::Number, nombre::String}|
                Jefe {sueldoBasico::Number, cantPersonas::Number, nombre::String}

sueldo :: Empleado -> Number
sueldo (Comun salario _ ) = salario
sueldo (Jefe salario personal _ ) = salario + plus personal

plus :: Number -> Number
plus personalACargo = personalACargo * 5000

--Ejercicio 3 Clase
data Bebida = Cafe {nombreBebida::String} |
              Gaseosa {sabor::String, azucar::Number}

esEnergizante :: Bebida -> Bool
esEnergizante (Cafe nombreCafe) = nombreCafe == "Capuchino"
esEnergizante (Gaseosa sabor cantAzucar) = sabor == "pomelo" && cantAzucar > 10
