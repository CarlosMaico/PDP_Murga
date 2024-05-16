
data Ciudad = Ciudad{
    nombre :: String,
    añoFundacion :: Integer,
    atraccionesPrincipales :: [String],
    costoDeVida :: Integer
} deriving Show

bardero :: Ciudad
bardero = Ciudad {
    nombre = "Bardero",
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

azul :: Ciudad
azul = Ciudad {
    nombre = "Azul",
    añoFundacion = 1832,
    atraccionesPrincipales = ["Teatro Espanol", "Parque Municipal Sarmiento", "Costanera Cacique Catriel"],
    costoDeVida  = 190
}

valorDeUnaCiudad :: Ciudad -> Integer
valorDeUnaCiudad unaCiudad | ((< 1800) . añoFundacion) unaCiudad = ((*5) . (1800 -) . añoFundacion) unaCiudad
                           | (null . atraccionesPrincipales) unaCiudad = ((*2) . costoDeVida) unaCiudad
                           | otherwise = ((*3) . costoDeVida) unaCiudad


isVowel :: Char -> Bool
isVowel character = character `elem` "aeiouAEIOU"

--Integrante 1
esAtraccionCopada :: Ciudad -> Bool
esAtraccionCopada unaCiudad = (any isVowel . map head . atraccionesPrincipales) unaCiudad



sumarAtraccion :: Ciudad -> Ciudad
sumarAtraccion unaCiudad = unaCiudad {atraccionesPrincipales = ((++ ["Balneario Municipal Alte. Guillermo Brown"]) . atraccionesPrincipales) unaCiudad,
                                      costoDeVida =  costoDeVida unaCiudad + ((`div`100) . (*20) . costoDeVida) unaCiudad }

crisis :: Ciudad -> Ciudad
crisis unaCiudad | (null . atraccionesPrincipales)unaCiudad =  unaCiudad {costoDeVida = costoDeVida unaCiudad - ((`div` 100) . (*10) . costoDeVida) unaCiudad}
                 | otherwise = unaCiudad {atraccionesPrincipales = (init . atraccionesPrincipales) unaCiudad ,
                              costoDeVida = costoDeVida unaCiudad - ((`div` 100) . (*10) . costoDeVida) unaCiudad }