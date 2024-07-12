--1
data Pelicula = Pelicula {
    nombre :: String,
    genero :: String,
    duracion :: Int,
    origen :: String
} deriving (Show,Eq)

data Usuario = Usuario {
    nombreUsuario :: String,
    categoria :: String,
    edad :: Int,
    paisResidencia :: String,
    peliculasVistas :: [Pelicula],
    estadoSalud :: Int
} deriving (Show,Eq)

psicosis :: Pelicula
psicosis = Pelicula "Psicosis" "Terror" 109 "Estados Unidos"

perfumeDeMujer :: Pelicula
perfumeDeMujer = Pelicula "Perfume de mujer" "Drama" 150 "Estados Unidos"

elSaborDeLasCervezas :: Pelicula
elSaborDeLasCervezas = Pelicula "El sabor de las cervezas" "Drama" 95 "Iran"

lasTortugasTambienVuelan :: Pelicula
lasTortugasTambienVuelan = Pelicula "Las Tortugas tambien vuelan" "Drama" 103 "Iran"

juan :: Usuario
juan = Usuario "juan" "estandar" 23 "Argentina" [perfumeDeMujer] 60
maico :: Usuario
maico = Usuario "maico" "basico" 23 "Argentina" (replicate 22 elSaborDeLasCervezas) 100

peliculasDeEmpresa :: [Pelicula]
peliculasDeEmpresa = [psicosis, perfumeDeMujer, elSaborDeLasCervezas, lasTortugasTambienVuelan]

--2
ver :: Pelicula -> Usuario -> Usuario
ver pelicula usuario = usuario { peliculasVistas = peliculasVistas usuario ++ [pelicula]}

--3
premiar :: [Usuario] -> [Usuario]
premiar usuarios = map subirCategoria (filter esfiel usuarios)

esfiel :: Usuario -> Bool
esfiel usuario = ((>20). length . peliculasVistas ) usuario  && ((/="Estados Unidos") . paisResidencia) usuario

subirCategoria :: Usuario -> Usuario
subirCategoria usuario | categoria usuario == "basico" = usuario {categoria = "estandar"}
                       | categoria usuario == "estandar" = usuario {categoria = "premium"}
                       | otherwise = usuario {categoria = "premium"}

--4
type Crtierio = Pelicula -> Bool

teQuedasteCorto :: Pelicula -> Bool
teQuedasteCorto = (<35) . duracion

esCuestionDeGenero :: [String] -> Pelicula -> Bool
esCuestionDeGenero generosBuscao pelicula = genero pelicula `elem` generosBuscao

deDondeSaliste :: String -> Pelicula -> Bool
deDondeSaliste origenABuscar = (== origenABuscar) . origen

vaPorEseLado :: Eq a => Pelicula -> (Pelicula -> a) -> Crtierio
vaPorEseLado unaPelicula f otraPelicula  = f unaPelicula == f otraPelicula
--5
recomendarPeliculas :: Usuario -> [Crtierio] -> [Pelicula]
recomendarPeliculas usuario criterios = (take 3 . filter (cumpleCondiciones usuario criterios)) peliculasDeEmpresa

cumpleCondiciones :: Usuario -> [Crtierio] -> Pelicula -> Bool
cumpleCondiciones usuario criterios pelicula = (not.vioPelicula usuario) pelicula && cumpleCriterios criterios pelicula

vioPelicula :: Usuario -> Pelicula -> Bool
vioPelicula usuario pelicula = elem pelicula (peliculasVistas usuario)

cumpleCriterios :: [Crtierio] -> Pelicula -> Bool
cumpleCriterios criterios pelicula = all (\f -> f pelicula) criterios

--Parte 2

--1

data Capitulo = CapituloSerie {
    nombreCap:: String,
    generoSerie :: String,
    duracionCap :: Int,
    origenSerie :: String,
    afectaUsuario :: (Usuario-> Usuario)
}

--2
consumeSerie :: Usuario -> Capitulo -> Usuario
consumeSerie usuario capitulo = (afectaUsuario capitulo) usuario

--3
losSimpson :: Capitulo
losSimpson = CapituloSerie "El Barto" "Comedia" 20 "EE UU" (\usuario -> usuario {estadoSalud = (estadoSalud usuario)`div`2})


--4
maraton :: Usuario -> [Capitulo] -> Usuario
maraton usuario serie = foldl (consumeSerie) usuario serie

--5
--Si los capitulos son infinito el progrmaa ejecuta ya que hay por la evalaucion perezosas, al estar el take 3 solo soma los 3 primeros capitulos por lo tanto no genera toda la lista infinita

--6
--usando un takeWhile 
