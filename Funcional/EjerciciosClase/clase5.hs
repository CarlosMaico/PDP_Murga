data Flor = Flor {nombreFlor :: String,
                  aplicacion :: String,
                  cantidadDeDemanda::Int} deriving Show

rosa :: Flor
rosa = Flor "rosa" "decorativo" 120
jazmin :: Flor
jazmin = Flor "jazmin" "aromatizante" 100
violeta :: Flor
violeta = Flor "violeta" "infusion" 110
orquidea :: Flor
orquidea = Flor "orquidea" "decorativo" 90

flores :: [Flor]
flores = [orquidea, rosa, violeta, jazmin]

--1.a
maximaFlorSegun :: [Flor] -> (Flor -> Int) -> String
maximaFlorSegun listaFlores function = (nombreFlor.florMaximaSegun function) listaFlores

florMaximaSegun :: (Flor -> Int) -> [Flor] -> Flor
florMaximaSegun _ [] = error "No se espera lista vacia"
florMaximaSegun _ [flor] = flor
florMaximaSegun function (x: xs) | function x >= function (florMaximaSegun function xs) = x
                                 | otherwise = florMaximaSegun function xs

--a ghci> maximaFlorSegun flores cantidadDeDemanda 
--"rosa"

--b ghci> maximaFlorSegun flores (length.nombreFlor) 
--"orquidea"

--cghci> maximaFlorSegun flores ((`mod` 4).cantidadDeDemanda )
--"orquidea"

--1.b

estaOrdenado :: [Flor] -> Bool
estaOrdenado [] = True
estaOrdenado [_] = True
estaOrdenado (flor1:flor2:resto) = 
    cantidadDeDemanda flor1 > cantidadDeDemanda flor2 && estaOrdenado (flor2:resto)

esCreciente :: Ord a => [a] -> Bool
esCreciente [] = True
esCreciente [_] = True
esCreciente (x:y:xs) = x<y && esCreciente (y:xs)