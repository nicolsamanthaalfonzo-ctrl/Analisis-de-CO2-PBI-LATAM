# ==============================================================================
# PROYECTO FINAL: Análisis de Emisiones de CO2 y PBI en América Latina
# ==============================================================================

# 1. Cargar paquetes
if(!require(tidyverse)) install.packages("tidyverse")
if(!require(patchwork)) install.packages("patchwork")

library(tidyverse)
library(patchwork)

# 2. Cargar base de datos desde OWID
url <- "https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv"
datos_raw <- read.csv(url)

# 3. Filtrado y limpieza de datos para Latam (2000-2022)
paises_latam <- c("PER", "CHL", "COL", "MEX", "BRA", "ARG")

datos_latam <- datos_raw %>%
  filter(iso_code %in% paises_latam & year >= 2000) %>%
  mutate(gdp_per_capita = gdp / population) %>%
  select(country, iso_code, year, population, gdp, gdp_per_capita, co2, co2_per_capita) %>%
  rename(
    pais           = country,
    codigo         = iso_code,
    anio           = year,
    poblacion      = population,
    pbi_total      = gdp,
    pbi_per_capita = gdp_per_capita,
    co2_total      = co2,
    co2_pc         = co2_per_capita
  ) %>%
  drop_na(pbi_per_capita, co2_pc) %>%
  arrange(pais, anio)

# Exportar dataset limpio a la carpeta data/
write.csv(datos_latam, "data/datos_procesados_latam.csv", row.names = FALSE)

# ==============================================================================
# CREACIÓN DE GRÁFICOS 
# ==============================================================================

# Gráfico 1: Evolución temporal de CO2 per cápita
g1 <- ggplot(datos_latam, aes(x = anio, y = co2_pc, color = pais)) +
  geom_line(linewidth = 0.8) +
  theme_minimal() +
  theme(
    legend.position = "right", 
    legend.title = element_text(size = 9, face = "bold"),
    legend.text = element_text(size = 8),
    plot.caption = element_text(size = 7, face = "italic")
  ) +
  labs(
    title = "1. CO2 per Cápita (2000-2022)",
    x = "Año", y = "Tons per cápita", color = "País",
    caption = "Fuente: OWID"
  )
ggsave("figures/grafico1_co2_evolucion.png", plot = g1, width = 7, height = 4.5, dpi = 300)

# Gráfico 2: PBI per cápita vs CO2 per cápita
g2 <- ggplot(datos_latam, aes(x = pbi_per_capita, y = co2_pc, color = pais)) +
  geom_point(alpha = 0.7, size = 1.5) +
  geom_smooth(method = "lm", se = FALSE, color = "gray40", linetype = "dashed") +
  theme_minimal() +
  theme(
    legend.position = "right", 
    legend.title = element_text(size = 9, face = "bold"),
    legend.text = element_text(size = 8),
    plot.caption = element_text(size = 7, face = "italic")
  ) +
  labs(
    title = "2. PBI pc vs. CO2 pc",
    x = "PBI per Cápita (USD)", y = "Tons per cápita", color = "País",
    caption = "Fuente: OWID"
  )
ggsave("figures/grafico2_pbi_vs_co2.png", plot = g2, width = 7, height = 4.5, dpi = 300)

# Gráfico 3: Crecimiento del PBI Total
g3 <- ggplot(datos_latam, aes(x = anio, y = pbi_total / 1e9, color = pais)) +
  geom_line(linewidth = 0.8) +
  theme_minimal() +
  theme(
    legend.position = "right", 
    legend.title = element_text(size = 9, face = "bold"),
    legend.text = element_text(size = 8),
    plot.caption = element_text(size = 7, face = "italic")
  ) +
  labs(
    title = "3. Evolución del PBI Total",
    x = "Año", y = "Miles de Millones USD", color = "País",
    caption = "Fuente: OWID"
  )
ggsave("figures/grafico3_pbi_total.png", plot = g3, width = 7, height = 4.5, dpi = 300)

# Gráfico 4: Promedio de Emisiones Totales por País
promedios_co2 <- datos_latam %>%
  group_by(pais) %>%
  summarise(co2_prom = mean(co2_total, na.rm = TRUE))

g4 <- ggplot(promedios_co2, aes(x = reorder(pais, co2_prom), y = co2_prom, fill = pais)) +
  geom_col() +
  coord_flip() +
  theme_minimal() +
  theme(
    legend.position = "right", 
    legend.title = element_text(size = 9, face = "bold"),
    legend.text = element_text(size = 8),
    plot.caption = element_text(size = 7, face = "italic")
  ) +
  labs(
    title = "4. CO2 Total Promedio",
    x = "País", y = "Megatoneladas", fill = "País",
    caption = "Fuente: OWID"
  )
ggsave("figures/grafico4_co2_total_promedio.png", plot = g4, width = 7, height = 4.5, dpi = 300)

# ==============================================================================
# COLLAGE
# ==============================================================================

collage <- (g1 + g2) / (g3 + g4)

ggsave("figures/collage_graficos.png", plot = collage, width = 14, height = 9, dpi = 300)