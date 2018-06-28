# Sparsity-promoting denoising of seismic data

##  DESCRIPTION

This package contains a MATLAB implementation of sparsity-promoting
denoising of seismic data in the curvelet domain using one-norm
minimization.


##  ON-LINE DOCUMENTATION

https://www.slim.eos.ubc.ca/SoftwareDemos/applications/Processing/SparsityPromotingDenoising


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

###  Software in SLIM-release-comp repository

Follow the instructions in the INSTALLATION file (located in the home
directory of this software repository) to install necessary
components.


##  DOCUMENTATION
 
Examples in .html format are included in the ./doc directory.


##  RUNNING

Start matlab from this directory or run startup.m to set the correct
paths. The scripts that produced the examples can be found in
./examples.

###  Preparing shell environment

You must setup your shell environment according to the steps listed in
the README located in home directory of the software release.

###  Downloading data

To run the examples, first download the data from
ftp://slim.eos.ubc.ca/data/SoftwareRelease/Processing/SparsityPromotingDenoising
by typing `scons' in the ./data directory

###  Running applications/demos

Specific instructions to run the examples can be found in the README.md
file in the ./examples directory.

####  Data adaptation

To run the denoising algorithm on your own data, see the instructions
in the README.md file in the ./examples directory.


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

[1] Felix J. Herrmann, Andrew J. Calvert, Ian Hanlon, Mostafa
Javanmehri, Rajiv Kumar, Tristan van Leeuwen, Xiang Li, Brendan
Smithyman, Eric Takam Takougang, and Haneet Wason. Frugal
full-waveform inversion: from theory to a practical algorithm, The
Leading Edge (2013), vol. 32, pp. 1082-1092. Available at
https://www.slim.eos.ubc.ca/content/frugal-full-waveform-inversion-theory-practical-algorithm.

[2] SLIM research webpage on processing: https://www.slim.eos.ubc.ca/research/processing.

