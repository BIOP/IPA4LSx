/** 
 * Batch-Compatible Segmentation Workflow
 * ----------------------------------------------
 * 
 * Simple Nuclei Segmentation that is compatible with batch processing
 * using Process > Batch > Macro...
 * 
 * Due to the simple nature of this code, no copyright is applicable
 * 
 * Code created for Image Processing and Analysis For Life Scientists MOOC on EdX
 * https://www.edx.org/course/image-processing-and-analysis-for-life-scientists
 * 
 * 2018 - Olivier Burri, EPFL - SV - BIOP
 * https://biop.epfl.ch
 * 
 * WARNING: This macro will APPEND results to a results table each time it is run
 * Keep this in mind if you analyse the same image twice, as this means your results will be duplicated
 * 
 */

channel_segment = 1;
median_radius = 4;
threshold_method = "Otsu";
min_particle_size = 10;


// Get the title of the image
original_image = getTitle();

// Run all the preprocessing needed. Like setting the measurements, closing images, cleaning ROIs
runPreprocessing();

// This does the actual segmentation of the data
runSegmentation(channel_segment, median_radius, threshold_method);

// This produces the results
analyzeParticles(original_image, min_particle_size);

// The postProcessing script creates the output image so that we may check the results
postProcessing(original_image);



// Preprocessing function to prepare Fiji's environement to analyze the image
function runPreprocessing() {
	// Some preprocessing
	// Make sure there are no ROIs in the ROI manager
	roiManager("Reset");
	
	// Ensure we are computing the right results, making sure that 
	// the label is displayed and that we keep the stack position information
	run("Set Measurements...", "area mean shape stack display redirect=None decimal=3");
	
	// We explicitely do not close the results table because
	// we want the results to be appended for each image that will be analysed
	// hence the warning above

	// Close all other images, to reduce clutter
	close("\\Others");
}

// This filters and segments the image so that we get a binary mask at the end
function runSegmentation(channel_segment, median_radius, threshold_method) {
		
	// Run the segmentation. 
	// Duplicate the first channel (DAPI)
	// Filter the image with a median filter and reduce intensity variation by taking the square root
	// Set an auto-threshold and get a mask
	// Clean the mask with a median filter and a watershet
	run("Duplicate...", "title=DAPI duplicate channels="+channel_segment);
	run("Median...", "radius="+median_radius);
	run("32-bit");
	run("Square Root");
	run("Enhance Contrast", "saturated=0.35");
	setAutoThreshold(threshold_method+" dark no-reset");
	//setAutoThreshold("MaxEntropy dark no-reset");
	
	setOption("BlackBackground", true);
	run("Convert to Mask");
	run("Median...", "radius=2");
	//run("Watershed");
	
	// End of segmentation
}

// This analyses the binary images and produces the results table
function analyzeParticles(original_image, min_particle_size) {
	// Generate regions of interest with analzse particles.
	// Filter out particles smaller than 10um2 and exclude the edges
	// We show the count mask, because we will save these as an output
	run("Analyze Particles...", "size="+min_particle_size+"-Infinity show=[Count Masks] exclude add");
	
	// At this point the results are in the ROI manager.
	// We can re-select the original image and measure all channels at once on it using More > MultiMeasure
	selectImage(original_image);
	roiManager("multi-measure measure_all append");
	
	// This has now produced a results table with one result per ROI per channel
}

// This creates the output image that we can use to check whether the segmentation worked or not
function postProcessing(original_image) {
	// Generate output image which contains the count mask as well as the ROI number
	selectImage("Count Masks of DAPI");
	roiManager("Show All with labels");
	run("glasbey on dark");
	run("Flatten"); // This converts the image "What you see is what you get" to RGB
	rename(original_image+" - Segmented");
	// As this is the last active image when the macro ends, it will be automatically 
	// saved as the last step of the batch process, with the same name as the original image.
}
