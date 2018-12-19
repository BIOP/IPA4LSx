/* 
 * Example of mathematical operations on images
 * 
 * This short macro showcases how we can perform global operations on images using the macro language
 * 
 * Due to the simple nature of this code, no copyright is applicable
 * 
 * Code created for Image Processing and Analysis For Life Scientists MOOC on EdX
 * https://www.edx.org/course/image-processing-and-analysis-for-life-scientists
 * 
 * 2018 - Olivier Burri, EPFL - SV - BIOP
 * https://biop.epfl.ch
 */

run("Close All");
waitForUser("Please open the InSpeck Beads.tif image\nthen press OK");

//We Zoom in to show the image a bit larger
run("In [+]");

// Set the range to be visible on the screen
resetMinAndMax();
run("Enhance Contrast", "saturated=0.35");

// Get information about the image to set the title and select it later
id = getImageID();
title = getTitle();

// Rename it to Original
rename("Original-"+title);


// Define the mathematical operations we want to run
// You can find these under Process > Math
operations = newArray("Log", "Square Root");

// Apply each operation on a copy of the original
for(i=0; i<operations.length; i++) {
	
	selectImage(id);
	run("Duplicate...", "title=["+operations[i]+"-"+title+"]");
	
	// Convert to 32-bit to perform proper image math
	run("32-bit");
	// Set the zoom to make the image a bit larger
	run("In [+]");

	// Running the actual mathematical operation
	run(operations[i]);

	// Set the range to be visible on the screen
	resetMinAndMax();
	run("Enhance Contrast", "saturated=0.35");
}

run("Tile");
waitForUser("You can see the effect on the image by adjusting the brightness and contrast window\nor looking at the histogram for each image");