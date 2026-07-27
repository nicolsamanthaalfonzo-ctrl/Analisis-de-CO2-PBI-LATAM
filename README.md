# Análisis de Emisiones de CO2 y Desarrollo Económico en América Latina (2000-2022)

**Autora:**  Nicol Samantha Alfonzo Orbezo
**Curso:**  Ofimatica 2026-ECONOMIA 
**Fuente de Datos:** [Our World in Data (OWID)](https://github.com/owid/co2-data)

---

## Descripción del Proyecto

Este proyecto analiza la relación entre el crecimiento económico (medido a través del PBI per cápita y PBI total) y el nivel de emisiones 
de dióxido de carbono (CO2) en seis economías de América Latina: **Argentina, Brasil, Chile, Colombia, México y Perú**.

El objetivo principal es identificar patrones de contaminación y evaluar si el crecimiento de la producción en la región ha estado 
acompañado de una mayor intensidad de carbono per cápita.

---

## Estructura del Repositorio

El repositorio está organizado de la siguiente manera:

```text
Proyecto_Final/
├── data/
│   └── datos_procesados_latam.csv    # Dataset procesado y filtrado
├── figures/
│   ├── grafico1_co2_evolucion.png     # Evolución temporal de CO2 pc
│   ├── grafico2_pbi_vs_co2.png        # Dispersión PBI pc vs CO2 pc
│   ├── grafico3_pbi_total.png         # Crecimiento del PBI Total
│   ├── grafico4_co2_total_promedio.png# CO2 Total promedio por país
│   └── collage_graficos.png           # Panel consolidado 2x2
├── scripts/
│   └── EDA.R                          # Script de limpieza, procesamiento y visualización
