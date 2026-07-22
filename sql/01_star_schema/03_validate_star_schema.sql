/*
===========================================================
Tema 01 - Star Schema
Archivo: 03_validate_star_schema.sql
===========================================================

Objetivo:
Comprobar que los JOINs entre la tabla de hechos y las
dimensiones no eliminan ni multiplican registros.

La validación consiste en comparar:
- Número de filas de la Fact
- Número de filas después de aplicar los JOINs
*/

-- Filas originales de la Fact
SELECT
    'fact_only' AS validation_step,
    COUNT(*) AS total_rows
FROM `project.dataset.premium_facts`

UNION ALL

-- Filas después de cruzar la Fact con todas las dimensiones
SELECT
    'fact_with_dimensions' AS validation_step,
    COUNT(*) AS total_rows
FROM `project.dataset.premium_facts` AS f
JOIN `project.dataset.campaign_dimension` AS c
    ON f.campaign_id = c.campaign_id
JOIN `project.dataset.ad_dimension` AS ad
    ON f.ad_id = ad.ad_id
JOIN `project.dataset.advertiser_dimension` AS adv
    ON f.advertiser_id = adv.advertiser_id
JOIN `project.dataset.client_dimension` AS cl
    ON f.client_id = cl.client_id
JOIN `project.dataset.date_dimension` AS d
    ON f.date_dt = d.date_dt
JOIN `project.dataset.device_dimension` AS dev
    ON f.device_id = dev.device_id
JOIN `project.dataset.placement_dimension` AS p
    ON f.placement_id = p.placement_id
JOIN `project.dataset.source_dimension` AS s
    ON f.source_id = s.source_id;
