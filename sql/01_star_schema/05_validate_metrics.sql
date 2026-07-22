/*
===========================================================
Tema 01 - Star Schema
Archivo: 05_validate_metrics.sql
===========================================================

Objetivo:
Detectar valores anómalos en las métricas principales
de la tabla de hechos.

En este ejemplo buscamos valores negativos en:
- Cost
- Impressions
- Clicks
*/

SELECT *
FROM `project.dataset.premium_facts`
WHERE
    cost < 0
    OR impressions < 0
    OR clicks < 0;
