# Section 1: Mathematical Foundations & Governing Equations

## 1. Spatial Mobility & Population Surge Wave Function
The time-varying population density $P_i(t)$ across regional network nodes $i \in \{1, 2, \dots, N\}$ during commuting surges is modeled as a superposition of Gaussian mobility wave functions:

$$P_i(t) = \beta_i + \sum_{k=1}^{K} A_{i,k} \exp\left( -\frac{(t - \tau_{i,k})^2}{2\sigma_{i,k}^2} \right)$$

Where:
- $\beta_i$: Baseline static population density at Node $i$.
- $A_{i,k}$: Peak surge amplitude for commuting wave $k$.
- $\tau_{i,k}$: Temporal center (peak time) of wave $k$.
- $\sigma_{i,k}$: Temporal dispersion (half-width) of wave $k$.

The spatial population mobility velocity vector is defined as:

$$\frac{dP_i}{dt} = -\sum_{k=1}^{K} A_{i,k} \left( \frac{t - \tau_{i,k}}{\sigma_{i,k}^2} \right) \exp\left( -\frac{(t - \tau_{i,k})^2}{2\sigma_{i,k}^2} \right)$$

## 2. Ingress Traffic Demand Rate
The packet arrival rate $\lambda_i(t)$ at Node $i$'s switching ASIC scales linearly with spatial density and mobility velocity headroom:

$$\lambda_i(t) = \gamma \cdot P_i(t) + \eta \cdot \max\left( 0, \frac{dP_i}{dt} \right)$$

Where:
- $\gamma$: Average packet generation rate per unit population ($1.2 \text{ pkts/ms/capita}$).
- $\eta$: Surge acceleration penalty coefficient ($0.45$).

## 3. Spatial-Predictive Capacity Allocation Envelope
To eliminate reactive control delay, the Predictive Controller projects capacity over a lookahead horizon $\Delta T_{\text{lead}} = 25\text{ minutes}$:

$$C_i^{\text{pred}}(t) = \max \left( C_{\text{min}}, \min\left( C_{\text{max}}, \alpha \cdot \max_{\tau \in [t, t + \Delta T_{\text{lead}}]} \lambda_i(\tau) \right) \right)$$

Where:
- $\alpha$: Safety headroom coefficient ($1.18$).
- $C_{\text{min}}, C_{\text{max}}$: Minimum and maximum hardware channel bounds.

## 4. Latency Decomposition Model
Total one-way packet transit latency $T_{\text{latency}}$ is decomposed into four distinct hardware components:

$$T_{\text{latency}} = T_{\text{prop}} + T_{\text{trans}} + T_{\text{queue}} + T_{\text{stack}}$$

1. Optical Propagation Delay ($T_{\text{prop}}$): $T_{\text{prop}} = \frac{d}{v_{\text{fiber}}} = \frac{4150\text{ km}}{2 \times 10^5\text{ km/s}} = 20.75\text{ ms}$.
2. Transmission Delay ($T_{\text{trans}}$): $T_{\text{trans}} = \frac{L_{\text{packet}}}{R_{\text{link}}} = \frac{1500 \times 8 \text{ bits}}{400 \times 10^9 \text{ bps}} = 0.00003\text{ ms}$.
3. Queueing Delay ($T_{\text{queue}}$): Governed by M/M/1/K finite buffer bounds.
4. OS Kernel Stack Processing Delay ($T_{\text{stack}}$): Bypassed to $\approx 0\text{ ms}$ under direct CXL 3.0 zero-copy DMA.
