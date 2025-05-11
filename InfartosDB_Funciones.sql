-- Elijo el Schema sobre el cual trabajar
USE DB_Infartos;

/*
Creación de función que clasifica la presión arterial en tres categorías, basandose 
en valores estándares definidos por guías médicas.
*/

DELIMITER //

CREATE FUNCTION fn_IndicePresion(presion INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    IF presion < 120 THEN
        RETURN 'Normal';
    ELSEIF presion BETWEEN 120 AND 139 THEN
        RETURN 'Elevada';
    ELSE
        RETURN 'Alta';
    END IF;
END;
//

DELIMITER ;

-- Consultas para visualizar la categorización de la presión arterial de cada paciente
SELECT PresionArterial, fn_IndicePresion(PresionArterial) AS Categoria
FROM Fact_AnalisisCardiacos;

/* 
Creación de función que devolverá el número total de infartos en 
pacientes que pertenecen a la etnia y género especificados.
*/

DELIMITER //

CREATE FUNCTION fn_InfartosEtniaGenero(etnia VARCHAR(50), genero VARCHAR(10))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE totalInfartos INT;

    -- Contar el número de infartos para la combinación de etnia y género
    SELECT COUNT(ac.ID_Paciente)
    INTO totalInfartos
    FROM Fact_AnalisisCardiacos ac
    JOIN Dim_Etnia et ON ac.ID_Etnia = et.ID_Etnia
    JOIN Dim_Pacientes pa ON ac.ID_Paciente = pa.ID_Paciente
    JOIN Dim_Genero ge ON pa.ID_Genero = ge.ID_Genero
    WHERE et.Etnia = etnia
    AND ge.Genero = genero
    AND ac.Resultado = 1;  -- Consideramos 1 como que el paciente ha tenido infarto

    -- Retornar el valor de totalInfartos
    RETURN totalInfartos;
END;
//

DELIMITER ;

-- Consultas para visualizar cantidad de infartos por etnia y genero masculino
SELECT fn_InfartosEtniaGenero('Asiatica', 'Masculino') AS TotalInfartos;
SELECT fn_InfartosEtniaGenero('Blanca', 'Masculino') AS TotalInfartos;
SELECT fn_InfartosEtniaGenero('Hispana', 'Masculino') AS TotalInfartos;
SELECT fn_InfartosEtniaGenero('Negra', 'Masculino') AS TotalInfartos;
SELECT fn_InfartosEtniaGenero('Otra', 'Masculino') AS TotalInfartos;

-- Consultas para visualizar cantidad de infartos por etnia y género femenino
SELECT fn_InfartosEtniaGenero('Asiatica', 'Femenino') AS TotalInfartos;
SELECT fn_InfartosEtniaGenero('Blanca', 'Femenino') AS TotalInfartos;
SELECT fn_InfartosEtniaGenero('Hispana', 'Femenino') AS TotalInfartos;
SELECT fn_InfartosEtniaGenero('Negra', 'Femenino') AS TotalInfartos;
SELECT fn_InfartosEtniaGenero('Otra', 'Femenino') AS TotalInfartos;

/*
Creación de función que muestra el porcentaje de pacientes diabéticos
que sufrieron un infarto.
*/

DELIMITER //

CREATE FUNCTION fn_PorcentajeDiabeticosConInfarto()
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE totalDiabeticos INT;
    DECLARE diabeticosConInfarto INT;
    DECLARE porcentaje DECIMAL(5,2);

    -- Contar el total de pacientes diabéticos
    SELECT COUNT(*) INTO totalDiabeticos
    FROM Fact_AnalisisCardiacos
    WHERE Diabetes = 1;  -- Suponiendo que 1 indica que el paciente es diabético

    -- Contar el total de pacientes diabéticos que han sufrido un infarto
    SELECT COUNT(*) INTO diabeticosConInfarto
    FROM Fact_AnalisisCardiacos
    WHERE Diabetes = 1 AND Resultado = 1;  -- Suponiendo que 1 indica que el paciente ha tenido un infarto

    -- Calcular el porcentaje
    IF totalDiabeticos > 0 THEN
        SET porcentaje = (diabeticosConInfarto / totalDiabeticos) * 100;
    ELSE
        SET porcentaje = 0;  -- Evitar división por cero
    END IF;

    RETURN porcentaje;
END;
//

DELIMITER ;

-- Consulta para visualizar el porcentaje de los pacientes diabéticos con infarto
SELECT fn_PorcentajeDiabeticosConInfarto() AS PorcentajeDiabeticosConInfarto;