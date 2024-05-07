--1
esMultiploDeTres :: Int -> Bool
esMultiploDeTres numero = numero `mod` 3 == 0

--2
esMultiploDe :: Int -> Int -> Bool
esMultiploDe unNumero otroNumero = otroNumero `mod` unNumero == 0

--3
cubo :: Int -> Int
cubo numero = numero^3

--4
area :: Int -> Int -> Int
area base altura = base * altura

--5
esBisiesto :: Int -> Bool
esBisiesto año = esMultiploDe 400 año || esMultiploDe 4 año

--6
celsiusToFahr :: Double -> Double
celsiusToFahr temperaturaCelsius = (1.8*temperaturaCelsius) + 32

--7
fharToCelsius :: Double -> Double
fharToCelsius temperaturaFhar = (temperaturaFhar -32) * 5/9

--8
haceFrio :: Double -> Bool
haceFrio temperaturaFhar = (temperaturaFhar -32) * 5/9 < 8

--9
mcm :: Int -> Int -> Int
mcm num1 num2 = (num1 * num2) `div` gcd num1 num2

--10
dispersion :: Int -> Int -> Int -> Int
dispersion medicion1 medicion2 medicion3 = 
                  ((medicion1 `max` medicion2) `max` medicion3) - ((medicion1`min`medicion2) `min`medicion3)

diasParejos :: Int -> Int -> Int -> Bool
diasParejos medicion1 medicion2 medicion3 = dispersion medicion1 medicion2 medicion3 < 30

diasLocos :: Int -> Int -> Int -> Bool
diasLocos medicion1 medicion2 medicion3 = dispersion medicion1 medicion2 medicion3 > 100

diasNormales :: Int -> Int -> Int -> Bool
diasNormales medicion1 medicion2 medicion3 = 
     not(diasParejos medicion1 medicion2 medicion3) && not(diasLocos medicion1 medicion2 medicion3)

--11
pesoPino :: Int -> Int
pesoPino alturaPino | alturaPino <= 300 = 3 * alturaPino
                    | otherwise = 2 * alturaPino 

esPesoUtil :: Int -> Bool
esPesoUtil peso = peso <= 1000 && peso >= 400

sirvePino :: Int -> Bool
sirvePino alturaPino = (esPesoUtil.pesoPino) alturaPino


--12
sumaNumerosImpares :: Int -> Int -> Int
sumaNumerosImpares num1 num2 = sum [num2, num2 + 2 .. num2 +2 * (num1 -1)]

esCuadradoPerfecto :: Int -> Bool
esCuadradoPerfecto numero = numero `elem` [x*x | x<-[0..numero]] --Explicar la lista por comprension

numerosPares :: [Int] -> [Int]
numerosPares numeros = [num | num<- numeros, even num]

esCuadradoPerfectot :: Int -> Bool
esCuadradoPerfectot n
    | n < 0 = False
    | n == 0 = True
    | otherwise = esCuadradoPerfectoAux n 1 1

esCuadradoPerfectoAux :: Int -> Int -> Int -> Bool
esCuadradoPerfectoAux n sumaParcial cuadradoActual
    | cuadradoActual == n = True
    | cuadradoActual > n = False
    | otherwise = esCuadradoPerfectoAux n (sumaParcial + 2) (cuadradoActual + sumaParcial)