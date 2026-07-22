/*
===========================================================
Tema 01 - Star Schema
Archivo: 04_basic_kpis.sql
===========================================================

Objetivo:
Calcular KPIs básicos de marketing digital a partir
de las métricas almacenadas en la tabla de hechos.

KPIs:
- CTR: Click Through Rate
- CPC: Cost Per Click
- CPM: Cost Per Thousand Impressions
*/

SELECT
    SAFE_DIVIDE(
        SUM(clicks),
        SUM(impressions)
    ) AS ctr,

    SAFE_DIVIDE(
        SUM(cost),
        SUM(clicks)
    ) AS cpc,

    SAFE_DIVIDE(
        SUM(cost) * 1000,
        SUM(impressions)
    ) AS cpm

FROM `project.dataset.premium_facts`;
