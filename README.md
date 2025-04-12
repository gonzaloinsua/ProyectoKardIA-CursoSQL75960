# ProyectoKardIA-CursoSQL75960
Este repositorio contiene todos los archivos utilizados para el Proyecto Final del curso SQL Flex de CoderHouse

# 💓 KardIA – Análisis de Riesgo Cardíaco con SQL

**KardIA** es una aplicación interna ficticia de análisis de datos diseñada para centros de salud, enfocada en la **detección temprana y prevención de enfermedades cardíacas**. Utiliza una base de datos relacional en **SQL**, construida sobre un modelo estrella (star schema), para transformar datos clínicos en información útil para la toma de decisiones médicas.

---

## 📌 Objetivo

Desarrollar una herramienta capaz de:
- Detectar **patrones de riesgo cardiovascular**
- Generar **reportes clínicos automatizados**
- Clasificar pacientes según su **nivel de vulnerabilidad**
- Mejorar la **gestión médica y la asignación de recursos**

---

## 🛠️ Tecnologías Utilizadas

- **SQL (MySQL)** – Modelo relacional optimizado para análisis clínico
- **Dataset original**: Kaggle (10.000 registros clínicos en inglés)
- **Dataset final**: 5.000 registros traducidos al español y reestructurados

---

## 🧱 Estructura de la Base de Datos

- Diseño basado en **modelo estrella**
- Tabla central: `Fact_AnalisisCardiacos`  
- Tablas dimensionales: información del paciente, antecedentes, hábitos, etc.
- Variables categóricas y binarias **codificadas** para mayor eficiencia en análisis
