-- Elijo el Schema sobre el cual trabajar
USE DB_Infartos;

/*
Creación de Stored Procedure (procedimiento almacenado) que permite insertar nuevos registros en la tabla Fact_AnalisisCardiacos
de forma más sencilla y organizada.

*/

DELIMITER $$

CREATE PROCEDURE sp_InsertarAnalisisCardiaco(
    IN p_ID_Paciente INT,
    IN p_Colesterol INT,
    IN p_PresionArterial INT,
    IN p_FrecuenciaCardiacaReposo INT,
    IN p_IndiceMasaCorporal DECIMAL(10,2),
    IN p_Fumador TINYINT,
    IN p_Diabetes TINYINT,
    IN p_Hipertension TINYINT,
    IN p_AntecedentesFamiliares TINYINT,
    IN p_ID_ActividadFisica INT,
    IN p_ID_ConsumoAlcohol INT,
    IN p_ID_Dieta INT,
    IN p_ID_NivelEstres INT,
    IN p_ID_Etnia INT,
    IN p_UsoMedicacionCardiaca TINYINT,
    IN p_ID_DolorPecho INT,
    IN p_ID_ResultadoECG INT,
    IN p_FrecuenciaCardiacaMaxEsfuerzo INT,
    IN p_DepresionSegmentoST DECIMAL(10,2),
    IN p_AnginaPorEjercicio TINYINT,
    IN p_ID_PendienteSegmentoST INT,
    IN p_ID_VasosObstruidos INT,
    IN p_ID_Talasemia INT,
    IN p_InfartoPrevio TINYINT,
    IN p_ACVPrevio TINYINT,
    IN p_Resultado TINYINT
)
BEGIN
    INSERT INTO Fact_AnalisisCardiacos (
        ID_Paciente,
        Colesterol,
        PresionArterial,
        FrecuenciaCardiacaReposo,
        IndiceMasaCorporal,
        Fumador,
        Diabetes,
        Hipertension,
        AntecedentesFamiliares,
        ID_ActividadFisica,
        ID_ConsumoAlcohol,
        ID_Dieta,
        ID_NivelEstres,
        ID_Etnia,
        UsoMedicacionCardiaca,
        ID_DolorPecho,
        ID_ResultadoECG,
        FrecuenciaCardiacaMaxEsfuerzo,
        DepresionSegmentoST,
        AnginaPorEjercicio,
        ID_PendienteSegmentoST,
        ID_VasosObstruidos,
        ID_Talasemia,
        InfartoPrevio,
        ACVPrevio,
        Resultado
    )
    VALUES (
        p_ID_Paciente,
        p_Colesterol,
        p_PresionArterial,
        p_FrecuenciaCardiacaReposo,
        p_IndiceMasaCorporal,
        p_Fumador,
        p_Diabetes,
        p_Hipertension,
        p_AntecedentesFamiliares,
        p_ID_ActividadFisica,
        p_ID_ConsumoAlcohol,
        p_ID_Dieta,
        p_ID_NivelEstres,
        p_ID_Etnia,
        p_UsoMedicacionCardiaca,
        p_ID_DolorPecho,
        p_ID_ResultadoECG,
        p_FrecuenciaCardiacaMaxEsfuerzo,
        p_DepresionSegmentoST,
        p_AnginaPorEjercicio,
        p_ID_PendienteSegmentoST,
        p_ID_VasosObstruidos,
        p_ID_Talasemia,
        p_InfartoPrevio,
        p_ACVPrevio,
        p_Resultado
    );
END $$

DELIMITER ;

/*
Creación de Stored Procedure (procedimiento almacenado) que permite recuperar registros de pacientes cuyas mediciones clínicas
están por encima de valores umbral definidos por el usuario.
*/

DELIMITER $$

CREATE PROCEDURE sp_BuscarPacientesAltoRiesgoClinico(
    IN p_ColesterolMin INT,
    IN p_PresionArterialMin INT,
    IN p_IMCMax DECIMAL(10,2),
    IN p_FrecuenciaReposoMax INT
)
BEGIN
    SELECT 
        ID_AnalisisCardiaco,
        ID_Paciente,
        Colesterol,
        PresionArterial,
        IndiceMasaCorporal,
        FrecuenciaCardiacaReposo,
        FrecuenciaCardiacaMaxEsfuerzo,
        DepresionSegmentoST
    FROM Fact_AnalisisCardiacos
    WHERE Colesterol >= p_ColesterolMin
      AND PresionArterial >= p_PresionArterialMin
      AND IndiceMasaCorporal >= p_IMCMax
      AND FrecuenciaCardiacaReposo >= p_FrecuenciaReposoMax;
END $$

DELIMITER ;

/*
Ejemplo de uso
*/

