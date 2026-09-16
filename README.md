# sgfunctions: Process and Clean Raw Sensorgnome Data
**Version:** 0.0.2.0000
**Author:** Alex Smilor
**Email:** awsmilor@illinois.edu

## Description
This package was developed to allow for quick processing of raw Sensorgnome data, with the intention that it can be used to diagnose deployment issues in a timely manner and provide the ability to preliminarily check for detections of known tags or beacon transmitters. This package is not meant to replace the data produced my Motus, but can offer an alternative method if processing times are slow.

## Recent Updates
The 0.0.2.0000 version of this package fixes a number of bugs with the read_sg and read_sg_gps functions and updates the deployment timeline workflow to ensure a deployment timeline can be created even if GPS fixes were not recorded by the sensorgnome.
The 0.0.1.0000 version of this package now allows for the processing of Sensorgnome data from receivers with 434 antennas and the ability to create a deployment timeline for diagnostic purposes. Future updates will further streamline the ability to process data from CTT tags.
