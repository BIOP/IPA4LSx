/** 
 * Custom Batch Processing
 * ----------------------------------------------
 * 
 * This script will batch process a folder of images by running the macro specified by the user
 * It will only run on images that have the extension defined by the user
 * 
 * Due to the simple nature of this code, no copyright is applicable
 * 
 * Code created for Image Processing and Analysis For Life Scientists MOOC on EdX
 * https://www.edx.org/course/image-processing-and-analysis-for-life-scientists
 * 
 * 2018 - Olivier Burri, EPFL - SV - BIOP
 * https://biop.epfl.ch
 */


// We will use some Script Parameters to ask the user to define 
// the input folder
// the location of the macro file to batch
// the extension of the image file
// See https://imagej.net/Script_Parameters for information
// These might be incompatible with ImageJ only, so you should run this through Fiji

#@File (label="Input Folder", style="directory") input_folder
#@File (label="Macro Code To Run") macro_code
#@String (label="Image File Extension", value=".tif") extension

// Generic Batch Processing Workflow

// Pre-batch processing steps
// Clean contents of Fiji
run("Close All");
run("Clear Results"); // We can clear the results here, because this script will do all the batch processing
roiManager("Reset");

// Build the output folder
output_folder = input_folder+"/output";
File.makeDirectory(output_folder);

// Get list of all the files in the input folder
files = getFileList(input_folder);

// Now make sure to process only the files with the proper extension
for(i=0; i < lengthOf(files); i++) {
	if(endsWith(files[i], extension)) {

		// Open the image
		open(input_folder+"/"+files[i]);
		
		// Run the selected script
		runMacro(macro_code);

		// Save the last active image
		saveAs("tif", output_folder+"/"+files[i]+"_result.tif");

		// Cleanup for next run
		run("Close All");
	}
}

// Save the results
saveAs("Results", output_folder+"/Results.csv");
// Inform the user that the processing is finished
showMessage("Batch Processing Complete");



