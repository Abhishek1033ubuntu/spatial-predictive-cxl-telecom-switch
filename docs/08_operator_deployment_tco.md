# Section 8: Operator Deployment Roadmap & TCO Analysis

## Power Density & Efficiency Comparison
- **Traditional Stack:** High CPU thermal overhead ($1,850\text{ W}$ active CPU, $1,280\text{ W}$ DDR5 RAM) yields an energy index of $0.222\text{ W/Gbps}$.
- **CXL Fast-Path:** Pooled memory and CPU bypass reduce power ($120\text{ W}$ idle CPU, $710\text{ W}$ CXL pools), yielding an energy index of $0.112\text{ W/Gbps}$ (**$1.98\times$ Power Efficiency**).

## 5-Year Financial Model ($ Millions USD)

| Year | Legacy Switch Cumulative TCO | Spatial-Predictive CXL Cumulative TCO | Cumulative Operator Savings |
| :--- | :--- | :--- | :--- |
| **Year 1** | $18.50\text{ M}$ | $13.80\text{ M}$ | **$4.70\text{ M}$** |
| **Year 2** | $26.50\text{ M}$ | $16.00\text{ M}$ | **$10.50\text{ M}$** |
| **Year 3** | $34.50\text{ M}$ | $18.20\text{ M}$ | **$16.30\text{ M}$** |
| **Year 4** | $42.50\text{ M}$ | $20.40\text{ M}$ | **$22.10\text{ M}$** |
| **Year 5** | $50.50\text{ M}$ | $22.60\text{ M}$ | **$27.90\text{ M}$** |

## Phased Operator Deployment Roadmap
- **Phase 1 (Months 1–6):** Software overlay of Spatial Control Engine ($\frac{dP_i}{dt}$) at central orchestrator.
- **Phase 2 (Months 7–12):** Installation of CXL 3.0 Type-3 PCIe add-in cards (AICs) at Main Switching Units (MSUs).
- **Phase 3 (Months 13–24):** Complete end-to-end Flex-Grid ROADM and CXL fast-path deployment.
