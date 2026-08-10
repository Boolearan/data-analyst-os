/*
===========================================================
Tema 02 - Business Analysis with SQL
Caso 02 - Weekly Performance Drop
===========================================================

Pregunta de negocio:
¿Qué campañas han empeorado significativamente respecto
a la semana anterior?

**Lógica**

- Agregación semanal por campaña.
- Comparación contra la semana anterior mediante `LAG()`.
- Validación de semanas consecutivas.
- Detección de deterioro cuando:
  - CTR cae más de un 20%.
  - CPC aumenta más de un 25%.

**Conclusión**

El análisis permite detectar automáticamente campañas con deterioro reciente y priorizar su revisión.

**Conceptos SQL**

`DATE_TRUNC`, `LAG`, `PARTITION BY`, `DATE_DIFF`, variaciones porcentuales y `CASE`.
*/

WITH
  base AS (
    SELECT
      DATE_TRUNC(date_dt, WEEK(MONDAY)) AS week,
      campaign_id,
      campaign_name,
      sum(cost) AS cost,
      sum(impressions) AS impressions,
      sum(clicks) AS clicks,
      safe_divide(sum(clicks), sum(impressions)) * 100 AS ctr,
      safe_divide(sum(cost), sum(clicks)) AS cpc,
    FROM `harman.premium_facts`
    JOIN `harman.campaign_dimension`
      USING (campaign_id)
    GROUP BY ALL
    HAVING impressions > 10000
  ),
  previous AS (
    SELECT
      *,
      lag(ctr, 1)
        OVER (PARTITION BY campaign_id ORDER BY week) AS previous_week_ctr,
      lag(cpc, 1)
        OVER (PARTITION BY campaign_id ORDER BY week) AS previous_week_cpc,
      LAG(week)
        OVER (
          PARTITION BY campaign_id
          ORDER BY week
        ) AS previous_week
    FROM base
  ),
  variance AS (
    SELECT
      *,
      safe_divide((ctr - previous_week_ctr), previous_week_ctr) * 100
        AS ctr_change_pct,
      safe_divide((cpc - previous_week_cpc), previous_week_cpc) * 100
        AS cpc_change_pct
    FROM previous
  )
SELECT
  *,
  CASE
    WHEN
      DATE_DIFF(week, previous_week, WEEK) = 1
      AND (ctr_change_pct < -20 OR cpc_change_pct > 25)
      THEN 'performance_drop'
    ELSE 'stable'
    END AS performance_status
FROM variance
ORDER BY campaign_id, week ASC
