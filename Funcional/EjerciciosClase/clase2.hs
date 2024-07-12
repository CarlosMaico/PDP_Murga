saludar :: [Char] -> [Char]
saludar nombre = "Hola " ++ nombre :: [Char] 

sumar:: Integer -> Integer -> Integer
sumar numero otroNumero =  numero + otroNumero

siguiente :: Integer -> Integer
siguiente nro = nro + 1

calcular :: Integer -> Integer
calcular nro | even nro  = siguiente nro
             | otherwise = doble nro

signo :: Integer -> Integer
signo nro | nro == 0 = 0
          | nro < 0 = -1
          | otherwise = 1


aproboAlumno :: Integer -> Bool
aproboAlumno nota = nota >= 6

mes :: (Integer, Integer, Integer) -> Integer
mes (_, m, _) = m

--1
calcular' :: (Integer, Integer) -> (Integer, Integer)
calcular'  (primer, segundo) = (duplicaPar primer, sumaUnoImpar segundo)

duplicaPar :: Integer -> Integer
duplicaPar nro | even nro || (nro == 0) = doble nro
               | otherwise = nro

sumaUnoImpar :: Integer -> Integer
sumaUnoImpar nro | odd nro = siguiente nro
                 | otherwise = nro
 
doble :: Num a => a -> a
doble nro =  nro * 2

--2
and' :: Bool -> Bool -> Bool
and' cond1 otraCond | cond1 = otraCond
                    | otherwise = False

and'' :: Bool -> Bool -> Bool
and''  True  otraCond = otraCond
and''  _ _ = False

or' :: Bool -> Bool -> Bool
or'  True _ = True
or'  _  True = True
or' _  _ = False

or'' :: Bool -> Bool -> Bool
or'' False False = False
or'' _ _ = True

or''' :: Bool -> Bool -> Bool
or''' False unaCond = unaCond
or''' _ _ = True

--3
type Nota = Integer
type Alumno = (String, Nota, Nota, Nota)

alumno :: Alumno
alumno = ("Maico" ,6,7,8)

notaMaxima :: Alumno -> Nota
notaMaxima (_, nota, otraNota ,otraNota2) = nota `max` (otraNota `max` otraNota2)

notaMaxima' :: Alumno -> Nota
notaMaxima' (_, nota, otraNota ,otraNota2) = max nota (otraNota `max` otraNota2)

--4
cuadruple :: Integer -> Integer
cuadruple nro = doble (doble nro)

cuadruple' :: Integer -> Integer
cuadruple' = doble . doble

--5
esMayorA ::  Integer -> Bool
esMayorA nro = doble (siguiente (2 + nro)) > 10

esMayorA' :: Integer -> Bool
esMayorA' = (>10) . doble . siguiente . (+2)

--6
-- triple
-- (\nro -> nro * 3)

-- siguiente
--(\nro -> nro + 1)

-- suma
-- (\nro otroNum -> nro + otroNum)

--sumarDos
-- (\nro -> nro + 2)

--7
