USE db_infartos;

/* Infartos por Cantidad de Factores de Riesgo */

SELECT 
  (Fumador + Diabetes + Hipertension + AntecedentesFamiliares) AS TotalFactores,
  COUNT(*) AS Pacientes,
  SUM(Resultado) AS Infartos,
  ROUND(SUM(Resultado) / COUNT(*) * 100, 2) AS TasaInfartoPorcentaje
FROM Fact_AnalisisCardiacos
GROUP BY TotalFactores
ORDER BY TotalFactores;

/* Infartos por Grupo Etario y Género */

SELECT 
  CASE
    WHEN p.Edad < 40 THEN '<40'
    WHEN p.Edad BETWEEN 40 AND 60 THEN '40-60'
    ELSE '>60'
  END AS GrupoEtario,
  g.Genero,
  COUNT(*) AS Pacientes,
  SUM(fc.Resultado) AS Infartos
FROM Fact_AnalisisCardiacos fc
JOIN Dim_Pacientes p ON fc.ID_Paciente = p.ID_Paciente
JOIN Dim_Genero g ON p.ID_Genero = g.ID_Genero
GROUP BY GrupoEtario, g.Genero
ORDER BY GrupoEtario, g.Genero;

/* Infartos por Lugar de Residencia */

SELECT 
  lr.LugarResidencia,
  COUNT(*) AS Pacientes,
  SUM(fc.Resultado) AS Infartos
FROM Fact_AnalisisCardiacos fc
JOIN Dim_Pacientes p ON fc.ID_Paciente = p.ID_Paciente
JOIN Dim_LugarResidencia lr ON p.ID_LugarResidencia = lr.ID_LugarResidencia
GROUP BY lr.LugarResidencia
ORDER BY Infartos DESC;

/* Infartos según uso de medicación cardíaca */

SELECT 
  UsoMedicacionCardiaca,
  COUNT(*) AS Pacientes,
  SUM(Resultado) AS Infartos
FROM Fact_AnalisisCardiacos
GROUP BY UsoMedicacionCardiaca;

/* Resumen General: Pacientes, Infartos, Tasa Global */

SELECT 
  COUNT(*) AS TotalPacientes,
  SUM(Resultado) AS TotalInfartos,
  ROUND(SUM(Resultado) / COUNT(*) * 100, 2) AS TasaInfartoPorcentaje
FROM Fact_AnalisisCardiacos;







