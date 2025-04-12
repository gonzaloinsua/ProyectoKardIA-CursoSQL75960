-- Creo el Schema DB_Infartos
CREATE SCHEMA DB_Infartos;

-- Elijo el Schema sobre el cual trabajar
USE DB_Infartos;

/*
Creación de Tablas de Dimensiones que serán FK en la Tabla de Dimensiones "Dim_Pacientes"
*/

CREATE TABLE Dim_Genero (
ID_Genero INT AUTO_INCREMENT NOT NULL,
Genero VARCHAR(50),
PRIMARY KEY (ID_Genero)
);
 
CREATE TABLE Dim_NivelEducativo (
ID_NivelEducativo INT AUTO_INCREMENT NOT NULL,
NivelEducativo VARCHAR(100),
PRIMARY KEY (ID_NivelEducativo)
);

CREATE TABLE Dim_LugarResidencia (
ID_LugarResidencia INT AUTO_INCREMENT NOT NULL,
LugarResidencia VARCHAR(100),
PRIMARY KEY (ID_LugarResidencia)
);

CREATE TABLE Dim_SituacionLaboral (
ID_SituacionLaboral INT AUTO_INCREMENT NOT NULL,
SituacionLaboral VARCHAR(100),
PRIMARY KEY (ID_SituacionLaboral)
);

CREATE TABLE Dim_EstadoCivil (
ID_EstadoCivil INT AUTO_INCREMENT NOT NULL,
EstadoCivil VARCHAR(100),
PRIMARY KEY (ID_EstadoCivil)
);

/*
Creación de Tablas de Dimensiones que serán FK en la Tabla de Hechos principal "Fact_AnalisisCardiacos"
Se normalizaron todas las variables categóricas a tablas de dimensiones para mejorar la escalabilidad, 
evitar duplicidad y permitir análisis más flexibles (por ejemplo, analizar la tasa de infarto según grupo étnico o dieta).
*/

CREATE TABLE Dim_ActividadFisica (
ID_ActividadFisica INT AUTO_INCREMENT NOT NULL,
ActividadFisica VARCHAR(100),
PRIMARY KEY (ID_ActividadFisica)
);

CREATE TABLE Dim_ConsumoAlcohol (
ID_ConsumoAlcohol INT AUTO_INCREMENT NOT NULL,
ConsumoAlcohol VARCHAR(100),
PRIMARY KEY (ID_ConsumoAlcohol)
);

CREATE TABLE Dim_Dieta (
ID_Dieta INT AUTO_INCREMENT NOT NULL,
Dieta VARCHAR(100),
PRIMARY KEY (ID_Dieta)
);

CREATE TABLE Dim_NivelEstres (
ID_NivelEstres INT AUTO_INCREMENT NOT NULL,
NivelEstres VARCHAR(100),
PRIMARY KEY (ID_NivelEstres)
);

CREATE TABLE Dim_Etnia (
ID_Etnia INT AUTO_INCREMENT NOT NULL,
Etnia VARCHAR(100),
PRIMARY KEY (ID_Etnia)
);

CREATE TABLE Dim_DolorPecho (
ID_DolorPecho INT AUTO_INCREMENT NOT NULL,
DolorPecho VARCHAR(100),
PRIMARY KEY (ID_DolorPecho)
);

CREATE TABLE Dim_ResultadoECG (
ID_ResultadoECG INT AUTO_INCREMENT NOT NULL,
ResultadoECG VARCHAR(100),
PRIMARY KEY (ID_ResultadoECG)
);

CREATE TABLE Dim_PendienteSegmentoST (
ID_PendienteSegmentoST INT AUTO_INCREMENT NOT NULL,
PendienteSegmentoST VARCHAR(255),
PRIMARY KEY (ID_PendienteSegmentoST)
);

CREATE TABLE Dim_VasosObstruidos (
ID_VasosObstruidos INT AUTO_INCREMENT NOT NULL,
VasosObstruidos VARCHAR(100),
PRIMARY KEY (ID_VasosObstruidos)
);

CREATE TABLE Dim_Talasemia (
ID_Talasemia INT AUTO_INCREMENT NOT NULL,
Talasemia VARCHAR(100),
PRIMARY KEY (ID_Talasemia)
);

/*
Se crea la Tabla de Dimensiones: Dim_Pacientes
Almacena la información sociodemográfica del paciente.
Está normalizada para evitar duplicación y permitir análisis cruzados.
*/

CREATE TABLE Dim_Pacientes (
ID_Paciente INT AUTO_INCREMENT NOT NULL,
Edad INT NOT NULL,
ID_Genero INT NOT NULL,
IngresoAnualUSD DECIMAL(10,2) NOT NULL,
ID_NivelEducativo INT NOT NULL,
ID_LugarResidencia INT NOT NULL,
ID_SituacionLaboral INT NOT NULL,
ID_EstadoCivil INT NOT NULL,
PRIMARY KEY (ID_Paciente),
FOREIGN KEY (ID_Genero) REFERENCES Dim_Genero (ID_Genero),
FOREIGN KEY (ID_NivelEducativo) REFERENCES Dim_NivelEducativo (ID_NivelEducativo),
FOREIGN KEY (ID_LugarResidencia) REFERENCES Dim_LugarResidencia (ID_LugarResidencia),
FOREIGN KEY (ID_SituacionLaboral) REFERENCES Dim_SituacionLaboral (ID_SituacionLaboral),
FOREIGN KEY (ID_EstadoCivil) REFERENCES Dim_EstadoCivil (ID_EstadoCivil)
);

/*
Creo la Tabla de Hechos: Fact_AnalisisCardiacos
Esta tabla contiene datos medidos u observados en estudios cardiológicos realizados a pacientes.
Es el núcleo del modelo, donde se concentran las métricas que serán analizadas. 
Cada fila representa un análisis realizado a un paciente. 
Los campos con valores 0/1 se codifican como TINYINT(1) para representar booleanos de forma eficiente.
*/

CREATE TABLE Fact_AnalisisCardiacos (
ID_AnalisisCardiaco INT AUTO_INCREMENT NOT NULL,
ID_Paciente INT NOT NULL,
Colesterol INT NOT NULL,
PresionArterial INT NOT NULL,
FrecuenciaCardiacaReposo INT NOT NULL,
IndiceMasaCorporal DECIMAL(10,2) NOT NULL,
Fumador TINYINT NOT NULL,
Diabetes TINYINT NOT NULL,
Hipertension TINYINT NOT NULL,
AntecedentesFamiliares TINYINT NOT NULL,
ID_ActividadFisica INT NOT NULL,
ID_ConsumoAlcohol INT NOT NULL,
ID_Dieta INT NOT NULL,
ID_NivelEstres INT NOT NULL,
ID_Etnia INT NOT NULL,
UsoMedicacionCardiaca TINYINT NOT NULL,
ID_DolorPecho INT NOT NULL,
ID_ResultadoECG INT NOT NULL,
FrecuenciaCardiacaMaxEsfuerzo INT NOT NULL,
DepresionSegmentoST DECIMAL(10,2) NOT NULL,
AnginaPorEjercicio TINYINT NOT NULL,
ID_PendienteSegmentoST INT NOT NULL,
ID_VasosObstruidos INT NOT NULL,
ID_Talasemia INT NOT NULL,
InfartoPrevio TINYINT NOT NULL,
ACVPrevio TINYINT NOT NULL,
Resultado TINYINT NOT NULL,
PRIMARY KEY (ID_AnalisisCardiaco),
FOREIGN KEY (ID_Paciente) REFERENCES Dim_Pacientes (ID_Paciente),
FOREIGN KEY (ID_ActividadFisica) REFERENCES Dim_ActividadFisica (ID_ActividadFisica),
FOREIGN KEY (ID_ConsumoAlcohol) REFERENCES Dim_ConsumoAlcohol (ID_ConsumoAlcohol),
FOREIGN KEY (ID_Dieta) REFERENCES Dim_Dieta (ID_Dieta),
FOREIGN KEY (ID_NivelEstres) REFERENCES Dim_NivelEstres (ID_NivelEstres),
FOREIGN KEY (ID_Etnia) REFERENCES Dim_Etnia (ID_Etnia),
FOREIGN KEY (ID_DolorPecho) REFERENCES Dim_DolorPecho (ID_DolorPecho),
FOREIGN KEY (ID_ResultadoECG) REFERENCES Dim_ResultadoECG (ID_ResultadoECG),
FOREIGN KEY (ID_PendienteSegmentoST) REFERENCES Dim_PendienteSegmentoST (ID_PendienteSegmentoST),
FOREIGN KEY (ID_VasosObstruidos) REFERENCES Dim_VasosObstruidos (ID_VasosObstruidos),
FOREIGN KEY (ID_Talasemia) REFERENCES Dim_Talasemia (ID_Talasemia)
);