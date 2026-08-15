# Tema 02 - Business Analysis with SQL

Casos de análisis orientados a responder preguntas de negocio utilizando SQL.

---

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

### Conclusión

La segmentación permite identificar campañas con alta inversión y rendimiento inferior al benchmark (`High cost / Low performance`), convirtiéndolas en candidatas prioritarias para revisión.

### Conceptos SQL

`CTEs`, `SAFE_DIVIDE`, agregaciones, `AVG() OVER()`, `CASE` y benchmarks.

---

## Caso 02 - Weekly Performance Drop

### Pregunta de negocio

¿Qué campañas han empeorado significativamente respecto a la semana anterior?

### Enfoque

- Agregar los resultados por semana y campaña.
- Calcular CTR y CPC semanales.
- Comparar cada semana con la anterior mediante `LAG()`.
- Validar que las semanas comparadas sean consecutivas.
- Calcular la variación porcentual de CTR y CPC.
- Detectar deterioro cuando el CTR cae más de un 20% o el CPC aumenta más de un 25%.

### Conclusión

El análisis permite detectar automáticamente campañas con deterioro reciente y priorizar su revisión.

### Conceptos SQL

`DATE_TRUNC`, `LAG`, `PARTITION BY`, `DATE_DIFF`, variaciones porcentuales, `SAFE_DIVIDE` y `CASE`.

---

## Caso 03 - Investment Concentration

### Pregunta de negocio

¿Está la inversión concentrada en unas pocas campañas o distribuida entre muchas?

### Enfoque

- Agregar la inversión por campaña.
- Ordenar las campañas de mayor a menor inversión.
- Calcular el peso de cada campaña sobre la inversión total.
- Calcular la inversión acumulada.
- Analizar el porcentaje acumulado para estudiar la concentración.

### Conclusión

La inversión analizada no presenta una concentración fuerte en unas pocas campañas.

Las campañas principales representan individualmente una proporción reducida del total y es necesario acumular un número elevado de campañas para alcanzar aproximadamente el 80% de la inversión.

Esto indica que la inversión está relativamente distribuida entre muchas campañas.

### Conceptos SQL

`RANK`, `SUM() OVER()`, window functions, suma acumulada y `SAFE_DIVIDE`.

---

## Caso 04 - Scalable Campaigns

### Pregunta de negocio

¿Qué campañas están funcionando bien, mantienen ese rendimiento en el tiempo y podrían ser candidatas a recibir más inversión?

### Enfoque

- Agregar los resultados por campaña y semana.
- Calcular el CTR de cada campaña.
- Comparar coste y CTR con los benchmarks de cada semana.
- Identificar campañas con coste inferior a la media y CTR superior a la media.
- Validar que las semanas analizadas sean realmente consecutivas.
- Comprobar que la campaña cumple los criterios durante al menos 3 semanas consecutivas.

### Conclusión

El análisis permite identificar campañas que combinan un rendimiento superior al benchmark con una inversión relativamente baja y que, además, mantienen este comportamiento durante varias semanas consecutivas.

Estas campañas pueden considerarse candidatas para evaluar un posible aumento de inversión, evitando tomar decisiones basadas únicamente en buenos resultados puntuales.

### Conceptos SQL

`CTEs`, `AVG() OVER()`, `PARTITION BY`, `LAG`, `DATE_DIFF`, `CASE`, benchmarks semanales y análisis de secuencias temporales.

---

## Casos

| Caso | Descripción |
|---|---|
| `01_investment_efficiency.sql` | Segmenta campañas según nivel de inversión y rendimiento frente al benchmark. |
| `02_weekly_performance_drop.sql` | Detecta campañas cuyo rendimiento empeora frente a la semana anterior mediante CTR y CPC. |
| `03_investment_concentration.sql` | Analiza cómo se distribuye la inversión entre campañas y su nivel de concentración. |
| `04_scalable_campaigns.sql` | Identifica campañas con buen rendimiento sostenido y potencial para recibir mayor inversión. |
