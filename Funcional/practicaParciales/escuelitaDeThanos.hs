--Punto 1

type Material = String

data Guantelete = Guantelete {
    material :: Material,
    gemas :: [Gema] 
}

type Habilidad = String
data Personaje = Personaje {
    edad :: Int,
    energia :: Int,
    habilidades :: [Habilidad],
    nombre :: String,
    planeta :: String
} deriving (Show,Eq)

type Universo = [Personaje]

--1
chasquear :: Guantelete -> Universo -> Universo
chasquear guantelete universo | puedeChasquear guantelete = reducirMitad universo
                              | otherwise = universo

puedeChasquear  :: Guantelete -> Bool
puedeChasquear guantelete = material guantelete == "uru" && estaCompleto guantelete

estaCompleto :: Guantelete -> Bool
estaCompleto = (==6). length . gemas 

reducirMitad :: Universo -> Universo
reducirMitad universo = take (habitantes universo `div` 2) universo

habitantes :: [a] -> Int
habitantes = length


--2
universoAptoParaPendex :: Universo -> Bool
universoAptoParaPendex = any ((<45) . edad)

energiaTotalDelUniverso :: Universo -> Int
energiaTotalDelUniverso universo = foldr ((+).energia) 0 (filter masDeUnaHabilidad universo)
--energiaTotalDelUniverso universo = foldl (\acum personaje -> acum + energia personaje) 0 (filter masDeUnaHabilidad universo)
--energiaTotalDelUniverso universo = (sum . map energia) (filter masDeUnaHabilidad universo)

masDeUnaHabilidad :: Personaje -> Bool
masDeUnaHabilidad  = (>1). length . habilidades

--3
type Gema = Personaje -> Personaje

mente :: Int -> Gema
mente =quitarEnergia

quitarEnergia :: Int -> Gema
quitarEnergia valor personaje = personaje {energia = energia personaje - valor}

alma :: Habilidad -> Gema
alma habilidad personaje = quitarEnergia 10 personaje {
    habilidades = filter (/= habilidad) (habilidades personaje)
}

poder :: Gema
poder personaje = personaje {
    energia = 0,
    habilidades = quitarHabilidades (habilidades personaje)
}

quitarHabilidades :: [Habilidad] -> [Habilidad]
quitarHabilidades habilidades | ((<=2) . length) habilidades = []
                              | otherwise = habilidades

tiempo :: Gema 
tiempo personaje = quitarEnergia 50 personaje {
    edad = (max 18 . div (edad personaje)) 2
}

espacio :: String -> Gema
espacio nuevoPlaneta personaje = quitarEnergia 20 personaje{
    planeta = nuevoPlaneta
}


gemaLoca :: Gema -> Gema
gemaLoca gema  = gema . gema 

--4

unGuanteleteDeGoma :: Guantelete
unGuanteleteDeGoma = Guantelete {
    material = "goma",
    gemas = [tiempo, alma "usar Mjolnir", gemaLoca (alma "progrmacion en Haskell")]
}

--5
usar :: [Gema] -> Personaje -> Personaje
usar gemas personaje = foldr ($) personaje gemas
--usar gemas personaje = foldl (\personaje gema -> gema personaje ) personaje gemas     ||Aca landa fucnion como adaptador

--6

gemaMasPoderosa :: Personaje -> Guantelete -> Gema
gemaMasPoderosa personaje guantelete = gemaDeMayorPoder personaje (gemas guantelete)

gemaDeMayorPoder :: Personaje -> [Gema] -> Gema
gemaDeMayorPoder _ [gema] = gema
gemaDeMayorPoder personaje (gema1:gema2:gemas) 
    | (energia . gema1) personaje > (energia . gema2) personaje = gemaDeMayorPoder personaje (gema2:gemas)  -- caso recursivo
    | otherwise = gemaDeMayorPoder personaje (gema1: gemas)

--7
infinitasGemas :: Gema -> [Gema]
infinitasGemas gema = gema:(infinitasGemas gema)

guanteleteDeLocos :: Guantelete
guanteleteDeLocos = Guantelete "vesconite" $ infinitasGemas tiempo

--punisher:: Personaje 
--punisher = Personaje "The Punisher" ["Disparar con de todo","golpear"] "Tierra" 38 350.0

usoLasTresPrimerasGemas :: Guantelete -> Personaje -> Personaje
usoLasTresPrimerasGemas guantelete = (usar . take 3. gemas) guantelete

--gemaMasPoderosa punisher guanteleteDeLocos Aca no corta ya que gemaMasPoderosa invoca a show y eso muestra todo pero como la lista es infinita nunca muestra todo
--usoLasTresPrimerasGemas guanteleteDeLocos punisher -- esto si arranca por el take 3 enotnces nunca usa toda la lista infinita solo las 3 primeras