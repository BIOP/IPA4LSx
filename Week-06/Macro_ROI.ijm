/** 
 * Region Of Interest
 * ----------------------------------------------
 * 
 * In this short macro we showcase roiManager functions and how ROIs can be manipulated in ImageJ
 * 
 * Due to the simple nature of this code, no copyright is applicable
 * 
 * Code created for Image Processing and Analysis For Life Scientists MOOC on EdX
 * https://www.edx.org/course/image-processing-and-analysis-for-life-scientists
 * 
 * 2018 - Romain Guiet, EPFL - SV - BIOP
 * https://biop.epfl.ch
 */

// clear environment
roiManager("Reset");
run("Close All");
run("Clear Results");

// Create a new image 
newImage("User Drawing", "8-bit black", 512, 512, 1);

// ask user to  draw some ROIs
waitForUser("Please Draw a Large Region Of Interest,\nThen Press 'OK'");
Roi.setName("Large ROI");
roiManager("Add");

waitForUser("Please Draw a smaller ROI overlapping (partially) with the large one,\nThen Press 'OK'");
Roi.setName("Small ROI");
roiManager("Add");

// make AND, OR and XOR ROIs from them
roiManager("Select", newArray(0,1));
roiManager("OR");
roiManager("Add");
roiManager("Select", (roiManager("Count")-1) ); // select the last ROI (newest one ) 
roiManager("Rename", "OR");

roiManager("Select", newArray(0,1));
roiManager("AND");
roiManager("Add");
roiManager("Select", (roiManager("Count")-1) ); 
roiManager("Rename", "AND");

roiManager("Select", newArray(0,1));
roiManager("XOR");
roiManager("Add");
roiManager("Select", (roiManager("Count")-1) ); 
roiManager("Rename", "XOR");

// Create an output image
for(i=0;i<roiManager("Count");i++){
	if (i!=0) run("Add Slice");
	roiManager("Select",i);
	roiManager("Fill");
}
run("Make Composite", "display=Composite");
Stack.setDisplayMode("color");


// Do some measurement 
roiManager("Deselect");
roiManager("Measure");