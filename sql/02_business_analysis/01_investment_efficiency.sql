/*
===========================================================
Tema 02 - Business Analysis with SQL
Caso 01 - Eficiencia de inversión
===========================================================

Pregunta de negocio:
¿Dónde estamos invirtiendo mucho sin obtener un
rendimiento proporcional?

Enfoque:
1. Agregar métricas a nivel campaña.
2. Excluir campañas con poco volumen.
3. Calcular CTR, CPC y CPM.
4. Calcular benchmarks globales.
5. Segmentar campañas según inversión y rendimiento.
*/

WITH
  base AS (
    SELECT
      campaign_id,
      campaign_name,
      sum(cost) AS cost,
      sum(impressions) AS impressions,
      sum(clicks) AS clicks,
      safe_divide(sum(clicks), sum(impressions)) * 100
        AS ctr,  -- % de usuarios que hacen click después de verlo
      safe_divide(sum(cost), sum(clicks)) AS cpc,  -- coste por click
      safe_divide(sum(cost), sum(impressions)) * 1000
        AS cpm,  -- dinero que se paga por cada 1000 impresiones
    FROM project.dataset.marketing_facts AS f
    JOIN project.dataset.campaign_dimension
      USING (campaign_id)
    GROUP BY campaign_id, campaign_name
    HAVING impressions > 10000
  ),
  averages AS (
    SELECT
      *,
      AVG(cost) OVER () AS average_campaign_cost,
      AVG(ctr) OVER () AS average_campaign_ctr
    FROM base
    GROUP BY ALL
  )
SELECT
  *,
  CASE
    WHEN
      cost > average_campaign_cost
      AND ctr > average_campaign_ctr
      THEN 'High cost / High performance'
    WHEN
      cost > average_campaign_cost
      AND ctr <= average_campaign_ctr
      THEN 'High cost / Low performance'
    WHEN
      cost <= average_campaign_cost
      AND ctr > average_campaign_ctr
      THEN 'Low cost / High performance'
    ELSE 'Low cost / Low performance'
    END AS performance_segment
FROM averages
ORDER BY cost DESC;
