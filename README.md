# Explorador Interactivo de Prevalencia - EVCNNA El Salvador 2017

🚀 **[Abrir Dashboard Interactivo en Vivo (R Shiny / WebAssembly)](https://jonathanm86.github.io/Portafolio_UNICEF_EVCNNA/)**

---

## Descripción del Proyecto
Este repositorio contiene el código fuente en R (`app.R`) y el despliegue web estático (`docs/`) de una aplicación analítica interactiva desarrollada en **Shiny**. Su objetivo es explorar y visualizar los indicadores oficiales de la **Encuesta de Violencia contra Niños, Niñas y Adolescentes (EVCNNA) 2017** de El Salvador.

### Respaldo Metodológico e Institucional
Como parte de mi trayectoria en estadística oficial, colaboré en el **diseño del muestreo estadístico** de esta encuesta de alcance nacional durante mi gestión en la Dirección General de Estadística y Censos (DIGESTYC). 
* **Documento oficial de referencia:** [Encuesta de Violencia contra Niños, Niñas y Adolescentes El Salvador 2017](https://nortedecentroamerica.iom.int/es/resources/encuesta-de-violencia-contra-ninos-ninas-y-adolescentes-el-salvador-2017) *(Créditos técnicos en la página 12 - iv)*.

---

## Capacidades Técnicas Demostradas en R
* **Estructuración de datos oficiales:** Construcción programática de matrices de prevalencia derivadas de los tabulados anexos oficiales (Tablas 4.1.1, 5.1.1, 6.1.1, 4.2.1, 5.2.1 y 6.2.1).
* **Control de diseño muestral complejo:** Visualización dinámica mediante `ggplot2` que incorpora las barras de error correspondientes a los **Intervalos de Confianza del 95%**, permitiendo evaluar la significancia estadística de las brechas por sexo y grupo etario (13–17 y 18–24 años).
* **Reactividad e interactividad:** Filtrado dinámico en tiempo real (`dplyr` + `shiny`) y despliegue de tabulados auditables mediante `DT`.
* **Despliegue sin servidor (`shinylive`):** Compilación del entorno R a WebAssembly para ejecución directa en navegador web mediante GitHub Pages.

---

**Autor:** Jonathan Moran Monterrosa  
*Especialista en Métodos Cuantitativos, Diseño Muestral y Evaluación de Impacto*
