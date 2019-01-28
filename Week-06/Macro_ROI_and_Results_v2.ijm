/** 
 * Lookup Tables (LUTs)
 * ----------------------------------------------
 * 
 * This short macro showcases different way to use the Lookup Tables, the while loop, the window dialog getBoolean() 
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

// Create a new image with a unique ID
id = round( random() * 100 );
newImage("User Drawing - "+id, "8-bit black", 512, 512, 1);

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

// Our goal is to have a table with one line == one observation

// We can make our custom table a bit more flexible by using loops and getting the column names directly from the ROI names in the Label column

// We will recover the names of the images and the areas for further processing

n = nResults; // how many rows we have to recover

// Create an array that will contain the areas
areas = newArray(n);

// Create an array that will contain the ROI names
roiNames = newArray(n);

for(i=0; i<n; i++) {

	// Pick up the label
	name = getResultLabel(i);
	// The name is like this 'Image_Name:ROI name:Slice'
	// We do not care about the Slice here, only the image name and the ROI name
	// Split the names at the colon
	splitName = split(name, ':');
	
	// Keep the roiName, which is at index 1
	roiNames[i] = splitName[1];

	// Recover the value of the area
	areas[i] = getResult("Area", i);
}


// Now that everything is set, we can create a new results table
// Because getResult and setResult only work with a window exactly called "Results", 
// we need to rename the old one before starting a new one.
// We could also use run("Clear Results"); but this way we keep the raw data just in case
IJ.renameResults("Raw"); // keep the raw measurements aside


// Suppose we want to call our new measurements table "Custom" by the end of the processing
// We need to check first if there is already a table called "Custom", so that we can APPEND to it
row= 0;
if( isOpen("Custom") ) { 
	IJ.renameResults("Custom", "Results");
	row = nResults; // get the current number of rows
}

// Append data to the table at the correct row
setResult("Label", row, "Measured Area") ; // Label for the given row, the 0 is the column
setResult("Image Name", row, getTitle()); // Add the image name to the table

// Now we go through all the columns we have created
for(i=0; i<n; i++) {
	// We make a new column for each ROI name and add the corresponding area
	setResult(roiNames[i], row, areas[i]);
}

// Now we can do some custom calculations
// For instance compute how much of the Large ROI is contributing to the overlap
// The formula would be (In column names) AND / LARGE ROI * 100 or (the area both have in common divided by the area of the large roi time 100 to have it percent
area_large = getResult("Large ROI", row);
area_and = getResult("AND", row);

// Create new measurement
large_ratio = area_and / area_large * 100;

// Add the new column
setResult("Large ROI % Overlap", row, large_ratio);

updateResults;

// Here we will rename our results "Custom"
IJ.renameResults("Custom");

// And bring back the original results tables name
IJ.renameResults("Raw","Results"); // bring back the raw measurements as a Results window. New results will be appended to this one and not to our custom one.

// Our custom results are exactly behind the Results window, so we need to make it come to the front
selectWindow("Custom");
