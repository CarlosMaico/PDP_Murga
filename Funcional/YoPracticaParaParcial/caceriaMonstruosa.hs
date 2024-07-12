import Text.Show.Functions ()

--PERSONAJES
data Personaje = Personaje {
    --nombre :: String,
    experiencia :: Float,
    fuerza :: Float,
    elemento:: Elemento
}deriving Show

type Elemento = Float -> Float

nivel :: Integral b => Personaje -> b
nivel (Personaje experiencia _ _) = ceiling(experiencia^2/(experiencia+1))
--nivel personaje  = experiencia personaje^2 /(experiencia personaje + 1)

capacidad :: Personaje -> Float
capacidad (Personaje _ fuerza elemento) = elemento fuerza
--capacidad perosonaje = elemento perosonaje (fuerza perosonaje)

espadaOxidiana :: Elemento
espadaOxidiana = (1.2*)

katanaFilosa :: Elemento
katanaFilosa = (10+).(0.9*)

sableLambdico :: Float ->Elemento
sableLambdico cm = ((1+cm/100)*)

redParadigmatica :: Elemento
redParadigmatica = sqrt

baculoDuplicador::Elemento
baculoDuplicador x = x *2

espadaMaldita :: Elemento
espadaMaldita = espadaOxidiana.sableLambdico 89

maiky :: Personaje
maiky = Personaje  50 50 katanaFilosa
cris :: Personaje
cris = Personaje  80 70 (sableLambdico 10)
julia :: Personaje
julia = Personaje 40 30 redParadigmatica
pepe = Personaje 50 10 espadaOxidiana
pedro = Personaje 40 30 (sableLambdico 10)

--ALQUIMISTAS
type Alquimista = Personaje -> Personaje

aprendiz :: Alquimista
aprendiz personaje = alterarElemento (2*) personaje

alterarElemento :: Elemento -> Alquimista
alterarElemento f personaje = personaje {elemento = f . elemento personaje}

maestroAlquimista :: Int -> Alquimista
maestroAlquimista años personaje = (alterarElemento (extraPorAntiguedad años) . aprendiz) personaje

extraPorAntiguedad 0 = id
extraPorAntiguedad años = (*1.1). extraPorAntiguedad (años-1) --el 1.1 es por que le agrega al total osea 1 el 01 ya que es 10 porciento ya le va sumando con el 1.1

estafador :: Alquimista
estafador personaje = personaje {elemento =id}

nuevoAlquimista :: Alquimista
nuevoAlquimista personaje = personaje {elemento = (\nro -> nro * (fuerza personaje))}

alquimistasQueHacenQueSupereUnValor :: Float -> Personaje -> [Alquimista] -> [Alquimista]
alquimistasQueHacenQueSupereUnValor valorDado personaje alquimistas = filter (superaValor valorDado personaje) alquimistas

superaValor :: Float -> Personaje -> Alquimista -> Bool
superaValor valorDado personaje alquimista = ((>valorDado) . capacidad . alquimista) personaje

convieneTodosLosAlquimistas :: Personaje -> [Alquimista] -> Bool
convieneTodosLosAlquimistas personaje alquimistas = all (superaValor (capacidad personaje) personaje ) alquimistas


--MONSTRUO
data Monstruo = Monstruo {
    especie :: String ,
    resistencia :: Float ,
    habilidades :: [Habilidad]
} deriving Show

zeus = Monstruo "Dios" 10000 [("Tira rayos", "fisica" )]

type Habilidad = (String,String)
descripcion = fst
tipo = snd

esAgresivo :: Monstruo -> Bool
esAgresivo monstruo =
    (tieneMayorHabiblidadesOfensivas . habilidades) monstruo && ((>0).resistencia) monstruo && (not.esEspecieInofensiva.especie) monstruo

esEspecieInofensiva :: String -> Bool
esEspecieInofensiva especie = especie `elem` ["animal", "chocobo"]

tieneMayorHabiblidadesOfensivas :: [Habilidad] -> Bool
tieneMayorHabiblidadesOfensivas habilidades = (length.filter (esOfensiva.tipo)) habilidades > div (length habilidades) 2

esOfensiva :: String -> Bool
esOfensiva "magica" = True
esOfensiva "fisica" = True
esOfensiva _ = False


--A LA CAZAAAAAA!!!!
leGana :: Personaje -> Monstruo -> Bool
leGana personaje monstruo = capacidad personaje > resistencia monstruo

pelearConTodos :: Personaje -> [Monstruo] -> Personaje
pelearConTodos personaje monstruos = foldl (pelear) personaje monstruos

pelear :: Personaje -> Monstruo -> Personaje
pelear personaje monstruo | leGana personaje monstruo = alterarExperiencia 100 personaje
                          | otherwise = (alterarElemento(*0.9) . alterarExperiencia (-50)) personaje

alterarExperiencia :: Float -> Personaje -> Personaje
alterarExperiencia puntos personaje = personaje {experiencia = experiencia personaje + puntos}

pierdeAPesarDelBuff ::  Personaje -> Alquimista -> [Monstruo] -> Bool
pierdeAPesarDelBuff personaje alquimista monstruos = any (not.leGana(alquimista personaje))  monstruos

--PARA PENSAR
--composicion se usa en casi todo el codigo obviamente solo se puede componer funciones , aplicacion parcial se usa mas que anda en el elemento ya que ahi dentro del data hay una funcion y a esa funcion accedemos gracias a la aplicacion parcial
--Profe: aplicacion parcial en elemento, en la creqacion de personaje, en maestroAlquimista, en pelear

--en el any si hay alguno que no le gana ahi puede finalizar, en elc aso de pelear con todos ahi enffcesita recorrer toda lalista y al ser infinta la lista de mosntuos va a seguir
--en el caso de no puede vebncer puede llegar a terminar por evaluacion diferida, en peelar a todo no va a terminar ya que reuiere llegar al final 