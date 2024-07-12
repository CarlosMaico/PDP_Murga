--1
fst3 :: (Int, Int, Int) -> Int
fst3 (numero, _ , _) = numero

snd3 :: (Int, Int, Int) -> Int
snd3 (_ , otroNumero , _) = otroNumero

trd3 :: (Int, Int, Int) -> Int
trd3 (_ , _ , otroNumero) = otroNumero

--2
aplicar :: (Int -> Int, Int -> Int) -> Int -> (Int, Int)
aplicar (funcion, otraFuncion) numero = (funcion numero, otraFuncion numero)

doble :: Int -> Int
doble numero = numero * 2

triple :: Int -> Int
triple numero = numero * 3

--3
cuentaBizarra :: (Int, Int) -> Int
cuentaBizarra (numero, otroNumero) | numero > otroNumero = numero + otroNumero
                                   | otroNumero - numero > 10 = otroNumero - numero
                                   | otherwise = numero * otroNumero

--4
type Notas = (Int,Int)

esNotaBochazo :: Int -> Bool
esNotaBochazo nota = nota < 6

aprobo :: Notas -> Bool
aprobo (nota, otraNota) =  (not.esNotaBochazo) nota && (not.esNotaBochazo)otraNota 

promociono :: Notas -> Bool
promociono (nota, otraNota) = nota >= 7 && otraNota >=7


--(not . esNotaBochazo . fst) (5,8)

--5
type NotasYRecus = ((Int, Int), (Int, Int))

notasFinales :: NotasYRecus -> Notas
notasFinales ((parc1,parc2),(recu1, recu2)) | parc1 >= recu1 && recu2 >= parc2 = (parc1,recu2)
                                            | recu1 >= parc1 && parc2 >= recu2 = (recu1,parc2)
                                            | recu1 >= parc1 && recu2 >= parc2 = (recu1,recu1)
                                            | otherwise = (parc1,parc2)

notasFinales' :: NotasYRecus -> Notas
notasFinales' ((parc1 , parc2),(recu1,recu2)) = (max parc1 recu1, max parc2 recu2)

--(aprobo . notasFinales') ((2,7),(6,-1))
--notasFinales' ((2,7),(6,-1))    


recuperoDeGusto :: NotasYRecus -> Bool
recuperoDeGusto notasConRecus = promociono (fst notasConRecus) 

--6
esMAyorDeEdad :: (String, Int) -> Bool
esMAyorDeEdad persona = ((> 21).snd) persona

--7
calcular :: (Int, Int) -> (Int, Int)
calcular (numero, otroNumero) | (even . fst) (numero, otroNumero) && (odd . snd) (numero, otroNumero) =  (numero *2, otroNumero + 1)
                              | (even.fst) (numero, otroNumero) = (numero * 2, otroNumero)
                              | (odd.snd) (numero, otroNumero) = (numero, otroNumero + 1)
                              | otherwise  = (numero, otroNumero)
