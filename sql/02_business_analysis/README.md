# Tema 02 - Business Analysis with SQL

Casos de análisis orientados a responder preguntas de negocio utilizando SQL.

## Caso 01 - Eficiencia de inversión

### Pregunta de negocio

¿Dónde estamos invirtiendo mucho sin obtener un rendimiento proporcional?

### Enfoque

- Agregar resultados a nivel campaña.
- Excluir campañas con volumen insuficiente.
- Calcular CTR, CPC y CPM.
- Calcular benchmarks de coste y CTR.
- Comparar cada campaña con los benchmarks.
- Segmentar las campañas según inversión y rendimiento.

### Segmentos

- High cost / High performance
- High cost / Low performance
- Low cost / High performance
- Low cost / Low performance

### Insight principal

El segmento **High cost / Low performance** permite identificar campañas con alta inversión y rendimiento inferior al benchmark, convirtiéndolas en candidatas prioritarias para revisión.

## Casos

| Caso | Descripción |
|---|---|
| `01_investment_efficiency.sql` | Segmenta campañas según nivel de inversión y rendimiento frente al benchmark. |
| `02_weekly_performance_drop.sql` | Detecta campañas cuyo rendimiento empeora frente a la semana anterior mediante CTR y CPC. |
