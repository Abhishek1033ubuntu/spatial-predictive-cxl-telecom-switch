# Frequently Asked Questions (FAQ)

## 1. General & Architecture

### Q: What is the core innovation of the Spatial-Predictive CXL Switch Architecture?
**A:** Traditional switches reactively adjust buffers *after* queues begin filling up, leading to packet drops during rapid mobility surges. Our architecture pairs macro-scale spatial population forecasting ($\frac{dP_i}{dt}$) with a 25-minute lookahead horizon. This allows the system to pre-map CXL 3.0 Type-3 zero-copy memory buffers and reconfigure Layer 0 Flex-Grid ROADM optical lightpaths *before* traffic arrives at the switch.

### Q: Why use CXL 3.0 instead of standard PCIe or DDR5 attached to CPUs?
**A:** Standard host CPU packet processing relies on OS kernel network stacks, socket memory buffers, and interrupt handling, which introduce variable tail latencies ($5\text{ ms}$ to $25\text{ ms}$) and jitter. CXL 3.0 Type-3 memory pools enable direct hardware zero-copy DMA writes via cache-coherent memory semantics (`CXL.mem`), bypassing host OS kernel stack processing altogether.

---

## 2. Hardware & Integration

### Q: How does the switch identify fast-path CXL traffic versus standard IP packets?
**A:** The P4 ingress parser inspects incoming frame headers for `EtherType == 0x88F7` (or custom CXL metadata encapsulation). If matched, the match-action pipeline assigns the highest traffic priority (`TC=7`) and dispatches the memory handle directly to the `cxl30_type3_dma_controller` SystemVerilog module. Standard IP traffic (`0x0800`) follows the conventional path.

### Q: Is the SystemVerilog code synthesizable?
**A:** Yes. Both `rtl/header_parser.sv` and `rtl/cxl_dma_controller.sv` are written in standard IEEE 1800-2017 SystemVerilog using single-clock synchronous logic, making them synthesizable on standard FPGA platforms (e.g., AMD Xilinx UltraScale+, Intel Agilex) and ASIC synthesis toolchains.

---

## 3. Optical Transport & Performance

### Q: How does Layer 0 Flex-Grid ROADM integration work?
**A:** The Spatial Control Engine forecasts ingress traffic demand $\hat{\lambda}_{ij}(t + \Delta T_{\text{lead}})$. Depending on the forecasted bandwidth requirements, it dynamically triggers transponder reconfigurations across Flex-Grid optical spectrum slices ($12.5\text{ GHz} \to 37.5\text{ GHz} \to 75.0\text{ GHz}$) and modulation schemes (QPSK $\to$ DP-8QAM $\to$ DP-16QAM).

### Q: How were the latency and TCO numbers calculated?
**A:** Latency, jitter, and packet drop metrics were evaluated using the Python discrete-event simulation engine (`simulation/discrete_event_simulator.py`). The 5-year TCO analysis ($27.90M USD savings) models operational power efficiency ($1.98\times$ improvement over legacy CPU/DDR5 nodes), hardware provisioning reduction across 20 Main Switching Units (MSUs) and 100 Remote Switching Units (RSUs), and reduced buffer over-provisioning overhead.

---

## 4. Development & License

### Q: What license is this project published under?
**A:** This repository is open-source and released under the permissive **MIT License**. You are free to use, modify, distribute, and integrate this code into academic or commercial projects.

### Q: How was this research developed?
**A:** The theoretical mechanics, P4 hardware pipeline, SystemVerilog RTL, simulation framework, and documentation were developed by Abhishek Singh in collaboration with **Gemini** (Google AI) as an AI research and engineering partner.
