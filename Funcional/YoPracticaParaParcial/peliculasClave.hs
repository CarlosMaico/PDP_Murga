
import Text.Show.Functions()

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
    peliculas :: [Pelicula],
    estadoSalud :: Int
} deriving (Show,Eq)

psicosis = Pelicula "Psicosis" "Terror" 109 "Estados Unidos"
perfumeDeMujer = Pelicula "Perfume de Mujer" "Drama" 150 "Estados Unidos"
elSaborDeLasCervezas = Pelicula "El sabor de las cervezas" "Drama" 95 "Iran"
lasTortugasTambienVuelan = Pelicula "las tortugas tambien vuelan"  "drama" 103 "Iran"

juan = Usuario "Juan" "estandar" 23 "Argentina" [perfumeDeMujer] 60


--2
verPelicula :: Pelicula -> Usuario -> Usuario
verPelicula nomPelicula usuario = agregarPelicula nomPelicula usuario

agregarPelicula :: Pelicula -> Usuario -> Usuario
agregarPelicula nomPelicula usuario = usuario {peliculas = peliculas usuario ++ [nomPelicula]}

--3
premmiar :: [Usuario] -> [Usuario]
premmiar usuarios = map (premiarSiEsFiel) usuarios

premiarSiEsFiel :: Usuario -> Usuario
premiarSiEsFiel unUsuario | cumpleCondiciones unUsuario = subirCategoria unUsuario
                          | otherwise = unUsuario

cumpleCondiciones ::  Usuario  -> Bool
cumpleCondiciones usuario = ((>20) . length . peliculasQueNoSonDe "Estados Unidos". peliculas) usuario

peliculasQueNoSonDe :: String -> [Pelicula] -> [Pelicula]
peliculasQueNoSonDe pais peliculas = filter ((/= pais) . origen) peliculas

subirCategoria :: Usuario -> Usuario
subirCategoria usuario = usuario {categoria = (nuevaCategoria. categoria) usuario}

nuevaCategoria :: String -> String
nuevaCategoria "basica" = "estandar"
nuevaCategoria "estandar" = "premium"
nuevaCategoria _ = "premium"

--4

type Criterio = Pelicula -> Bool

teQuedasteCorto :: Criterio
teQuedasteCorto = (<35) . duracion

cuestionDeGenero :: [String] -> Criterio
cuestionDeGenero generos pelicula = genero pelicula `elem` generos

deDondeSaliste :: String -> Criterio
deDondeSaliste origenParticular = (origenParticular ==) . origen


vaPorEseLado :: Eq a => Pelicula -> (Pelicula -> a) -> Criterio
vaPorEseLado pelicula caracteristica otraPelicula = caracteristica pelicula == caracteristica otraPelicula

--5

peliculasEmpresa :: [Pelicula]
peliculasEmpresa = [psicosis, perfumeDeMujer, elSaborDeLasCervezas, lasTortugasTambienVuelan]

proponeme :: Usuario -> [Criterio] -> [Pelicula] -> [Pelicula]
proponeme usuario criterios = (take 3 . filter (pelisRecomendadas usuario criterios))

pelisRecomendadas :: Usuario -> [Criterio] -> Pelicula -> Bool
pelisRecomendadas usuario criterios pelicula = cumpleCriterios pelicula criterios && (not . vio pelicula) usuario

vio :: Pelicula -> Usuario -> Bool
vio pelicula usuario = pelicula `elem` peliculas usuario

cumpleCriterios :: Pelicula -> [Criterio] -> Bool
cumpleCriterios pelicula criterios = all ($ pelicula) criterios


--6
data Capitulo = Capitulo {
    nombreC :: String,
    generoC :: String,
    duracionC :: Int,
    origenC :: String,
    afecta :: Usuario-> Usuario
} deriving Show

consumeSerie :: Usuario -> Capitulo -> Usuario
consumeSerie usuario capitulo = (afecta capitulo) usuario

capitulo = Capitulo "DragonBallZ" "Accion" 20 "JApones" afectaUsuario

afectaUsuario :: Usuario -> Usuario
afectaUsuario usuario = usuario {estadoSalud = estadoSalud usuario -20}

maraton :: Usuario -> [Capitulo] -> Usuario
maraton usuario capitulos = foldl (consumeSerie) usuario capitulos

serieInfinita :: [Capitulo]
serieInfinita = repeat capitulo

--Si ve una serie infinita como maraton es consume serie y los capitulos son infintos siempre va a ver un capitulo tras otro hasta qu termina la lista pero nuna va a terminar por ser infinita
--ghci> maraton juan (take 3 serieInfinita )
--Usuario {nombreUsuario = "Juan", categoria = "estandar", edad = 23, paisResidencia = "Argentina", peliculas = [Pelicula {nombre = "Perfume de Mujer", genero = "Drama", duracion 
-- = 150, origen = "Estados Unidos"}], estadoSalud = 0}
  --EN ESTE CASO SI TERMINA YA QUE EL TAKE 3 RALIZAR EL CORTE Y POR LA EVALAUCION DIFERIDA NO GENERA TODA LA LISTA SINO SOLO LOS QUE NECESITA