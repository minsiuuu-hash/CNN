# CNN FPGA Implementation

FPGA : PYNQ-Z2  
Frequency : 125 MHz  

Tool : PyTorch, Vivado  
Baseline : [CNN-Implementation-in-Verilog](https://github.com/boaaaang/CNN-Implementation-in-Verilog)

---

## Design Goal

### 1. Weight Extraction and Quantization Using PyTorch

1. Leverages CNN models trained with PyTorch
2. Weight and bias extraction and processing
3. Applying log2-based quantization
4. `.txt` file conversion, save, and read

### 2. RTL Design Using Vivado

1. Table `.v` file

![project image](img/RTL.png)

2. To reduce hardware resource usage and power consumption, the Log2 shift method is used instead of division operation.

The Log2 shift method replaces complex arithmetic operations with shift-based operations.  
By using shift operations instead of division or multiplication, the hardware structure can be simplified and DSP usage can be reduced.

---

## Log2 Quantization and Shift Operation

To use the Log2 shift method, the original CNN weights were quantized into Log2-based values.

In this process, each weight value is converted into a signed power-of-two representation.  
The sign bit represents whether the weight is positive or negative, and the remaining bits represent the shift amount.

```text
Original weight
      ↓
Log2-based quantization
      ↓
Signed power-of-two value
      ↓
Shift-based operation
```

After quantization, multiplication operations can be replaced by shift operations in RTL.

```verilog
acc = acc + (weight == 4'b1111 ? 0 :
            weight[3] ? -(input << weight[2:0]) :
                         (input << weight[2:0]));
```

This quantization process simplifies small or less meaningful weight values and reduces unnecessary arithmetic complexity.  
As a result, the CNN model can be implemented with lower hardware cost while maintaining or improving classification accuracy.

---

## CNN Structure

The adopted CNN has a 2-layer structure, and the parameters are set as follows.

MNIST Dataset is used for training and testing.

| Parameter | Value |
|---|---|
| Batch Size | 64 |
| Training Epoch | 10 |
| Learning Rate | 0.01 |
| Optimizer | Stochastic Gradient Descent, Momentum = 0.5 |
| Activation Function | ReLU |

![project image](img/CNN.png)

The trained model achieved about 96% accuracy.

![project image](img/pytorch_result.png)

---

## Accuracy Result

The CNN model was tested using 1000 MNIST test images.

| Item | Result |
|---|---:|
| Test Images | 1000 |
| Correct Images | 959 |
| Wrong Images | 41 |
| Final Accuracy | 95.9% |

The baseline model showed about 91% accuracy, and the Log2 shift-based quantized model improved the accuracy to **95.9%**.

This result shows that the Log2 quantization reduced hardware complexity and improved the classification accuracy in this experiment.

---

## RTL Code Block Diagram

![project image](img/blockdiagram.png)

---

## Simulation Result

Input : `1000`

![project image](img/simulation_result_console.png)

The simulation result was checked to verify that the RTL design produces the expected output value.

---

## Board Verification

The CNN RTL design was implemented on the PYNQ-Z2 board.

After synthesis and implementation in Vivado, the bitstream was generated and uploaded to the board.  
The output value was checked on the board to verify that the CNN operation works correctly in hardware.

---

## Inference Speed Comparison

The inference speed was compared between CPU-based PyTorch execution and FPGA-based Vivado simulation.

| Platform | Average Inference Time | Clock Frequency | Clock Count |
|---|---:|---:|---:|
| Intel i7-6700 CPU PyTorch | 683.9495 us | 3.40 GHz | 2,325,428.3 |
| PYNQ-Z2 FPGA Vivado Simulation | 13.32 us | 100 MHz | 1,332 |

The FPGA-based CNN inference reduced the average inference time by about **51.35×** compared to CPU-based PyTorch execution.

---

## Resource Comparison

![project image](img/using_source.png)

The resource usage was compared to check the effect of the Log2 shift method.

| Resource | Description |
|---|---|
| LUT | Logic resource used for combinational logic |
| FF | Register resource used for sequential logic |
| DSP | Hardware arithmetic block used for multiplication and complex operations |
| BRAM | Memory block used for storing data or parameters |

By replacing arithmetic operations with shift-based operations, the design reduces the need for DSP blocks.  
As a result, the CNN operation can be implemented with lower hardware resource usage.

---

## Power Comparison

The power consumption was compared before and after applying the Log2 shift-based CNN model.

| Item | Before Log2 Shift | After Log2 Shift | Reduction |
|---|---:|---:|---:|
| Total On-Chip Power | 0.142 W | 0.128 W | 9.9% |
| Dynamic Power | 0.039 W | 0.025 W | 35.9% |

By replacing arithmetic operations with shift-based operations, the CNN hardware reduced total power consumption and dynamic power consumption.

Especially, dynamic power was reduced by about **35.9%**, which shows that the Log2 shift method is effective for low-power FPGA implementation.

---

## Summary

| Metric | Result |
|---|---:|
| Accuracy Improvement | 91% → 95.9% |
| Average Inference Time Reduction | About 51.35× |
| Total On-Chip Power Reduction | 9.9% |
| Dynamic Power Reduction | 35.9% |

The Log2 shift-based CNN improved accuracy, reduced inference time, and lowered power consumption.  
Therefore, the proposed method is effective for FPGA-based low-power CNN implementation.

---

## Presentation

In the bottom, it is our presentation.

- [캡스톤디자인_CNN.pdf](https://github.com/user-attachments/files/28446940/_CNN.pdf)
