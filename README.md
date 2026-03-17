FPGA : PYNQ-Z2<br>
Frequency = 125Mhz

Tool : PyThorch, Vivado


Design Goal
1. Weight extraction and quantization using PyTorch<br>
   1) Leverages CNN models trained with PyTorch<br>
   2) Weight and bias extraction and purification<br>
   3) Applying log2-based quantization<br>
   4) .txt file conversion and save and read<br>
   
2. Using vivado to design RTL code<br>

   1) Table .v FILE<br>
   ![project image](img/RTL.png) <br>

   
   2) To utilize low power, the Log2 shift method is used instead of dividing.<br>



CNN Structure<br>
The structure of the adopted CNN is 2-layer below, and the parameters are set as follows.<br>
We use MNIST Dataset<br>

● Batch Size = 64<br>
● Training Epoch = 10<br>
● Learning Rate = 0.01<br>
● Optimizer = Stochastical Gradient Descent (Momentum = 0.5)<br>
● Activation Function = ReLU<br>
![project image](img/CNN.png)

we could check the accuracy of about 96%.<br>
![project image](img/pythorch_result.png)

RTL Code BlockDiagram<br>
![project image](img/blockdiagram.png)

Compare Resource
![project image](img/using_source.png)

















in the bottom, it is our presentation.   
[Uploading 최종ppt_final.pptx…]()
