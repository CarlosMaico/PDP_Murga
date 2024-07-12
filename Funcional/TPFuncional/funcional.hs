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
sumarAtraccion ::String -> Ciudad -> Ciudad
sumarAtraccion unaAtraccion unaCiudad = unaCiudad {atraccionesPrincipales = ((++ [unaAtraccion]) . atraccionesPrincipales) unaCiudad,
                                      costoDeVida =  costoDeVida unaCiudad + ((`div`100) . (*20) . costoDeVida) unaCiudad }

{- Punto 3, Integrante 1 -}
crisis :: Ciudad -> Ciudad
crisis unaCiudad | (null . atraccionesPrincipales) unaCiudad = unaCiudad {costoDeVida = bajarCostoDeVida unaCiudad}
                 | otherwise = unaCiudad {atraccionesPrincipales = (init . atraccionesPrincipales) unaCiudad ,
                                          costoDeVida = bajarCostoDeVida unaCiudad }

{- Punto 3, Integrante 2 -}
remodelacion :: Integer -> Ciudad -> Ciudad
remodelacion porcentaje unaCiudad = unaCiudad{nombre = ((++) "New " (nombre unaCiudad)) ,
                                    costoDeVida = aumentarCostoDeVida unaCiudad porcentaje }

{- Punto 3, Integrante 3 -}
reevaluacion :: Int -> Ciudad -> Ciudad
reevaluacion cantDeLetras unaCiudad | esSobria unaCiudad cantDeLetras = unaCiudad {costoDeVida = aumentarCostoDeVida unaCiudad 10}
                                    | otherwise = unaCiudad {costoDeVida = costoDeVida unaCiudad - 3}

bajarCostoDeVida :: Ciudad -> Integer
bajarCostoDeVida unaCiudad = costoDeVida unaCiudad - ((`div`100) . (*10) . costoDeVida) unaCiudad

aumentarCostoDeVida :: Ciudad -> Integer -> Integer
aumentarCostoDeVida unaCiudad aumento = costoDeVida unaCiudad + ((`div` 100) . (*aumento) . costoDeVida) unaCiudad 

data Evento = Crisis | Remodelacion Integer | Reevaluacion Int | AgregarAtraccion String deriving Show
data Anio = Anio{
        numero :: Int,
        eventos :: [Evento]
}deriving Show

anio2022 :: Anio
anio2022 = Anio{
    numero = 2022,
    eventos = [Crisis, Remodelacion 5, Reevaluacion 7]
}

anio2015 :: Anio
anio2015 = Anio{
    numero = 2015,
    eventos = []
}

anio2023 :: Anio
anio2023 = Anio{
    numero = 2023,
    eventos = [Crisis, AgregarAtraccion "parque", Remodelacion 10, Remodelacion 20]
}

aplicarEvento :: Evento -> Ciudad -> Ciudad
aplicarEvento Crisis = crisis
aplicarEvento (Remodelacion porcentaje) = remodelacion porcentaje
aplicarEvento (Reevaluacion letras) = reevaluacion letras
aplicarEvento (AgregarAtraccion atraccion) = sumarAtraccion atraccion


pasoDelAnio :: Anio -> Ciudad -> Ciudad
pasoDelAnio (Anio _ eventos) unaCiudad = foldl (flip aplicarEvento) unaCiudad eventos

ciudadMejoro :: (Ciudad -> Integer) -> Evento -> Ciudad -> Bool
ciudadMejoro criterio evento unaCiudad = criterio (aplicarEvento evento unaCiudad) > criterio unaCiudad

criterioCostoDeVida :: Ciudad -> Integer
criterioCostoDeVida = costoDeVida

criterioCantidadAtracciones :: Ciudad -> Int
criterioCantidadAtracciones = length . atraccionesPrincipales

aplicarEventosQueSubenCosto :: Anio -> Ciudad -> Ciudad
aplicarEventosQueSubenCosto (Anio _ eventos) ciudad = foldl (\ciudad evento -> if ciudadMejoro costoDeVida evento ciudad then aplicarEvento evento ciudad else ciudad) ciudad eventos

eventosOrdenados :: Anio -> Ciudad -> Bool
eventosOrdenados (Anio _ (e:es)) ciudad = go es (aplicarEvento e ciudad)
  where
    go [] _ = True
    go (e:es) ciudadAnterior = let ciudadActual = aplicarEvento e ciudadAnterior
                               in costoDeVida ciudadActual >= costoDeVida ciudadAnterior && go es ciudadActual