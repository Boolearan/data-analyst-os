/*
===========================================================
Tema 02 - Business Analysis with SQL
Caso 03 - Investment Concentration
===========================================================

Pregunta de negocio:
¿Está la inversión concentrada en unas pocas campañas
o distribuida entre muchas?

Enfoque:
1. Agregar la inversión a nivel campaña.
2. Ordenar las campañas según su inversión.
3. Calcular el peso de cada campaña sobre el total.
4. Calcular la inversión acumulada.
5. Analizar qué porcentaje del gasto se concentra
   progresivamente en las campañas principales.
*/

WITH
  base AS (
    SELECT
      campaign_id,
      campaign_name,
      sum(cost) AS cost,
      rank() OVER (ORDER BY sum(cost) DESC) rank_by_cost,
      SUM(SUM(cost)) OVER () AS total_cost,
      SAFE_DIVIDE((SUM(cost) * 100.0), SUM(SUM(cost)) OVER ()) AS pct_total_cost
  FROM `project.dataset.marketing_facts`
  JOIN `project.dataset.campaign_dimension`
      USING (campaign_id)
    WHERE cost > 0
    GROUP BY ALL
  ),
  cumulative AS (
    SELECT
      *,
      sum(cost)
        OVER (
          ORDER BY rank_by_cost ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS cumulative_cost
    FROM base
  )
SELECT
  *,
  SAFE_DIVIDE(cumulative_cost, total_cost) * 100 AS cumulative_pct
FROM cumulative
ORDER BY cost DESC
