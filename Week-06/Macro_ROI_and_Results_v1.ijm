/** 
 * Regions of Interest & Results Tables
 * ----------------------------------------------
 * 
 * In this short macro we showcase roiManager functions and how ROIs can be manipulated in ImageJ
 * This extended version of the macro covers how results tables can be accessed and customized
 * 
 * Due to the simple nature of this code, no copyright is applicable
 * 
 * Code created for Image Processing and Analysis For Life Scientists MOOC on EdX
 * https://www.edx.org/course/image-processing-and-analysis-for-life-scientists
 * 
 * 2018 - Romain Guiet, Olivier Burri - EPFL - SV - BIOP
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

// 
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


// Create a nicer result table for the user with the areas

// The simplest way, if there will only be one results table for one image
// We can just grab the results at each row number and store it
areaLargeRoi 	= getResult("Area",0) ;
areaSmallRoi 	= getResult("Area",1) ;
areaOrROI 		= getResult("Area",2) ;
areaAndRoi 		= getResult("Area",3) ;
areaXorROI 		= getResult("Area",4) ;

// ########### The lines above only work for a Results table with a single image ###########
// ###########         Any result row after the 5th one would be ignored         ###########

// Because getResult and setResult only work with a window exactly called "Results", 
// we need to rename the old one before starting a new one.
// We could also use run("Clear Results"); but this way we keep the raw data just in case
IJ.renameResults("Raw"); // keep the raw measurements aside

// Suppose we want to call our new measurements table "Custom" by the end of the processing

// We need to make sure that Custom does not already exist from a previous run, as this might cause bugs.
if( isOpen("Custom") ) { 
	selectWindow("Custom");
	run("Close");
}

// Because there is no window called Results anymore, calling setResult will create a new one automatically 
// create a new table with "custom" values
setResult("Label",0,"Measured Area") ; // Label for the given row, the 0 is the column

// The next setResult will add data to the newly created Results window.
// In the following cases, we are staying on the same row (0) and adding new columns
setResult("Image Name",0 , getTitle()); 
setResult("Large"	,0 , areaLargeRoi) ; 
setResult("Small"	,0 , areaSmallRoi) ;
setResult("OR"		,0 , areaOrROI) ; // Union
setResult("And"		,0 , areaAndRoi) ;// Intersection 
setResult("XOR"		,0 , areaXorROI) ;// Exclusion

// And we can perform some computations to obtain custom values
setResult("Large/OR Ratio",0 , (areaLargeRoi / areaOrROI) ) ;
setResult("Small/OR Ratio",0 , (areaSmallRoi / areaOrROI) ) ;
updateResults;

// Here we will rename our results "Custom"
IJ.renameResults("Custom");

// And bring back the original results tables name
IJ.renameResults("Raw","Results"); // bring back the raw measurements as a Results window. New results will be appended to this one and not to our custom one.

// Our custom results are exactly behind the Results window, so we need to make it come to the front
selectWindow("Custom");