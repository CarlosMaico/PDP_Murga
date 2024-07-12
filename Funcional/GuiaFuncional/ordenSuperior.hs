--1
sumLista :: [Int] -> Int
sumLista = sum

--2


frecuenciasCardiaca :: [Int]
frecuenciasCardiaca = [80, 100, 120, 128, 130, 123, 125]

promedioFrecuenciaCardiaca lista = sum lista / 7

frecuenciaCardiacaMinuto :: Int -> Int
frecuenciaCardiacaMinuto minuto = frecuenciasCardiaca !! frecuenciaEnMinuto minuto

frecuenciaEnMinuto :: Int -> Int
frecuenciaEnMinuto minuto = minuto `div` 10


frecuenciaHastaMomento :: Int -> [Int]
frecuenciaHastaMomento minuto = take (frecuenciaEnMinuto minuto +1) frecuenciasCardiaca

--3
esCapicua :: [String] -> Bool
esCapicua listaPalabras = ((concat listaPalabras ==).reverse . concat) listaPalabras

--4

data Llamadas = Llamadas {
    horario :: String,
    tiemposDeLLamadas :: [Int] 
}

duracionLlamadas :: ((String, [Integer]), (String, [Integer]))
duracionLlamadas = (("horarioReducido", [20,10,25,15]), ("horarioNormal", [10,5,8,2,9,10]))

cuandoHabloMasMinutos :: ((String, [Integer]), (String, [Integer])) -> String
cuandoHabloMasMinutos ((primerHorario,llamadas1), (segundoHorario, llamadas2)) | sum llamadas1 > sum llamadas2 = primerHorario
                                                                               | otherwise = segundoHorario

cuandoHizoMasLLamadas :: ((String, [Integer]), (String, [Integer])) -> String
cuandoHizoMasLLamadas ((primerHorario,llamadas1), (segundoHorario, llamadas2)) | length llamadas1 > length llamadas2 = primerHorario
                                                                               | otherwise = segundoHorario


--ORdenSuperior

--1
existsAny :: (a->Bool) -> (a,a,a) -> Bool
existsAny condicion (elem1, elem2, elem3) = condicion elem1 || condicion elem2 || condicion elem3

--2
mejor :: Ord a => (t -> a) -> (t -> a) -> t -> a
mejor f1 f2 numero = max (f1 numero) (f2 numero) 
cuadrado numero = numero * numero
triple = (*3)

--3
aplicarPar :: (t -> b) -> (t, t) -> (b, b)
aplicarPar f (elem1, elem2) = (f elem1, f elem2)
doble = (*2)


--4
parDeFns :: (t -> a) -> (t -> b) -> t -> (a, b)
parDeFns f1 f2 valor = (f1 valor, f2 valor)


--OrdenSuperiosYListas
--1
esMultiploDeAlguno :: Int -> [Int] -> Bool 
esMultiploDeAlguno numero = any (esMultiplo numero)

esMultiplo :: Int -> Int-> Bool
esMultiplo numero1 numero2 = (numero1 `mod` numero2) == 0 

--2
promedios :: [[Double]] -> [Double]
promedios = map promedio

promedio :: [Double] -> Double
promedio notas = sum notas / fromIntegral (length notas) 

--3
promediosSinAplazos :: [[Double]] -> [Double]
promediosSinAplazos = map (promedio.filter (>4))

--4
mejoresNotas :: [[Double]] -> [Double]
mejoresNotas = map maximum

--5
aprobo :: [Int] -> Bool
aprobo = all (>=6)

--6
aprobaron :: [[Int]] -> [[Int]]
aprobaron  = filter aprobo

--7
divisores :: Int -> [Int]
divisores numero = [x | x <- [1..numero], numero `mod` x == 0]

--8
exists :: (a -> Bool) -> [a] -> Bool
exists = any 

--9
hayAlgunNegativo :: [Int] -> (Int -> Bool) -> Bool
hayAlgunNegativo = flip any

--10

aplicarFunciones :: [a->b] -> a -> [b]
aplicarFunciones listaFunciones valor =  map ($ valor) listaFunciones 

--11

sumaF :: Num b => [a -> b] -> a -> b
sumaF listaF valor = sum (map ($ valor) listaF)

--12
subirHabilidad :: Int -> [Int] -> [Int]
subirHabilidad numero = map (min 12 .(+ numero))

--13
flimitada :: (Int -> Int) -> Int -> Int
flimitada funcion valor = max 0 (min 12 (funcion valor))


cambiarHabilidad :: (Int -> Int) -> [Int] -> [Int]
cambiarHabilidad unaFuncion = map (flimitada unaFuncion)

--ghci> cambiarHabilidad (max 4) [2,4,5,3,8]
--[4,4,5,4,8]

--14
--15
primerosPares :: [Int] -> [Int]
primerosPares  = takeWhile even

primerosDivisores :: Int -> [Int] -> [Int]
primerosDivisores valor =  takeWhile (\x -> valor `mod` x == 0) 

primerosNoDivisores :: Int -> [Int] -> [Int]
primerosNoDivisores valor = takeWhile (not.(\x -> valor `mod` x == 0))


--16
huboMesMejorDe :: [Int] -> [Int] -> Int -> Bool
huboMesMejorDe listaIngresos listaEgresos valor = any (>valor) (zipWith (-) listaIngresos listaEgresos)

--17
crecimientoAnual :: Int -> Int
crecimientoAnual edad | edad > 1 && edad <10 = 24- (edad*2)
                      | edad >=10 && edad <=15 = 4
                      | edad >=16 && edad <=17 = 2
                      | edad >=18 && edad <=19 = 1
                      | otherwise = 0

crecimientoEntreEdades :: Int -> Int -> Int
crecimientoEntreEdades edadInicio edadFin = sum $ map crecimientoAnual [edadInicio..edadFin-1] 

alturasEnUnAnio :: Int -> [Int] -> [Int]
alturasEnUnAnio edad = map (+ crecimientoAnual edad)

alturaEnEdades :: Int -> Int -> [Int] -> [Int]
alturaEnEdades altura edadActual = map (\edadF -> altura + crecimientoEntreEdades edadActual edadF) 

--18

lluviasEnero :: [Int]
lluviasEnero = [0,2,5,1,34,2,0,21,0,0,0,5,9,18,14,0]

rachasLluvia :: [Int] -> [[Int]]
rachasLluvia [] = []
rachasLluvia (x:xs) | x == 0 = rachasLluvia (dropWhile( == 0) xs)
                    | otherwise = let (lluvia,resto) = span (>0) (x:xs)
                                  in lluvia : rachasLluvia resto

mayorRachaDeLluvias ::  [Int] -> Int
mayorRachaDeLluvias  = maximum . map length . rachasLluvia 

--19
sumaListaNum :: [Int] -> Int
sumaListaNum = foldl (+) 0
sumaListaNumr :: [Int] -> Int
sumaListaNumr = foldr (+) 0

--20
productoria :: [Int] -> Int
productoria = foldl (*) 1

productoriar :: [Int] -> Int
productoriar= foldr (*) 1

--21
dispersion :: [Int] -> Int
dispersion [] = 1
dispersion lista = maximum lista - minimum lista