# BrainMap
Automates generation of combined 2D/3D brain models with statistical heatmap overlays from MRI data.


# Overview

[MRIcroGL](https://www.nitrc.org/projects/mricrogl) is an excellent program for visualizing brain imaging data. However, creating numerous figures manually can be time-consuming and inconsistent. This automation tool streamlines the figure creation process, enhancing efficiency and ensuring uniformity in your work.


# Prerequisites

- [MRIcroGL](https://www.nitrc.org/projects/mricrogl) installed on your system.
- Basic understanding of MRIcroGL navigation and export functions.


# Efficient Workflow Steps

1. Export 2D multiplanar (A+C+S) bitmap as "multi.png" to Downloads (File > Save Bitmap).
2. Switch to 3D render (Display > Render).
3. Press Alt + S for the superior view and export to Downloads as "sup.png".
5. Press Alt + L for left hemisphere view and export to Downloads as "left.png".
6. Press Alt + R for right hemisphere view and export to Downloads as "right.png".
7. Run BrainMap; Your combined image will be saved to Downloads as "combined_img.png".


# Notes

Ensure all files are correctly named and placed in the Downloads folder for the automation script to process them accurately.
The combined image maintains consistency across figures, facilitating easier comparison and analysis.
