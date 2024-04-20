

--1)
{-# OPTIONS_GHC -Wno-overlapping-patterns #-}

esNotaBochazo :: Integer -> Bool
esNotaBochazo nota = nota <6

aprobo :: (Integer,Integer) -> Bool
aprobo (nota1, nota2) = (not.esNotaBochazo) nota1 && (not.esNotaBochazo) nota2

promociono :: (Integer, Integer) -> Bool
promociono (nota1, nota2) = nota1 >= 8 && nota2 >=8


--2)
data Empleado = Comun {sueldo :: Integer, nombre:: String} |
                Jefe {sueldoBasico::Integer, cantPerACargo::Integer, nombre::String}

salario:: Empleado -> Integer
salario (Comun sueldoBasico _) = sueldoBasico
salario (Jefe sueldoBasico cantPerACargo _) = sueldoBasico + plus cantPerACargo

plus:: Integer -> Integer
plus personasACargo = 5000*personasACargo 



--3)

data Bebida = Cafe {nombreBebida::String} |
              Gaseosa {sabor::String, azucar::Integer}

esEnergizante::Bebida -> Bool
esEnergizante (Cafe nombre) = nombre == "capuchino"
esEnergizante (Gaseosa sabor azucar) = sabor == "pomelo" && azucar > 12
esEnergizante _ = False

