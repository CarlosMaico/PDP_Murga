{-# OPTIONS_GHC -Wno-overlapping-patterns #-}
{-# LANGUAGE BinaryLiterals #-}
{-# LANGUAGE NumDecimals #-}
module Library where
import PdePreludat
import Data.Type.Equality (apply)
import GHC.Base (Double, Int)
import GHC.Integer (Integer)
import GHC.Num (Num)



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
esEnergizante (Cafe "Capuchino") = True 
esEnergizante (Gaseosa "pomelo" cantAzucar) = cantAzucar > 10
esEnergizante _ = False


--Clase 4
--Aca las edades sin invocar la funcion siempre se mantiene la edad, osea la funcion utiliza el data para crear uno nuevo osea transformar pero no modifica

data Persona = Persona {nomb :: String, edad :: Number} deriving Show

julia :: Persona
julia = Persona "julia" 21

pedro :: Persona
pedro = Persona "pedro" 26

cumplirAños :: Persona -> Persona
cumplirAños persona = persona {edad = edad persona + 1}--aca le suma 1 a edad del constructor


find':: (a -> Bool) -> [a] -> a
find' condicion lista = (head.filter condicion) lista

data Politico = Politico {
    proyectosPresentados :: [String],
    sueldoo :: Number,
    edadd :: Number
} deriving Show


politicos = [Politico ["ser libres", "libre estacionamieento coches politicos","ley no fumar", "ley 19182"] 20000 81,
             Politico ["tratar de reconquistar luchas sociales"] 10000 63,
             Politico ["tolerancia 100 para delitos"] 15500 49]

type Nombre = String
type Notas = [Number]
data Alumno = Alumno {nombreAlumno :: Nombre, notas :: Notas}

promedioAlumnos :: [Alumno] -> [(Nombre, Number)]
promedioAlumnos alumnos = map (\alumno -> (nombreAlumno alumno, (promedioq.notas) alumno)) alumnos

promedioq :: Notas -> Number
promedioq notas = (sum notas) `div` (length notas)
