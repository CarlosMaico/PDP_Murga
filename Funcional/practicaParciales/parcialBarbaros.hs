import Text.Show.Functions
import Data.Char (toUpper, isUpper)


-- 1
data Barbaro = Barbaro {
  nombre :: String,
  fuerza :: Int,
  habilidades :: [String],
  objetos :: [Objeto]
} deriving Show

type Objeto = Barbaro -> Barbaro

-- accessors -- Sirve para modificar elemntos del barbaro
mapNombre :: (String -> String) -> Barbaro -> Barbaro
mapNombre f unBarbaro = unBarbaro { nombre = f . nombre $ unBarbaro }

mapFuerza :: (Int -> Int) -> Barbaro -> Barbaro
mapFuerza f unBarbaro = unBarbaro { fuerza = f . fuerza $ unBarbaro }

mapHabilidades :: ([String] -> [String]) -> Barbaro -> Barbaro
mapHabilidades f unBarbaro = unBarbaro { habilidades = f . habilidades $ unBarbaro }

mapObjetos :: ([Objeto] -> [Objeto]) -> Barbaro -> Barbaro
mapObjetos f unBarbaro = unBarbaro { objetos = f . objetos $ unBarbaro }

espada :: Int -> Objeto
espada pesoEspada unBarbaro = mapFuerza (+ pesoEspada *2) unBarbaro

agregarHabilidad :: String -> Barbaro -> Barbaro
agregarHabilidad unaHabilidad unBarbaro = mapHabilidades (++ [unaHabilidad]) unBarbaro

amuletoMistico :: String -> Objeto
amuletoMistico = agregarHabilidad

varitaDefectuosa :: Objeto
varitaDefectuosa unBarbaro = (mapHabilidades (++ ["haverMagia"]).desaparecerObjetos) unBarbaro

desaparecerObjetos :: Objeto
desaparecerObjetos unBarbaro = unBarbaro {objetos = [varitaDefectuosa]}

ardilla :: Objeto
ardilla = id

cuerda :: Objeto -> Objeto -> Objeto
cuerda unObjeto otroObjeto= unObjeto.otroObjeto

--megafono :: Objeto
--megafono unBarbaro = mapHabilidades (ponerEnMayusculuas.concatenar) unBarbaro
megafono :: Objeto
megafono barabro = mapHabilidades (ponerEnMayusculuas.concatenar)barabro

concatenar :: [String] -> [String]
concatenar unasHabilidades = [concat unasHabilidades]

ponerEnMayusculuas :: [String] -> [String]
ponerEnMayusculuas unasHabilidades = map (map toUpper) unasHabilidades

megafonoBarbarico :: Objeto
megafonoBarbarico = cuerda ardilla megafono


type Aventura = [Evento]
type Evento = Barbaro -> Bool

invasionDeSuciosDuendes :: Evento
invasionDeSuciosDuendes unBarbaro = (elem "Escribir Poesia Atroz".habilidades) unBarbaro

cremalleraDelTiempo :: Evento
cremalleraDelTiempo unBarbaro = (not. tienePulgares .nombre) unBarbaro

tienePulgares :: String -> Bool
tienePulgares "Faffy" = False
tienePulgares "Astro" = False
tienePulgares _ = True


saqueo :: Evento
saqueo unBarbaro = tieneHabilidad "robar" unBarbaro && esFuerte unBarbaro

tieneHabilidad :: String -> Barbaro -> Bool
tieneHabilidad habilidad unBarbaro = (elem habilidad.habilidades) unBarbaro

esFuerte :: Barbaro -> Bool
esFuerte unBarbaro = ((>80). fuerza) unBarbaro 

gritoDeGuerra :: Evento
gritoDeGuerra unBarbaro = poderDeGritoDeGuerra unBarbaro >= cantidadDeLetrasDeHabilidades unBarbaro

poderDeGritoDeGuerra :: Barbaro -> Int
poderDeGritoDeGuerra unBarbaro = ((*4).length.objetos) unBarbaro

cantidadDeLetrasDeHabilidades :: Barbaro -> Int
cantidadDeLetrasDeHabilidades unBarbaro = (sum.map length .habilidades) unBarbaro

caligrafia :: Evento
caligrafia unBarbaro = all tieneMasDe3VocalesYEmpiezaConMayuscula (habilidades unBarbaro)

tieneMasDe3VocalesYEmpiezaConMayuscula :: String -> Bool
tieneMasDe3VocalesYEmpiezaConMayuscula habilidad = tieneMasDe3Vocales habilidad && empiezaConMayuscula habilidad

tieneMasDe3Vocales :: String -> Bool
tieneMasDe3Vocales habilidad = ((>3) . length . filter esVocal) habilidad

esVocal :: Char -> Bool
esVocal 'a' = True
esVocal 'e' = True
esVocal 'i' = True
esVocal 'o' = True
esVocal 'u' = True
esVocal _ = False

empiezaConMayuscula :: String -> Bool
empiezaConMayuscula habilidad = (isUpper.head) habilidad


ritualDeFechorias :: [Evento] -> Evento
ritualDeFechorias eventos unBarbaro = pasaUnaAventura any unBarbaro eventos

sobrevivientes :: [Barbaro] -> Aventura -> [Barbaro]
sobrevivientes barbaros unaAventura = filter (\barbaro -> pasaUnaAventura all barbaro unaAventura ) barbaros

pasaUnaAventura criterio unBarbaro unaAventura = criterio (\evento -> evento unBarbaro) unaAventura

sinRepetidos :: (Eq a) => [a] -> [a]
sinRepetidos [] = []
sinRepetidos (cabeza:cola) 
    | elem cabeza cola = cola
    | otherwise = (cabeza:cola)

descendiente :: Barbaro -> Barbaro
descendiente = utilizarObjetos . mapNombre(++ "*") . mapHabilidades sinRepetidos

utilizarObjetos :: Barbaro -> Barbaro
utilizarObjetos unBarbaro = foldr ($) unBarbaro (objetos unBarbaro)
 
descendientes :: Barbaro -> [Barbaro]
descendientes unBarbaro = iterate descendiente unBarbaro

