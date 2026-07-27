# ==============================================================================
# PROYECTO FINAL: Análisis de Desacoplamiento CO2 vs PBI
# ==============================================================================

library(tidyverse)

# 1. Cargar datos procesados
datos <- read.csv("data/datos_procesados_latam.csv")

# 2. Calcular la Intensidad de Emisiones (CO2 por unidad de PBI)
# Expresado en gramos de CO2 por USD de PBI
datos_analisis <- datos %>%
  mutate(intensidad_co2 = (co2_pc * 1e6) / pbi_per_capita)

# 3. Crear Tabla Resumen de Indicadores
tabla_resumen <- datos_analisis %>%
  filter(anio %in% c(2000, 2022)) %>%
  select(pais, anio, pbi_per_capita, co2_pc, intensidad_co2) %>%
  pivot_wider(
    names_from = anio, 
    values_from = c(pbi_per_capita, co2_pc, intensidad_co2)
  ) %>%
  mutate(
    var_pbi_pct = ((pbi_per_capita_2022 - pbi_per_capita_2000) / pbi_per_capita_2000) * 100,
    var_co2_pct = ((co2_pc_2022 - co2_pc_2000) / co2_pc_2000) * 100,
    var_intensidad_pct = ((intensidad_co2_2022 - intensidad_co2_2000) / intensidad_co2_2000) * 100
  )

write.csv(tabla_resumen, "data/tabla_indicadores_desacoplamiento.csv", row.names = FALSE)

# 4. Visualización Adicional: Evolución de la Intensidad de Emisiones
g_intensidad <- ggplot(datos_analisis, aes(x = anio, y = intensidad_co2, color = pais)) +
  geom_line(linewidth = 0.9) +
  geom_point(size = 1.5) +
  theme_minimal() +
  theme(
    legend.position = "right",
    legend.title = element_text(size = 9, face = "bold"),
    legend.text = element_text(size = 8),
    plot.caption = element_text(size = 7, face = "italic")
  ) +
  labs(
    title = "Evolución de la Intensidad de Carbono (2000-2022)",
    subtitle = "Gramos de CO2 generados por cada Dólar de PBI per cápita",
    x = "Año", 
    y = "Gramos CO2 / USD PBI pc", 
    color = "País",
    caption = "Fuente: Elaboración propia a partir de datos de OWID"
  )
ggsave("figures/grafico5_intensidad_co2.png", plot = g_intensidad, width = 8, height = 5, dpi = 300)