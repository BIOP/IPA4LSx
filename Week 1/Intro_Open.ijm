/** 
 * Opening Image
 * ----------------------------------------------
 * 
 * This short macro showcases different ways to open an image
 * 
 * Due to the simple nature of this code, no copyright is applicable
 * 
 * Code created for Image Processing and Analysis For Life Scientists MOOC on EdX
 * https://www.edx.org/course/image-processing-and-analysis-for-life-scientists
 * 
 * 2018 - Romain Guiet, EPFL - SV - BIOP
 * https://biop.epfl.ch
 */

// We start by closing all the images
run("Close All");

////
// The images from the menu " File > Open Samples > ... "
// can be opened using the run(name_of_the_image)
run("Blobs (25K)");
waitForUser( "Here, we've opened the 'blobs.gif' image.\nYou can also use the 'CTRL+Shift+B' shortcut." );
run("Gel (105K)");
// it's possible to reorganize images on your screen, using "Tile"
run("Tile");
waitForUser("Then we opened 'gel.gif' image and re-organized the images on the screen");

////
// Using File. function(s) and Bio-Formats
// You can see these in https://imagej.net/ij/developer/macro/functions.html#file
////
waitForUser("Now you can ask the user to select a file via a dialog window");
run("Close All");
File.openDialog("Please select an image to open");

// using the function File.name and File.directory
// we can retrieve the name of the last opened image
last_opened_image_name = File.name
print ("The image name is : "+ last_opened_image_name);
// and the folder where it is stored
last_opened_image_directory = File.directory
print ("The folder is : "+ last_opened_image_directory);
// the variables can be concatenated 
last_opened_image_full_path = last_opened_image_directory + last_opened_image_name;
print ("The full path is : "+ last_opened_image_full_path);

open( last_opened_image_full_path );
run("Show Info...");
waitForUser("The image you have selected should now be open");


// For Special Images you can also use the BIO-Formats Importer
run("Bio-Formats Importer", "open=["+last_opened_image_full_path+"]");

// We rename the image to distinguish it from the one opened through File.openDialog
rename("Bio-Formats: "+last_opened_image_name);
run("Show Info...");

// Compare Metadata
run("Tile");
waitForUser("The image you have selected has been opened using the Bio-Formats Importer.\nPlease compare the metadata in the opened 'Info...' Windows.");
