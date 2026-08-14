/*
===========================================================
Tema 02 - Business Analysis with SQL
Caso 04 - Scalable Campaigns
===========================================================

Pregunta de negocio:
¿Qué campañas están funcionando bien, mantienen ese
rendimiento en el tiempo y podrían recibir más inversión?

Criterios:
- CTR superior al benchmark semanal.
- Coste inferior al benchmark semanal.
- Cumplimiento de ambos criterios durante al menos
  3 semanas consecutivas.
*/

WITH base AS (
  SELECT
    DATE_TRUNC(date_dt, WEEK(MONDAY)) AS week,
    campaign_id,
    campaign_name,
    SUM(cost) AS cost,
    SAFE_DIVIDE(SUM(clicks), SUM(impressions)) * 100 AS ctr
  FROM `project.dataset.marketing_facts`
  JOIN `project.dataset.campaign_dimension`
    USING (campaign_id)
  GROUP BY ALL
),

averages AS (
  SELECT
    *,
    AVG(cost) OVER (PARTITION BY week) AS avg_cost,
    AVG(ctr) OVER (PARTITION BY week) AS avg_ctr
  FROM base
),

candidate AS (
  SELECT
    *,
    CASE
      WHEN cost < avg_cost
        AND ctr > avg_ctr
      THEN 1
      ELSE 0
    END AS is_candidate
  FROM averages
),

casewhen AS (
  SELECT
    *,
    LAG(week, 1) OVER (
      PARTITION BY campaign_id
      ORDER BY week
    ) AS previous_week,

    LAG(week, 2) OVER (
      PARTITION BY campaign_id
      ORDER BY week
    ) AS previous_2_week,

    CASE
      WHEN DATE_DIFF(
        week,
        LAG(week, 1) OVER (
          PARTITION BY campaign_id
          ORDER BY week
        ),
        WEEK
      ) = 1

      AND DATE_DIFF(
        LAG(week, 1) OVER (
          PARTITION BY campaign_id
          ORDER BY week
        ),
        LAG(week, 2) OVER (
          PARTITION BY campaign_id
          ORDER BY week
        ),
        WEEK
      ) = 1

      THEN 1
      ELSE 0
    END AS is_consecutive,

    LAG(is_candidate, 1) OVER (
      PARTITION BY campaign_id
      ORDER BY week
    ) AS previous_candidate,

    LAG(is_candidate, 2) OVER (
      PARTITION BY campaign_id
      ORDER BY week
    ) AS previous_2_candidate

  FROM candidate
)

SELECT
  *,
  CASE
    WHEN is_consecutive = 1
      AND is_candidate = 1
      AND previous_candidate = 1
      AND previous_2_candidate = 1
    THEN 'Good campaign'
    ELSE 'Bad campaign'
  END AS result

FROM casewhen

ORDER BY campaign_id, week;
