# Membrane-vs-Cytoplasm-Intensity-Over-Time-Measurement
Divya Tiraki

This macro was written in November 2024 to help Divya Tiraki measure the intensity of the cytoplasm signal (excluding the membrane) over time.

In order to work correctly, input data must be a single timelapse image with only one channel.  The macro will prompt users to edit their input if this is not the case.

Next, the macro prompts to find the background value of the image.  Place a single point in a background area (lacking cells) and push okay.  The macro will calculate the average intensity of this background area and subtract this from future measurements.

Then, the macro will prompt the user to choose a cell by placing a point in the center of the cell of interest.  Once placed, the intensity measurement within a circle of radius 8 pixels minus the background value will be calculated over time.  This intensity will then be normalized to the intensity at time = 0, and thus reported as the fold change from the initial value at each timepoint.  The results will be reported in a table and copied to the clipboard.  **In order to save the data, paste into the spreadsheet application of your choice.**

The user will then be given the option to measure another cell.

**Important: If you want to compare results between cells in an image, do not restart the macro; if you do, a different background value will be calculated that might differ slightly.  If you instead select yes and measure more cells, the same background value will be used, making your results comparable.**

**Recommended: It is recommended to report fold change values as log fold change, so that plotted distance for equivalent negative and positive differences have the same magnitude.**
