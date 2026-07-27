# Análisis de Emisiones de CO2 y Desarrollo Económico en América Latina (2000-2022)

**Autora:** Nicol Samantha Alfonzo Orbezo
**Curso:** Ofimatica
**Fuente de Datos:** [Our World in Data (OWID)](https://github.com/owid/co2-data)

---

## Descripción del Proyecto

Este proyecto analiza la relación entre el crecimiento económico (PBI per cápita y PBI total) y las emisiones de dióxido de carbono ($CO_2$) en seis economías latinoamericanas: **Argentina, Brasil, Chile, Colombia, México y Perú**.

---

## Pregunta de Análisis Final

> **¿Existe un desacoplamiento (decoupling) entre el crecimiento del PBI per cápita y las emisiones de $CO_2$ per cápita en las economías analizadas entre 2000 y 2022?**

---

## Estructura del Repositorio

```text
Proyecto_Final/
├── data/
│   ├── datos_procesados_latam.csv         # Dataset limpio y procesado
│   └── tabla_indicadores_desacoplamiento.csv # Tabla de variación del análisis
├── figures/
│   ├── grafico1_co2_evolucion.png          # Evolución CO2 pc
│   ├── grafico2_pbi_vs_co2.png             # Dispersión PBI vs CO2
│   ├── grafico3_pbi_total.png              # Evolución PBI Total
│   ├── grafico4_co2_total_promedio.png     # Promedio CO2 Total
│   ├── grafico5_intensidad_co2.png         # Intensidad de carbono por PBI
│   └── collage_graficos.png                # Collage integrado 2x2
├── scripts/
│   ├── EDA.R                               # Script de procesamiento y EDA
│   └── 04_analisis_final.R                 # Script del análisis final de desacoplamiento
├── README.md                               # Presentación e informe del repositorio
└── Proyecto_Final.Rproj                    # Proyecto RStudio
