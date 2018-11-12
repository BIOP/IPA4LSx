/** 
 * Working with Brightness/ Contrast & Histograms 
 * ----------------------------------------------
 * 
 * This short macro showcases different ways in which we can work with and access an image's histogram
 * 
 * Due to the simple nature of this code, no copyright is applicable
 * 
 * Code created for Image Processing and Analysis For Life Scientists MOOC on EdX
 * https://www.edx.org/course/image-processing-and-analysis-for-life-scientists
 * 
 * 2018 - Olivier Burri, EPFL - SV - BIOP
 * https://biop.epfl.ch
 */

// Cleanup data
run("Close All");

// Open sample image
run("Gel (105K)");
// We store this image's unique ID to make sure we can select it later
original = getImageID();

showMessage("You can obtain the histogram for an image by pressing the 'H' key");
run("Histogram"); // Runs the Histogram Command
waitForUser("By Hovering the mouse over the histogram, you can read the\n value and count numbers for that histogram bin");

waitForUser("The way an image is displayed can be modified \nusing Brightness And Contrast Adjustment\nunder \"Image>Adjust>Brightness/Contrast...\"\nor CTRL+SHIFT+C");

run("Brightness/Contrast..."); // Displays Brightness and Contrast Window
selectImage(original);
waitForUser("Press Live on the Histogram window");
selectImage(original); // Re-selects the image when adjusting brightness and contrast
waitForUser("Move the sliders of the B&C window.\nYou'll note the histogram does not change");

waitForUser("The brightness and contrast can be adjusted in a macro as well.\nHere we set the min to 100 and max to 200.");
selectImage(original);
setMinAndMax(100, 200);

waitForUser("Be careful in hitting the \"Apply\" Button\nas this \"burns\" (rescales) the min and max of the image,\nchanging the data!");
run("Apply LUT"); // Macro Equivalent of the "Apply button"

waitForUser("Notice how the histogram has changed. This step cannot be reversed.");
waitForUser("Finally, notice how the first bin of the histogram (at value 0)\nhas a much higher count than the others.\nWe have saturated (clipped) the intensities and lost information");

waitForUser("We can capture the Histogram in a Macro as well. You can look at the code for references");
// You can also get the histogram by using getStatistics(area, mean, min, max, std, histogram);
// But you need to make sure that the original image is selected
selectImage(original);

// Now we can get the statistics. see https://imagej.net/developer/macro/functions.html#getStatistics 
getStatistics(area, mean, min, max, std, histogram);

// Here it is now simple to access the i'th bin
waitForUser("We can then easily query the value of a given bin with a macro:");
bin = getNumber("Select a Bin number between 0 and 255", 34);
// How many pixels in the image have the intensity value 200?

showMessage("There are "+histogram[bin]+" pixels with value "+bin);

// You can fine-tune the histogram by using the function getHistogram(values, counts, nBins[, histMin, histMax])
// See https: https://imagej.net/developer/macro/functions.html#getHistogram
