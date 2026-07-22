# Tema 01 - Star Schema

## Objetivo

Explorar una tabla de hechos, identificar su granularidad, validar su relación con las dimensiones y calcular KPIs básicos.

## Contenido

| Archivo | Descripción |
|---|---|
| `01_explore_fact.sql` | Explora fechas, número de filas, IDs nulos y cardinalidad. |
| `02_granularity.sql` | Analiza qué combinación de campos identifica cada fila. |
| `03_validate_star_schema.sql` | Comprueba si los JOINs con las dimensiones eliminan o multiplican registros. |
| `04_basic_kpis.sql` | Calcula CTR, CPC y CPM sobre métricas agregadas. |
| `05_validate_metrics.sql` | Detecta valores negativos en las métricas principales. |

## Idea principal

En un modelo estrella, la tabla de hechos almacena métricas e identificadores, mientras que las dimensiones aportan el contexto necesario para analizarlas.

## Nota

Las referencias a proyectos, datasets y tablas reales han sido anonimizadas.
