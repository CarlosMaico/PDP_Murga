type Bien = (String, Float)
descripcionBien = fst
valorBien = snd

data Ciudadano = UnCiudadano {
    profesion :: String,
    sueldo :: Float,
    cantidadDeHijos :: Float,
    bienes :: [Bien]
} deriving Show

homero = UnCiudadano "SeguridadNuclear" 9000 3 [("casa", 50000), ("deuda", -70000)]
frink = UnCiudadano "Profesor" 12000 1 []
krabappel = UnCiudadano "Profesor" 12000 0 [("casa", 35000)]
burns = UnCiudadano "Empresario" 300000 1 [("empresa", 1000000), ("empresa", 500000), ("auto", 200000)]

type Ciudad = [Ciudadano]
springfield :: Ciudad --Una lista de ciudadanos forman una ciudad
springfield = [homero, burns, frink, krabappel]

--1
diferenciaDePatrimonio :: Ciudad -> Float
diferenciaDePatrimonio ciudad = (patrimonio . ciudadanoSegun mayorPatrimonio) ciudad - (patrimonio . ciudadanoSegun menorPatrimonio) ciudad

patrimonio :: Ciudadano -> Float
patrimonio ciudadano = foldl (\acc (_,valorB) -> acc + valorB) (sueldo ciudadano) (bienes ciudadano)

ciudadanoSegun :: (Ciudadano-> Ciudadano -> Ciudadano) -> Ciudad-> Ciudadano
ciudadanoSegun   = foldl1

mayorPatrimonio :: Ciudadano -> Ciudadano -> Ciudadano
mayorPatrimonio unCiudadano otroCiudadano | patrimonio unCiudadano > patrimonio otroCiudadano = unCiudadano
                                          | otherwise = otroCiudadano

menorPatrimonio :: Ciudadano -> Ciudadano -> Ciudadano
menorPatrimonio unCiudadano otroCiudadano | patrimonio unCiudadano < patrimonio otroCiudadano = unCiudadano
                                          | otherwise = otroCiudadano


--2
tieneAutoAltaGama :: Ciudadano -> Bool
tieneAutoAltaGama ciudadano = any esGamaAlta (bienes ciudadano)

esGamaAlta :: Bien -> Bool
esGamaAlta ("auto", valorB) = valorB > 100000
esGamaAlta _ = False

--3

type Medida = Ciudadano -> Ciudadano

auh :: Medida-----------Bool                                           Ciudadno -> Ciudadano                                 Ciudadano
auh ciudadano = aplicarMedidaSegun (patrimonio ciudadano < 0) (modificarSueldo ((incremento . cantidadDeHijos) ciudadano)) ciudadano

aplicarMedidaSegun :: Bool -> (Ciudadano -> Ciudadano) -> Ciudadano -> Ciudadano
aplicarMedidaSegun condicion f ciudadano | condicion = f ciudadano
                                         | otherwise = ciudadano

modificarSueldo :: Float -> Ciudadano -> Ciudadano
modificarSueldo cantidad ciudadano = ciudadano {sueldo = sueldo ciudadano + cantidad}

incremento :: Float -> Float
incremento cantidad = 1000 * cantidad

impuestoGanancias :: Float -> Medida
impuestoGanancias valorDado ciudadano = 
    aplicarMedidaSegun (sueldo ciudadano > valorDado) (modificarSueldo (diferencia valorDado (sueldo ciudadano))) ciudadano

diferencia :: Float -> Float -> Float
diferencia valorDado sueldo = (valorDado - sueldo) * 0.3

impuestoAltaGama :: Medida
impuestoAltaGama ciudadano = aplicarMedidaSegun (tieneAutoAltaGama ciudadano) (modificarSueldo ((impuesto.bienes) ciudadano)) ciudadano

impuesto :: [Bien] -> Float
impuesto bienes = ((*(-0.1)).valorBien.head . filter (esGamaAlta) )bienes

negociarSueldoProfesion :: String -> Float -> Medida
negociarSueldoProfesion unaProfesion porcentaje ciudadano =
    aplicarMedidaSegun (profesion ciudadano == unaProfesion) (modificarSueldo  (aumento porcentaje (sueldo ciudadano))) ciudadano

aumento :: Float -> Float -> Float
aumento porcentaje sueldo = (sueldo * porcentaje) /100

--4
data Gobierno = UnGobierno {
    años :: [Float],
    medidas :: [Medida]
}

gobiernoA :: Gobierno
gobiernoA = UnGobierno [1999 .. 2003] [impuestoGanancias 3000, negociarSueldoProfesion "Profesor" 10, negociarSueldoProfesion "Empresario" 40, impuestoAltaGama, auh]

gobiernoB :: Gobierno
gobiernoB = UnGobierno [2004..2008] [impuestoGanancias 40000, negociarSueldoProfesion "Profesor" 30, negociarSueldoProfesion "Camionero" 40]

gobernarUnAño :: Gobierno -> Ciudad -> Ciudad
gobernarUnAño gobierno ciudad = map (aplicarMedida gobierno) ciudad

aplicarMedida :: Gobierno -> Ciudadano -> Ciudadano
aplicarMedida gobierno ciudadano = foldr ($) ciudadano (medidas gobierno)

gobernarPeriodoCompleto :: Gobierno -> Ciudad -> Ciudad
gobernarPeriodoCompleto gobierno ciudad = foldl (\unaCiudad _ -> gobernarUnAño gobierno unaCiudad) ciudad (años gobierno)

distribuyoRiqueza :: Gobierno -> Ciudad -> Bool
distribuyoRiqueza gobierno ciudad = diferenciaDePatrimonio ciudad > (diferenciaDePatrimonio.gobernarPeriodoCompleto gobierno) ciudad

--5
kane :: Ciudadano
kane = UnCiudadano "Empresario" 100000 0 infinitosTrineos

infinitosTrineos =  [("Rosbud", valorTrineo) |valorTrineo<- [5,10 ..]]

--i.  No temrina por lo bienes ya que son infintos y en impuestosAltaGama usa bienees y se va a quedar buscando si hay algun autoAltaGama, y por el auh tambien
--ii Aca si temrina por como intenta imprimir a la Ciudad, al tener infinito bienes, nunca termina, no logra imprimirlo

f1 ::Num a => a ->(b->a-> Bool) -> b-> [a]-> [a]
f1 x y z = map (*x) . filter (y z)

--f1 :: a-> ( b->a -> Bool)->  b-> [a] -> [a]