-- Elijo el Schema sobre el cual trabajar
USE DB_Infartos;

/*
Creación de vista para identificar pacientes con riesgo cardiovascular alto (5 o más factores de riesgo presentes)
*/

CREATE VIEW vw_PacientesAltoRiesgo AS
SELECT 
	ac.ID_Paciente,
    (ac.Fumador+
    ac.Diabetes+
    ac.Hipertension+
    ac.AntecedentesFamiliares+
    ac.UsoMedicacionCardiaca+
    ac.InfartoPrevio+
    ac.ACVPrevio) AS FactoresDeRiesgo
FROM fact_analisiscardiacos ac 
WHERE 
	(ac.Fumador+
    ac.Diabetes+
    ac.Hipertension+
    ac.AntecedentesFamiliares+
    ac.UsoMedicacionCardiaca+
    ac.InfartoPrevio+
    ac.ACVPrevio) >= 5;
    
SELECT * FROM vw_pacientesaltoriesgo;

/* 
Creación de vista para identificar la cantidad de infartos ocurridos en cada grupo etario
*/

CREATE VIEW vw_InfartosPorGrupoEtario AS
SELECT 
	CASE
		WHEN pa.Edad < 30 THEN '-30'
		WHEN pa.Edad BETWEEN 30 AND 44 THEN '30/44'
        WHEN pa.Edad BETWEEN 45 AND 59 THEN '45/59'
        WHEN pa.Edad >= 60 THEN '+60'
	END AS GrupoEdad,
    COUNT(*) AS CantidadInfartos
FROM fact_analisiscardiacos ac
LEFT JOIN dim_pacientes pa ON ac.ID_Paciente = pa.ID_Paciente
WHERE ac.Resultado = 1
GROUP BY GrupoEdad;

SELECT * FROM vw_infartosporgrupoetario;

/* 
Creación de vista para comparar la frecuencia de infartos según el estilo de vida 
*/
    
CREATE VIEW vw_EstiloVidaVsInfartos AS
SELECT 
    d.Dieta,
    af.ActividadFisica,
    ca.ConsumoAlcohol,
    ne.NivelEstres,
    COUNT(*) AS TotalPacientes,
    SUM(CASE WHEN ac.InfartoPrevio = 1 THEN 1 ELSE 0 END) AS TotalInfartos,
    ROUND(100.0 * SUM(CASE WHEN ac.InfartoPrevio = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS PorcentajeInfartos
FROM Fact_AnalisisCardiacos ac
JOIN Dim_Dieta d ON ac.ID_Dieta = d.ID_Dieta
JOIN Dim_ActividadFisica af ON ac.ID_ActividadFisica = af.ID_ActividadFisica
JOIN Dim_ConsumoAlcohol ca ON ac.ID_ConsumoAlcohol = ca.ID_ConsumoAlcohol
JOIN Dim_NivelEstres ne ON ac.ID_NivelEstres = ne.ID_NivelEstres
GROUP BY d.Dieta, af.ActividadFisica, ca.ConsumoAlcohol, ne.NivelEstres;

SELECT * FROM vw_estilovidavsinfartos;