# ImplicitLNLMethods
The four folders contain the implicit methods presented in the paper “Implicit and Implicit-Explicit Strong Stability Preserving Runge-Kutta Methods with High Linear Order”.  The methods have a naming format of ( ‘number of stages’ s  ‘Linear Order’ p ’ Type.mat).  For example 2s2pDIRKLinear.mat is a method with 2 stages and order of accuracy 2 for Linear problems and is has accuracy designed for Linear problems.  Each file contains the following pieces of information:\\
s - the number of stages of the method\\
p - the order of accuracy of the method\\
r - the SSP coefficient of the method\\
A - The Butcher Tableau for intermediate stages\\
B - The Butcher Tableau for the reconstruction procedure\\
alpha - From the Shu-Osher coefficient Matrix\\
beta  - From the Shu Osher coefficient Matrix\\
v	- From the Shu Osher coefficient Matrix\\
 
Implementation of the scheme can be followed from any paper of SSP time Stepping methods.
The Co-optimized Folder methods correspond to the methods which contain suboptimal SSP coefficients but try to optimize for better linear stability regions ( as presented in the paper).
Any questions about coefficients or need for more methods please contact Zachary Grant (zgrant@umassd.edu) 
