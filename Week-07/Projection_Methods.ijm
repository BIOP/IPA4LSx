/** 
 * Projection Methods
 * ----------------------------------------------
 * 
 * In this short macro we showcase how to call ImageJ's Z Projector with a Macro
 * And show an example use case with background subtraction
 * 
 * Due to the simple nature of this code, no copyright is applicable
 * 
 * Code created for Image Processing and Analysis For Life Scientists MOOC on EdX
 * https://www.edx.org/course/image-processing-and-analysis-for-life-scientists
 * 
 * 2018 - Olivier Burri, EPFL - SV - BIOP
 * https://biop.epfl.ch
 */

// This variable defines whether the user sees all the comments appearing as the macro runs.
var show_comments = false;

// Check that the "Trajectories.tif" image is open
if( !isOpen("Trajectories.tif") ) {
	waitForUser("Please Open Trajectories.tif, then press OK.\nThis macro works with any image stack however, results may vary.");
} else {
	selectImage("Trajectories.tif");
}


image_name = getTitle();

// Cleaup
close("\\Others");


// ==== Show multiple projection methods ==== 

// showComment is a custom function defined at the end of the script
showComment("We are going to showcase how to perform different projection methods");

// projectImage is a custom function defined ad the end of the script
projectImage(image_name, "Max Intensity");

// Keep the title, for use later in the code
max_projected_original = getTitle();

showComment("Max Intensity Projection or MIP\nIs very often used and yields dense information with fluorescence data");

projectImage(image_name, "Average Intensity");
showComment("Average Intensity Projection\nYields a 32-bit image with the mean of each x,y pixel along time/depth");

projectImage(image_name, "Sum Slices");
showComment("Sum Slices Projection\nYields a 32-bit image with the sum value of each x,y pixel along time/depth");


// ==== Using a median projection to remove uneven background in a fluorescence image ==== 
showComment("Let us use the median projection to remove the uneven background");

projectImage(image_name, "Median");
median_image = getTitle();

imageCalculator("Subtract create stack", image_name, median_image);
rename("Median Projection-Subtracted "+image_name);
showComment("You can observe the use of the median filter to clean the background of the image\nWe can compare the result by performing a MIP of the original and subtracted images");
projectImage("Median Projection-Subtracted "+image_name, "Max Intensity");
max_projected_corrected = getTitle();

selectImage(max_projected_original);
showComment("Compare "+max_projected_corrected+"\nand "+max_projected_original);


// ==== Custom functions used above ==== 

// Convenience function to show comments if the user wishes so, based on the value
// of the global variable "show_comments" (at the top of this script)
function showComment(comment) {
	if(show_comments) {
		waitForUser(comment);
	}
}

// Shortcut to perform the projection on the desired image and rename it accordingly
function projectImage( image, method ) {
	selectImage( image );
	run("Z Project...", "projection=["+method+"]");	
	rename(method + " - " + image);
}