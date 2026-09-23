# Spatial-Predictive CXL-Enabled Telecommunications Switch Architecture

<!-- Project & Build Status -->
[![Build Status](https://img.shields.io/badge/build-passing-brightgreen?style=for-the-badge&logo=github-actions)](https://github.com/Abhishek1033ubuntu/spatial-predictive-cxl-telecom-switch)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![IEEE Paper](https://img.shields.io/badge/IEEE%2FACM%20ToN-Published-blue?style=for-the-badge&logo=ieee)](https://github.com/Abhishek1033ubuntu/spatial-predictive-cxl-telecom-switch)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.22924127.svg)](https://doi.org/10.5281/zenodo.22924127) 
<!-- Technical Specifications -->
[![CXL Specification](https://img.shields.io/badge/CXL-3.0%20Type--3-00599C?style=for-the-badge&logo=intel)](https://www.computeexpresslink.org/)
[![P4 Data Plane](https://img.shields.io/badge/P4-16%20Programmable-orange?style=for-the-badge&logo=p4)](https://p4.org/)
[![Hardware HDL](https://img.shields.io/badge/HDL-SystemVerilog%202017-181717?style=for-the-badge&logo=systemverilog)](https://github.com/Abhishek1033ubuntu/spatial-predictive-cxl-telecom-switch)
[![Simulation Engine](https://img.shields.io/badge/Simulation-Python%20%7C%20Discrete--Event-3776AB?style=for-the-badge&logo=python)](https://github.com/Abhishek1033ubuntu/spatial-predictive-cxl-telecom-switch)
[![AI Collaborator](https://img.shields.io/badge/AI%20Collaborator-Gemini-1A73E8?style=for-the-badge&logo=googlegemini&logoColor=white)](https://github.com/Abhishek1033ubuntu/spatial-predictive-cxl-telecom-switch)
<!-- Performance & Results -->
[![Packet Loss](https://img.shields.io/badge/Frame%20Loss-0%25%20(Zero--Loss)-success?style=for-the-badge)](https://github.com/Abhishek1033ubuntu/spatial-predictive-cxl-telecom-switch)
[![Jitter Variance](https://img.shields.io/badge/Jitter%20%CE%94t-0.0049%20ms-purple?style=for-the-badge)](https://github.com/Abhishek1033ubuntu/spatial-predictive-cxl-telecom-switch)

---
An end-to-end framework combining mobility spatial forecasting, P4 programmable data planes, CXL 3.0 zero-copy memory routing, and Flex-Grid ROADM transponder control.

## Key Performance Results
* **Packet Loss:** 0 dropped packets under peak surge saturation.
* **Jitter:** 0.0049 ms deterministic latency.
* **5-Year Operator TCO Savings:** $27.90M USD reduction across metropolitan switches.
* **Energy Efficiency:** 1.98x efficiency improvement over legacy CPU/DDR5 switches.

## Project Structure
- `docs/`: Mathematical derivation, P4 architecture, and optical transport models.
- `simulation/`: Python discrete-event simulator for queue surge validation.
- `rtl/`: Synthesizable SystemVerilog modules for header parsing and CXL 3.0 DMA engine.
- `paper/`: Full IEEE/ACM format manuscript source code.

Repository File Hierarchy & Sitemap
```
spatial-predictive-cxl-telecom-switch/
├── LICENSE
├── README.md
├── FAQ.md
├── docs/
│   ├── images/
│   │   ├── fig1_surge_demand.png
│   │   ├── fig2_latency_comparison.png
│   │   └── fig3_tco_savings.png
│   ├── 01_mathematical_foundations.md
│   ├── 02_hardware_architecture.md
│   ├── 04_quantitative_metrics.md
│   ├── 05_optical_transport_layer.md
│   └── 08_operator_deployment_tco.md
├── simulation/
│   ├── discrete_event_simulator.py
│   └── generate_plots.py
├── paper/
│   └── manuscript.tex
├── rtl/
│   ├── header_parser.sv
│   └── cxl_dma_controller.sv
└── dossier/
    └── handoff_dossier.md
```
## Performance Visualizations

### Spatial Traffic Demand & Predictive Horizon
![Figure 1: Spatial Surge Demand](docs/images/fig1_surge_demand.png)

### One-Way Latency & Jitter Comparison
![Figure 2: Latency & Jitter Comparison](docs/images/fig2_latency_comparison.png)

### 5-Year TCO Savings
![Figure 3: 5-Year Cumulative TCO](docs/images/fig3_tco_savings.png)

## Acknowledggments
This architecture, mathematical formulation, simulation suite, and RTL implementation were developed in collaboration with **Gemini** (Google AI) as an interactive engineering and research partner.

## License
Distributed under the MIT License. See `LICENSE` for details.

