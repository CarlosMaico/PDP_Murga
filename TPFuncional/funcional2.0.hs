data Ciudad = Ciudad{
    nombre :: String,
    añoFundacion :: Double,
    atraccionesPrincipales :: [String],
    costoDeVida :: Double
} deriving Show

baradero :: Ciudad
baradero = Ciudad {nombre = "Baradero",añoFundacion = 1615.0,atraccionesPrincipales = ["Parque del Este", "Museo Alejandro Barbich"],costoDeVida = 150.0}

nullish :: Ciudad
nullish = Ciudad {nombre = "Nullish",añoFundacion = 1800.0,atraccionesPrincipales = [],costoDeVida = 140.0}

caletaOlivia :: Ciudad
caletaOlivia = Ciudad {nombre = "Caleta Olivia",añoFundacion = 1901.0,atraccionesPrincipales = ["El Gorosito", "Faro Costanera"],costoDeVida = 120.0}

seis :: Ciudad
seis = Ciudad {nombre = "6",añoFundacion = 1615.0,atraccionesPrincipales = ["Parque del Este", "Museo Alejandro Barbich"],costoDeVida = 150.0}

maipu :: Ciudad
maipu = Ciudad {nombre = "Maipu",añoFundacion = 1878.0,atraccionesPrincipales = ["Fortin Kakel"],costoDeVida = 115.0}

azul :: Ciudad
azul = Ciudad {nombre = "Azul",añoFundacion = 1832.0,atraccionesPrincipales = ["Teatro Español", "Parque Municipal Sarmiento",  "Costanera Cacique Catriel"],costoDeVida = 190.0}

{- Punto 1, Todos los integrantes -}
valorDeUnaCiudad :: Ciudad -> Double
valorDeUnaCiudad unaCiudad | ((< 1800) . añoFundacion) unaCiudad = ((*5) . (1800 -) . añoFundacion) unaCiudad
                           | (null . atraccionesPrincipales) unaCiudad = ((*2) . costoDeVida) unaCiudad
                           | otherwise = ((*3) . costoDeVida) unaCiudad

{- Punto 2, Integrante 1 -}
isVowel :: Char -> Bool
isVowel character = character `elem` "aeiouAEIOU"

tieneAlgunaAtraccionCopada :: Ciudad -> Bool
tieneAlgunaAtraccionCopada  = any (isVowel.head).atraccionesPrincipales

{- Punto 2, Integrante 2 -}
esSobria :: Int -> Ciudad -> Bool
esSobria cantDeLetras unaCiudad = (not . null . atraccionesPrincipales) unaCiudad && (all ((> cantDeLetras).length) . atraccionesPrincipales) unaCiudad

{- Punto 2 , Integrante 3 -}
ciudadConNombreRaro :: Ciudad -> Bool
ciudadConNombreRaro  = (<5) . length . nombre  

{- Punto 3, Todos los integrantes -}
sumarAtraccion ::String -> Ciudad -> Ciudad
sumarAtraccion unaAtraccion unaCiudad = unaCiudad {atraccionesPrincipales = ((++ [unaAtraccion]) . atraccionesPrincipales) unaCiudad,
                                      costoDeVida =  costoDeVida unaCiudad + ((*0.2). costoDeVida) unaCiudad }

{- Punto 3, Integrante 1 -}
crisis :: Ciudad -> Ciudad
crisis unaCiudad | (null . atraccionesPrincipales) unaCiudad = unaCiudad {costoDeVida = bajarCostoDeVida unaCiudad}
                 | otherwise = unaCiudad {atraccionesPrincipales = (init . atraccionesPrincipales) unaCiudad ,
                                          costoDeVida = bajarCostoDeVida unaCiudad }
bajarCostoDeVida :: Ciudad -> Double
bajarCostoDeVida unaCiudad = costoDeVida unaCiudad - ((*0.1) . costoDeVida) unaCiudad

{- Punto 3, Integrante 2 -}
remodelacion :: Double -> Ciudad -> Ciudad
remodelacion porcentaje unaCiudad = unaCiudad{nombre = (++) "New " (nombre unaCiudad) ,
                                    costoDeVida = aumentarCostoDeVida porcentaje unaCiudad}

{- Punto 3, Integrante 3 -}
reevaluacion :: Int -> Ciudad -> Ciudad
reevaluacion cantDeLetras unaCiudad | esSobria cantDeLetras unaCiudad = unaCiudad {costoDeVida = aumentarCostoDeVida 10 unaCiudad}
                                    | otherwise = unaCiudad {costoDeVida = costoDeVida unaCiudad - 3}

aumentarCostoDeVida :: Double -> Ciudad -> Double
aumentarCostoDeVida aumento unaCiudad = costoDeVida unaCiudad + ((/ 100) . (*aumento) . costoDeVida) unaCiudad


-- ////////////////////////////TP N°2 ////////////////////////////////////

type Evento = Ciudad -> Ciudad

data Año = Año {
    numero :: Double,
    eventos :: [Evento]
}

{- Punto 1.1, Todos los integrantes -}
año2015 :: Año
año2015 = Año{numero = 2015, eventos = []}

año2021 :: Año
año2021 = Año{numero = 2021 , eventos = [crisis, sumarAtraccion "playa"]}

año2022 :: Año
año2022 = Año{numero = 2022 , eventos = [crisis, remodelacion 5, reevaluacion 7]}

año2023 :: Año
año2023 = Año{numero = 2021 , eventos = [crisis, sumarAtraccion "parque", remodelacion 10 , remodelacion 20]}

pasoDelAño :: Año -> Ciudad -> Ciudad
pasoDelAño unAño unaCiudad = foldl (flip id) unaCiudad (eventos unAño)


{- Punto 1.2, Todos los integrantes -}
algoMejor :: Ord a => (Ciudad -> a) -> Evento -> Ciudad   -> Bool
algoMejor criterio evento unaCiudad = criterio unaCiudad < (criterio.evento) unaCiudad 

aplicarEventosSegunCriterio :: (Evento -> Ciudad -> Bool) -> Año -> Ciudad -> Ciudad
aplicarEventosSegunCriterio criterio (Año _ eventos) unaCiudad =
  foldl (flip id) unaCiudad (filter (`criterio` unaCiudad) eventos)

{- Punto 1.3, Integrante 1 -}
subeCostoDeVida :: Evento -> Ciudad -> Bool
subeCostoDeVida = algoMejor costoDeVida 

eventosQueSubenCostoDeVida :: Año -> Ciudad -> Ciudad
eventosQueSubenCostoDeVida  = aplicarEventosSegunCriterio subeCostoDeVida

{- Punto 1.4, Integrante 2 -}
bajaElCostoDeVida:: Evento -> Ciudad -> Bool
bajaElCostoDeVida evento unaCiudad =not (algoMejor costoDeVida evento unaCiudad)

eventosQueBajanCostoDeVida :: Año -> Ciudad -> Ciudad
eventosQueBajanCostoDeVida = aplicarEventosSegunCriterio bajaElCostoDeVida

{- Punto 1.5, Integrante 3 -}
subeValor :: Evento -> Ciudad -> Bool
subeValor = algoMejor valorDeUnaCiudad

eventosQueSubenValor:: Año -> Ciudad -> Ciudad
eventosQueSubenValor = aplicarEventosSegunCriterio subeValor


{- Punto 2.1, Integrante 1 -}
eventosOrdenados :: Año -> Ciudad -> Bool
eventosOrdenados (Año _ []) _ = False
eventosOrdenados (Año _ [_]) _ = True
eventosOrdenados (Año _ (evento1:evento2:eventos)) unaCiudad =
  costoDeVida (evento1 unaCiudad) < costoDeVida (evento2 unaCiudad) && eventosOrdenados (Año 0 (evento2:eventos)) unaCiudad

{- Punto 2.2, Integrante 2 -}
ciudadesOrdenadas :: Evento ->[Ciudad] -> Bool
ciudadesOrdenadas _ [] = False
ciudadesOrdenadas _ [_] = True
ciudadesOrdenadas evento (ciudad1:ciudad2:ciudades) = 
  costoDeVida (evento ciudad1) < costoDeVida (evento ciudad2) && ciudadesOrdenadas evento (ciudad2:ciudades)

{- Punto 2.3, Integrante 3 -}
añosOrdenados :: [Año] -> Ciudad -> Bool
añosOrdenados [] _  = True
añosOrdenados [_] _  = True
añosOrdenados (x:y:xs) unaCiudad = 
  (costoDeVida . pasoDelAño x ) unaCiudad < (costoDeVida . pasoDelAño y ) unaCiudad && añosOrdenados xs unaCiudad

{- Punto 3, Integrante 1 -}
año2024 :: Año
año2024 = Año {numero = 2024, eventos = [crisis, reevaluacion 7] ++ map remodelacion [1..]
}
--Si hay un resultado posible a pesar de estar manjenando listas infinitas, ya que por la evaluacion perezosa, evalua la remodelacion de 1%.
--Pero como antes se reevaluo con cantDeLetras7 y esto aumento en 10%, por la evaluacion perezosa eso da False ya que no esta en orden y corta, no evalua toda la lista infinita


{- Punto 3, Integrante 2 -}
{-
Puede haber un resultado posible para la función del punto 2.2 (ciudades ordenadas) para la 
lista “disco rayado”? Justificarlo relacionándolo con conceptos vistos en la materia. 

Rta: Es posible un resultado para la funcion del punto 2.2 (ciudades ordenadas) para la lista "disco rayado"
porque si bien la lista es infita y uno pensaría que la funcion estaría repitiendose hasta el infinito
la misma se interrumpe al primer momento en el que la lista no esté ordenada y el hecho de que se intercale hace 
que si bien llegue a estar ordenada, al repetirse hace que la lista no lo está dando como resultado de la funcion
False, dando un resultado posible.
-}

discoRayado :: [Ciudad]
discoRayado = [azul,nullish] ++ (cycle[caletaOlivia,baradero])


{- Punto 3, Integrante 3 -}
{-"Puede haber un resultado posible para la función del punto 2.3 (años ordenados) para una lista infinita de años? 
Justificarlo relacionándolo con conceptos vistos en la materia."

Rta: En el unico caso de que la funcion sea infinita y no retorne un resultado es cuando todos los elementos estan ordenados de forma creciente. 
Al tener haskell evaluacion lazy, la primer condicion es que el costoDeVida sea menor al costoDeVida del año siguiente, si eso no se cumple ya retorna False y termina la ejecucion.
-}