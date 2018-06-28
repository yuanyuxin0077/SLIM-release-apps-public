# Full-Waveform inversion for time-lapse seismic data

##  DESCRIPTION
 This package is an application for full-waveform inversion of time-lapse seismic data sets using a modified Gauss-Newton inversion framework. Ideas from distributed compressive sensing and stochastic optimization are exploited to create improved time-lapse models and speed-up the inversion, respectively.
 
##  ON-LINE DOCUMENTATION

<https://www.slim.eos.ubc.ca/SoftwareDemos/applications/WaveformInversion/TimeLapseFWI/>
 
##  COPYRIGHT
 You may use this code only under the conditions and terms of the
 license contained in the files LICENSE or COPYING provided with this
 source code. If you do not agree to these terms you may not use this
 software.
 
##  PREREQUISITES
 All prerequisites, except for MATLAB, are provided in the software
 release repositories and should be installed as necessary before using
 any of SINBAD's software.
 
##  INSTALLATION

###  Software in SLIM-release-apps (this) repository
 Follow the instructions in the INSTALLATION file (located in the home
 directory of this software repository) to install necessary
 comp[onents.
specific application. If none, then delete this
 sub-section.
 
##  DOCUMENTATION
An example in .html format is included in the ./doc directory.
Alternatively, you can regenerate the example by running the script
'reproduce_docs' in the ./doc directory.
 
##  RUNNING

Start matlab from this directory or run startup.m to set the correct
paths. The scripts that produced the results can be found in ./scripts
directory.

 
###  Preparing shell environment
 You must setup your shell environment according to the steps listed in
 the README located in home directory of the software release.
 
###  Downloading data

To run the examples, first download the data from 

ftp://slim.eos.ubc.ca/data/SoftwareRelease/WaveformInversion/TimeLapseFWI/data,
by typing `scons' in the ./data directory.



###  Running applications/demos
To run/visualize the results, first download the results from 

ftp://slim.eos.ubc.ca/data/SoftwareRelease/WaveformInversion/TimeLapseFWI/results,
by typing `scons' in the ./results/directory.

####  Hardware requirements

To run the example, a minimum of 2 Nodes, and 8 CPU cores is required.
Expected runtime is about 48 hours.

 
####  Data adaptation

The setup of the example script allows you to test your example.
The model and data information need to be provided.
 
 
##  SUPPORT
 You may contact developers of SINBAD software by means of:
 
###  Mailing list
 Subscribe to SINBAD software mailing list at
 http://slim.eos.ubc.ca/mailman/listinfo/slimsoft and e-mail your
 question to the mailing list.
 
###  Direct mail
 Contact SLIM administrator at softadmin@slimweb.eos.ubc.ca with any
 questions related to the SINBAD software release.
 
 
##  REFERENCES
[1] Felix Oghenekohwo, Ernie Esser, and Felix J. Herrmann. Time-lapse
seismic without repetition: reaping the benefits from randomized
sampling and joint recovery. Presented at the 76th EAGE Conference and
Exhibition 2014. Available at
https://www.slim.eos.ubc.ca/content/time-lapse-seismic-without-repetition-reaping-benefits-randomized-sampling-and-joint-recover.

[2] Felix J. Herrmann, Xiang Li, Aleksandr Y. Aravkin, and Tristan van Leeuwen, A modified, sparsity promoting, Gauss-Newton algorithm for seismic waveform inversion, in Proc. SPIE, 2011, vol. 2011.
https://www.slim.eos.ubc.ca/content/modified-sparsity-promoting-gauss-newton-algorithm-seismic-waveform-inversion

[3] Xiang Li, Aleksandr Y. Aravkin, Tristan van Leeuwen, and Felix J. Herrmann, Fast randomized full-waveform inversion with compressive sensing. 2011. Geophysics.
https://www.slim.eos.ubc.ca/content/fast-randomized-full-waveform-inversion-compressive-sensing


