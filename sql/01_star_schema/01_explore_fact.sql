/*
===========================================================
Tema 01 - Star Schema
Archivo: 01_explore_fact.sql
===========================================================

Objetivo:
Explorar una tabla de hechos para conocer su estructura
antes de empezar a trabajar con ella.

Comprobaciones:
- Cobertura temporal
- Número de registros
- Valores nulos en IDs
- Cardinalidad de las dimensiones

*/

SELECT
    MIN(date_dt) AS min_date,
    MAX(date_dt) AS max_date,

    COUNT(*) AS total_rows,

    COUNTIF(campaign_id IS NULL) AS null_campaign_id,
    COUNTIF(placement_id IS NULL) AS null_placement_id,
    COUNTIF(ad_id IS NULL) AS null_ad_id,
    COUNTIF(advertiser_id IS NULL) AS null_advertiser_id,
    COUNTIF(device_id IS NULL) AS null_device_id,
    COUNTIF(client_id IS NULL) AS null_client_id,
    COUNTIF(source_id IS NULL) AS null_source_id,

    COUNT(DISTINCT campaign_id) AS campaign_ids,
    COUNT(DISTINCT placement_id) AS placement_ids,
    COUNT(DISTINCT ad_id) AS ad_ids,
    COUNT(DISTINCT advertiser_id) AS advertiser_ids

FROM `project.dataset.premium_facts`;
