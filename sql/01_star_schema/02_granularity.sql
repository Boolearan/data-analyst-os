/*
===========================================================
Tema 01 - Star Schema
Archivo: 02_granularity.sql
===========================================================

Objetivo:
Identificar la granularidad real de la tabla de hechos.

La granularidad representa el nivel de detalle al que
está almacenada la información.

En este ejemplo comprobamos si la combinación de IDs
identifica de forma única cada registro.
*/

SELECT
    date_dt,
    campaign_id,
    placement_id,
    ad_id,
    device_id,
    COUNT(*) AS row_count
FROM `project.dataset.premium_facts`
GROUP BY ALL
HAVING COUNT(*) > 1
ORDER BY row_count DESC;
