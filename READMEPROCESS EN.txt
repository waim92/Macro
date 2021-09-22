*******************************************************************************************
-Files have to be placed in "macros" folder in Fiji.
-You can add a shorcut to the macro by adding lines in Fiji Macros> Install Macros
then in the txt file "StartupMacros.fiji" add anywhere: 
	macro "process1 [F2]" {
			runMacro("process1");
		}
with F2 as shortcut key (can be replace).
-Every default value are changeable in the macro (macro>Edit) by changing value in functions or
by putting block in comment (// in front of a single line, or /* block */ ). You can then add back
comment line if needed.
-Quality of analysis depend firstly on the quality of the acquired image, then the precision of the
Contrast/Brightness and Threshold step, and finally by the range of size of the interested cell.
Developp by WILLIAM BITTON
*******************************************************************************************
Prerequisite: Images have to be in 8-bit (Image>Type), and NOT in a stack (Image>Stacks>Stack to Image)
I recommand working on copies of original images and organize different fodler per batch of images to dont lose anything.
You can change parameters of ROI manager to display different informations (Analyze> Set measurements). At the end, you can also
manually add/delete points.


At each step, be careful to APPLY first, then OK in the pop-up window to go next step.
First window allow you to choose with mode you want:
Process 1: Modify images, need to be treated in process 2. Modifying is sequential, step by step
Process 2: Treatment of several imaegs together with co-staining. A new image is made.
Batch: Same as process 1, but the modifying is simultaneous, options are in array, quicker but no previsualisation
   




