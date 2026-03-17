FPGA : PYNQ-Z2<br>
Frequency = 125Mhz

Tool : PyThorch, Vivado

CNN Structure
The structure of the adopted CNN is 2-layer below, and the parameters are set as follows.<br>

● Batch Size = 64<br>
● Training Epoch = 10<br>
● Learning Rate = 0.01<br>
● Optimizer = Stochastical Gradient Descent (Momentum = 0.5)<br>
● Activation Function = ReLU<br>
![project image](img/CNN.png)

Design Goal
1. Weight extraction and quantization using PyTorch<br>
   1) Leverages CNN models trained with PyTorch<br>
   2) Weight and bias extraction and purification<br>
   3) Applying log2-based quantization<br>
   4) .txt file conversion and save and read<br>

   ![project image](img/result_pythorch.png)















in the bottom, it is our presentation.   
[Uploading 최종ppt_final.pptx…]()
