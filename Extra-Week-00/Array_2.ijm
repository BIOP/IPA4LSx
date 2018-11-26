run("Close All");
print("\\Clear");

run("Blobs (25K)");
run("Gaussian Blur...", "sigma=1");
getRawStatistics(nPixels, mean, min, max, std, histogram);
print("Max from Raw Statistics : "+ max);
// the varaible histogram is an array

// Thus to print it we use function Array.print()
print("=======================Histogram");
Array.print(histogram);

// It's also possible to look for maximas
print("=======================Maximas Indexes");
maximas = Array.findMaxima(histogram, 100) ;
Array.print(maximas);

print("=======================");
print("Mode is : "+ maximas[0]  );
print("Mode count is : "+ histogram[ maximas[0] ] );

// You will find more example on : 
// https://imagej.net/ij/developer/macro/functions.html
// and 
// https://imagej.net/ij/macros/examples/ArraySortingDemo.txt
