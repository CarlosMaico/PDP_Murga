data Ciudad = Ciudad{
    nombre :: String,
    añoFundacion :: Integer,
    atraccionesPrincipales :: [String],
    costoDeVida :: Integer
} deriving Show

baradero :: Ciudad
baradero = Ciudad {
    nombre = "Baradero",
    añoFundacion = 1615,
    atraccionesPrincipales = ["Parque del Este", "Museo Alejandro Barbich"],
    costoDeVida = 150
}

nullish :: Ciudad
nullish = Ciudad {
    nombre = "Nullish",
    añoFundacion = 1800,
    atraccionesPrincipales = [],
    costoDeVida = 140
}

caletaOlivia :: Ciudad
caletaOlivia = Ciudad {
    nombre = "Caleta Olivia",
    añoFundacion = 1901,
    atraccionesPrincipales = ["El Gorosito", "Faro Costanera"],
    costoDeVida = 120
}

seis :: Ciudad
seis = Ciudad {
    nombre = "6",
    añoFundacion = 1615,
    atraccionesPrincipales = ["Parque del Este", "Museo Alejandro Barbich"],
    costoDeVida = 150
}

maipu :: Ciudad
maipu = Ciudad {
    nombre = "Maipu",
    añoFundacion = 1878,
    atraccionesPrincipales = ["Fortin Kakel"],
    costoDeVida = 115
}

azul :: Ciudad
azul = Ciudad {
    nombre = "Azul",
    añoFundacion = 1832,
    atraccionesPrincipales = ["Teatro Español", "Parque Municipal Sarmiento",  "Costanera Cacique Catriel"],
    costoDeVida = 190
}

{- Punto 1, Todos los integrantes -}
valorDeUnaCiudad :: Ciudad -> Integer
valorDeUnaCiudad unaCiudad | ((< 1800) . añoFundacion) unaCiudad = ((*5) . (1800 -) . añoFundacion) unaCiudad
                           | (null . atraccionesPrincipales) unaCiudad = ((*2) . costoDeVida) unaCiudad
                           | otherwise = ((*3) . costoDeVida) unaCiudad

{- Punto 2, Integrante 1 -}
esAtraccionCopada :: Ciudad -> Bool
esAtraccionCopada unaCiudad = (any (isVowel . head) . atraccionesPrincipales) unaCiudad

isVowel :: Char -> Bool
isVowel character = character `elem` "aeiouAEIOU"

{- Punto 2, Integrante 2 -}
esSobria :: Ciudad -> Int -> Bool
esSobria unaCiudad cantDeLetras =
                (not . null . atraccionesPrincipales) unaCiudad && (all ((> cantDeLetras).length) . atraccionesPrincipales) unaCiudad

{- Punto 2 , Integrante 3 -}
ciudadConNombreRaro :: Ciudad -> Bool
ciudadConNombreRaro unaCiudad = ((<5) . length . nombre)  unaCiudad

{- Punto 3, Todos los integrantes -}
sumarAtraccion :: Ciudad -> String -> Ciudad
sumarAtraccion unaCiudad unaAtraccion = unaCiudad {atraccionesPrincipales = ((++ [unaAtraccion]) . atraccionesPrincipales) unaCiudad,
                                      costoDeVida =  costoDeVida unaCiudad + ((`div`100) . (*20) . costoDeVida) unaCiudad }

{- Punto 3, Integrante 1 -}
crisis :: Ciudad -> Ciudad
crisis unaCiudad | (null . atraccionesPrincipales) unaCiudad = unaCiudad {costoDeVida = bajarCostoDeVida unaCiudad}
                 | otherwise = unaCiudad {atraccionesPrincipales = (init . atraccionesPrincipales) unaCiudad ,
                                          costoDeVida = bajarCostoDeVida unaCiudad }

{- Punto 3, Integrante 2 -}
remodelacion :: Ciudad -> Integer -> Ciudad
remodelacion unaCiudad porcentaje = unaCiudad{nombre = ((++) "New " (nombre unaCiudad)) ,
                                    costoDeVida = aumentarCostoDeVida unaCiudad porcentaje }

{- Punto 3, Integrante 3 -}
reevaluacion :: Ciudad -> Int -> Ciudad
reevaluacion unaCiudad cantDeLetras | esSobria unaCiudad cantDeLetras = unaCiudad {costoDeVida = aumentarCostoDeVida unaCiudad 10}
                                    | otherwise = unaCiudad {costoDeVida = costoDeVida unaCiudad - 3}

bajarCostoDeVida :: Ciudad -> Integer
bajarCostoDeVida unaCiudad = costoDeVida unaCiudad - ((`div`100) . (*10) . costoDeVida) unaCiudad

aumentarCostoDeVida :: Ciudad -> Integer -> Integer
aumentarCostoDeVida unaCiudad aumento = costoDeVida unaCiudad +((`div` 100) . (*aumento) . costoDeVida) unaCiudad 