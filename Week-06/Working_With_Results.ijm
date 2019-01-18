/** 
 * Working with Result Tables
 * ----------------------------------------------
 * 
 * In this short macro we showcase how getResult and setResult can be used to compute new columns
 * 
 * Due to the simple nature of this code, no copyright is applicable
 * 
 * Code created for Image Processing and Analysis For Life Scientists MOOC on EdX
 * https://www.edx.org/course/image-processing-and-analysis-for-life-scientists
 * 
 * 2018 - Olivier Burri, EPFL - SV - BIOP
 * https://biop.epfl.ch
 */

// These thresholds will be used to determine which bacteria should be small, medium or large
// Small  : if under small_threshold
// Medium : if between small_threshold & large_threshold
// Large  : if above large_threshold

small_threshold = 1.0; // microns
large_threshold = 2.0; // microns

// Check that the image is open
if( !isOpen("Bacteria_Crop.tif") ) {
	waitForUser("Please Open the Bacteria_Crop.tif image from Week 5, then press OK.");
}


// Make sure that the "Bacteria_Crop.tif" image is opened and currently active
selectImage("Bacteria_Crop.tif");


// Cleanup Fiji by ensuring no other images or results are open
close("\\Others");
run("Clear Results");

// Perform the segmentation of the bacteria.
// Median Smoothing followed by Default Threshold and Watershed on channel 2 of the image
// See the custom function at the bottom of this script
segmentBacteria(2, 2, "Default");

// Getting the area measurement only (to simplify this example)
run("Set Measurements...", "area display redirect=None decimal=3");

// Running Particle Analysis to get the results and display them
run("Analyze Particles...", "display");


waitForUser("Now we will bin the bacteria by size.\nSee the code for details");

// Bin the bacteria by their sizes
// Small bacteria below 1um2
// Medium, between 1um and 2um
// Large, over 2um

// Get how many results are currently in the results table
number_results = nResults; 

// go through each row and assign new value in a new column called "Size"
for( i=0 ; i<number_results ; i++) {

	// Pick up the area for the current row
	single_area = getResult("Area", i);

	// Categorize it, with a custom function (see at the borrom of this script)
	single_size = getSize(single_area, small_threshold, large_threshold);

	// Write the category to the table
	setResult("Size", i, single_size);
}

// This custom function returns a mask of the bacteria for the selected channel, filter and threshold options
function segmentBacteria(channel, median_size, threshold_method) {
	name = getTitle();
	run("Duplicate...", "title=["+name+" Channel "+channel+"] duplicate channels="+channel);
	run("Median...", "radius="+median_size);
	setAutoThreshold(threshold_method+" dark no-reset");
	setOption("BlackBackground", true);
	run("Convert to Mask");
	run("Watershed");
}

// This custom function returns 
// "Small"  if the area is smaller or equal than the provided small_limit
// "Medium" if the area is larger than small_limit but smaller or equal than large_limit
// "Large"  if the area is larger than the provided large_limit variable
function getSize(area, small_limit, large_limit) {
	if(area <= small_limit) 
		return "Small";
	if(area > small_limit && area <= large_limit) 
		return "Medium";
	if(area > large_limit) 
		return "Large";
}
