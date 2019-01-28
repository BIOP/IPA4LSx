/** 
 * Minimum Projection Use Case
 * ----------------------------------------------
 * 
 * In standard fluorescence imaging, the minimum intensity projection is seldom used
 * It is more often used in tomography data where the background is bright and not dark
 * 
 * There are, however interesting use cases where a Minimum Intensity Projection can make sense
 * 
 * Due to the simple nature of this code, no copyright is applicable
 * 
 * The dataset used for this code is a small crop of a dataset under Creative Commons Attribution
 * Burri, Olivier, Wolf, Benita, Seitz, Arne, & Gönczy, Pierre. (2017). 
 * TRACMIT Demo Dataset:  http://doi.org/10.5281/zenodo.232218
 * Link to Article: https://www.ncbi.nlm.nih.gov/pubmed/28746386
 * 
 * Code created for Image Processing and Analysis For Life Scientists MOOC on EdX
 * https://www.edx.org/course/image-processing-and-analysis-for-life-scientists
 * 
 * 2018 - Olivier Burri, EPFL - SV - BIOP
 * https://biop.epfl.ch
 */

// This variable defines whether the user sees all the comments appearing as the macro runs.
var show_comments = true;

// Check that the "Trajectories.tif" image is open
if( !isOpen("ASMIT Raw Data Sample.tif") ) {
	waitForUser("Please Open ASMIT Raw Data Sample.tif, then press OK.");
} else {
	selectImage("ASMIT Raw Data Sample.tif");
	if ( getZoom() == 1.0 ) zoomIn();
}

// Some cleanup
close("\\Others");

// Keep the image name for later use
image_name = getTitle();

// This command starts the playing the time series
doCommand("Start Animation");


showComment("This dataset consists of cells undergoing division on L shaped fibronectin patterns." );
showComment("Unfortunately the pattern is on the same channel as the cells.\nBut because it does not move, a Min Projection..." );


// This runs the min projection
run("Z Project...", "projection=[Min Intensity]");	
rename("Min - " + image_name);
zoomIn();
min_projection_name = getTitle();

showComment("...Can help us keep ONLY the pattern and not the cells, which are brighter.");

// Subtracting the background
imageCalculator("Subtract create stack", image_name, min_projection_name);
zoomIn();
showComment("Which we can then subtract from the original image to get the cells only");

doCommand("Start Animation");

run("Tile");
showComment("Note that this is not perfect (Bottom left and top right)\n but works well when the cell is highly mobile (Bottom right)");


// ==== Custom functions used above ==== 

// Convenience function to show comments if the user wishes so, based on the value
// of the global variable "show_comments" (at the top of this script)
function showComment(comment) {
	if(show_comments) {
		waitForUser(comment);
	}
}

// Just a more readable function name that allows us to zoom in the active image
function zoomIn() {
	run("In [+]");
}

