
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

maximaFlorSegun :: [Flor] -> (Flor -> Int) -> String
maximaFlorSegun flores function = (nombreFlor.florMaximaSegun function) flores

florMaximaSegun :: (Flor -> Int) -> [Flor] -> Flor
florMaximaSegun _ [flor] = flor
florMaximaSegun function (x: xs) | function x > function (florMaximaSegun function xs) = x
                                 | otherwise = florMaximaSegun function xs