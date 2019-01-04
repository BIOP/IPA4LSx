/* 
 * Fourier Stripe Filtering
 * ----------------------------------------------
 * 
 * This macro shows an advanced version of the destriping procedure presented in the course slides from 4.3.2
 * 
 * The procedure has 3 steps
 * 1. Detect the angle of the stripes by checking the mean radial intensity in teh Fourier domain
 * 2. Create a mask that we can use in Fourier to 'hide' the frequencies around the detected angle
 * 3. Apply the mask using the Process>FFT>Custom Filter 
 * 
 * NOTE that the stripes are detected in fourier by finding the radius with teh highest mean instansity. 
 * If the original signal has a strong directionality, this method might fail.
 * 
 * Code created for Image Processing and Analysis For Life Scientists MOOC on EdX
 * https://www.edx.org/course/image-processing-and-analysis-for-life-scientists
 * 
 * 
 * 2018 - CC-BY Olivier Burri, EPFL - SV - BIOP
 * https://biop.epfl.ch
 * 
 */

thickness = 25;
start_radius_px = 10;


roiManager("reset");
// Make sure that the image is opened, or ask the user to open it.
if( !isOpen("image_with_stripes.tif") ) {
	run("Close All");
	waitForUser("Please Open 'image_with_stripes.tif'");	
}

selectImage("image_with_stripes.tif");
close("\\Others");

// Make a copy and apply the stripe filter in Fourier
run("Duplicate...", " ");
rename("Destriped Image");
run("FFT");
rename("Original Fourier Transform");
waitForUser("Notice the bright almost vertical line on the Fourier image.\nThis is mostly due to the contribution of the stripes.");

angle = locateAngle();
makeCenteredLine(angle, thickness); // For showing if the computed angles was useful, we display it with a custom function

waitForUser("The angle was determined to be "+angle+" degrees\nWe will now create the Fourier Mask");

// If we know the angle, we can produce a mask in Fourier to hide these frequencies

// We can build a line that
// 1. Goes through the center of the image
// 2. is at 'angle' degrees from the horizontal.
// 3. is 'cut' in the center, to avoid removing interesting low variations
buildCenteredLines(angle, start_radius_px, thickness);

// From these lines, we can build a Fourier mask to use in our image
makeFourierMask();
waitForUser("This is the resulting Fourier Mask.\nYou can look at the code to see how it was created");

// Pick up the name of the fourier mask
filter_name = getTitle();


// We just run the custom filter on the stiped image
selectImage("Destriped Image");
run("Custom Filter...", "filter=["+filter_name+"]");
run("FFT");
rename("Destriped Fourier Transform");
// We can check the difference between the two images to see what was removed
imageCalculator("Subtract create 32-bit", "Destriped Image","image_with_stripes.tif");

rename("Difference between the striped and destriped images");

run("Tile");

waitForUser("See how a simple line mask in Fourier can efectively remove artifacts from the image.");

waitForUser("You can try it yourself on the original striped image\nand using the 'Stripe Mask.tif' image\nOpen both images and use\nProcess>FFT>Custom FIlter...");

function makeFourierMask() {
	// Let's create a Fourier mask
	getDimensions(width, height, channels, slices, frames);
	newImage("Fourier Mask", "32-bit", width, height, 1);
	setForegroundColor(255,255,255);

	// We fill the two thick lines in the image and slighly blurr them to avoid edge effects
	roiManager("Fill");
	
	run("Invert");
	run("Gaussian Blur...", "sigma=5");
	

}

/*
 * locateAngle will make lines from the center of the Fourier image on the two upper quadrants of the image
 * It will compute the line profile and extract the mean value along that line and store it in an array
 * We will then compute, based on the mean values the highest value and find its corresponding angle
 * 
 */
function locateAngle() {
	steps=1000;
	run("Duplicate...", "title=[Angle Detection]");
	// Slight blur to remove noise
	run("Smooth");
	getDimensions(width, height, channels, slices, frames);
	r = width/2;
	angles = newArray(steps);
	intensities = newArray(steps); 
	angle = 0;
	current_mean = 0;

	// Break down the upper two quadrants in small steps and loop through each one
	for(i=0;i<steps; i++) {
		// Get angle in radians
		a = i*PI/steps;

		// Compute first point for the line
		p1x =  r*cos(a) + r;
		p1y = -r*sin(a) + r;
		
		// Second point is mirrored
		p2x = -r*cos(a) + r;
		p2y =  r*sin(a) + r;

		// Make a line and extract its intensity profile
		makeLine(p1x, p1y, p2x, p2y,3);
		line_profile = getProfile();

		// Get the mean intensity along that line
		Array.getStatistics(line_profile, line_min, line_max, line_mean, line_stdDev);
		
		// Save the mean intensity
		intensities[i] = line_mean;
		
		// Get the current angle in degrees
		angles[i] = a/(2*PI)*360;
	}

	// Close the temporary image we duplicated
	close();
	// see https://imagej.net/ij/developer/macro/functions.html#Array.findMaxima
	indexes = Array.findMaxima(intensities, 2, 2);
	highest_value = indexes[0];
	return angles[highest_value];
}

/*
 * This is just a convenience function to draw a centered line at an angle to visualisation
 */
function makeCenteredLine(angle, thickness) {
	angle_radians = angle / 360 * 2*PI;
	width = getWidth();
	r = sqrt(2)*width/2;
	
	// first point
	p1x = r*cos(angle_radians) + width/2;
	p1y = -r*sin(angle_radians) + width/2;
	
	// Second point is mirrored
	p2x = -r*cos(angle_radians) + width/2;
	p2y = r*sin(angle_radians) + width/2;

	makeLine(p1x, p1y, p2x, p2y, thickness);
}

/*
 * This function will make a line centered on the image 
 */
function buildCenteredLines(angle, start_radius, thickness) {
	
	// Get the dimensions of the image
	getDimensions(width, height, channels, slices, frames);

	// Assuming the image is square, the longest distance to an edge is at the corner
	r = sqrt(2)*width/2;
	angle_radians = angle / 360 * 2*PI;
	// Compute first point for the line
	p1x = start_radius*cos(angle_radians) + width/2;
	p1y = -start_radius*sin(angle_radians) + width/2;
	
	// Second point is mirrored
	p2x = r*cos(angle_radians) + width/2;
	p2y = -r*sin(angle_radians) + width/2;
	
	makeLine(p1x, p1y, p2x, p2y, thickness);

	// This command allows us to have two lines instead of one, you can ignore it for now. It will be covered in Week 6
	roiManager("add");

	p1x = -start_radius*cos(angle_radians) + width/2;
	p1y = start_radius*sin(angle_radians) + width/2;
	
	// Second point is mirrored
	p2x = -r*cos(angle_radians) + width/2;
	p2y = r*sin(angle_radians) + width/2;
	
	makeLine(p1x, p1y, p2x, p2y, thickness);
	roiManager("add");
}