/* 
 * Image resizing
 * ----------------------------------------------
 * 
 * This short macro showcases the importance of image scaling, make use of a custom function, and the plot profile tool
 * 
 * Due to the simple nature of this code, no copyright is applicable
 * 
 * Code created for Image Processing and Analysis For Life Scientists MOOC on EdX
 * https://www.edx.org/course/image-processing-and-analysis-for-life-scientists
 * 
 * 2018 - Romain Guiet, EPFL - SV - BIOP
 * https://biop.epfl.ch
 */


run("Close All");
print ("\\Clear");

//open the blobs image
run("Blobs (25K)");
ori_blobs_ID = getImageID();
run("Invert LUT");

// use a custom function, to degrade 'blobs' using various scaling
modifiedBy2		= downUpScale (ori_blobs_ID , 2	)	;
modifiedBy5		= downUpScale (ori_blobs_ID , 5	)	;
modifiedBy10	= downUpScale (ori_blobs_ID , 10)	;
// and tile the resulting images
run("Tile");
waitForUser("From the 'blobs' image we created 'degraded' versions by downscaling and upscaling without interpolation.");

// make a stack from the different images
run("Images to Stack", "method=[Copy (top-left)] name=Stack title=[] use"); 
waitForUser("The images are now re-arranged as a Stack.\nDue to downscaling and upscaling, the images have different widths and heights.\nThis is why the bottom and right edges have pixels at 0 in some slices");
// as an alternative you can use method=[Copy (Center)].
// 
// the results would then be different

// here we make a line. by defining the start and end points
makeLine(75, 100, 90, 130);
waitForUser("We also made a line on the image,\nand we will plot the intentities along that line.")

// and here we ask for the plot.
run("Plot Profile");
waitForUser("In the 'Plot' window, click on 'Live'.\nNow, move in the stack using the slider to compare the profiles.\nYou can also move or modify the line by click-dragging its anchor points");

// To continue you can have a look to the CurveFittingDemo :  https://imagej.net/ij/macros/examples/CurveFittingDemo.txt
// that makes use of Fit functions :  https://imagej.net/ij/developer/macro/functions.html#Fit


/*
 * Here is a custom function that creates 
 * a 'degraded' version of a selected 'image'
 * using a defined 'scaleFactor'
 */
function downUpScale (image, scaleFactor ) {
	selectImage( image );
	imageName = getTitle();
	run("Scale...", "x="+(1/scaleFactor)+" y="+(1/scaleFactor)+" interpolation=None create title=temp");
	ds_ID = getImageID();
	
	run("Scale...", "x="+(scaleFactor)+" y="+(scaleFactor)+" interpolation=None create title=["+imageName+"-modBy"+scaleFactor+"]");
	dsup_ID = getImageID();
	
	selectImage( ds_ID );
	close;

	return dsup_ID;
}


