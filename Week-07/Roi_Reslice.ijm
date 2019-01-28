/** 
 * Reslicing ROI Manager Selections
 * ----------------------------------------------
 * 
 * This short macro calls the Reslice tool for each ROI that is found in the ROI Manager. 
 * 
 * Due to the simple nature of this code, no copyright is applicable
 * 
 * Code created for Image Processing and Analysis For Life Scientists MOOC on EdX
 * https://www.edx.org/course/image-processing-and-analysis-for-life-scientists
 * 
 * 2018 - Arne Seitz, EPFL - SV - BIOP
 * https://biop.epfl.ch
 */

// Get the number of ROIs available in the ROI Manager
maxSelect=roiManager("count");

// Get the currently active image
image = getTitle();

// cleanup
close("\\Others");

// Use a for loop to iterate through each ROI
for (i=0;i<maxSelect;i++){

	// Select the original image to apply the ROI on it
	selectImage(image);

	// Activate the ith ROI
	roiManager("Select", i);

	// Run the Reslice Function
	run("Reslice [/]...", "start=Top avoid");

	// Pick up the new image
	reslice = getTitle();

	// Rename it with padding, see https://imagej.net/ij/developer/macro/functions.html#IJ.pad
    rename("Reslice of Substack "+IJ.pad(i,2));
}