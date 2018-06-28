#Seismic trace interpolation using weighted L1 minimization.
##DESCRIPTION
This package contains three matlab scripts that reproduce the results of interpolating a seismic line from randomly subsampled traces by applying weighted L1 minimization in three different domains: 

1. Utilizing the correlation across frequency slices in the source-receiver domain.
2. Utilizing the correlation across frequency slices in the midpoint-offset domain.
3. Utilizing the correlation across offset slices in the time-midpoint domain.
    An overview of the results can be found in the ./doc directory.
    
##ON-LINE DOCUMENTATION
<https://www.slim.eos.ubc.ca/SoftwareDemos/applications/Processing/WeightedL1Interpolation/>
##COPYRIGHT
You may use this code only under the conditions and terms of the
    license contained in the file LICENSE or COPYING.txt provided with
    this source code. If you do not agree to these terms you may not
    use this software.
##PREREQUISITES
All prerequisites, except for MATLAB, are provided with the
    software release and should be installed before using any of
    SINBAD's software.
##INSTALLATION
Follow the instructions in the INSTALLATION file (located in the
    root directory of this software release) to install all 3-rd party
    software (except for MATLAB) and SINBAD's software.
##DOCUMENTATION
Documentation and examples in .html format are included in the ./doc subdirectory.
    Help can also be accessed from Matlab via the `help' command.
##RUNNING
1. Start matlab from this directory or run startup.m to set the correct paths.
2. Go into the data directory and run 'scons' to get the necessary files to
      run the scripts.
3. The scripts that produced the examples shown in the documentation can be found in ./exps.

##NOTES

##SUPPORT
You may contact developers of SINBAD software by means of:

1. Mailing list
      Subscribe to SINBAD software mailing list at
      <http://slim.eos.ubc.ca/mailman/listinfo/slimsoft> and e-mail your
      question to the mailing list.
2. Direct mail
      Contact SLIM administrator at <softadmin@slimweb.eos.ubc.ca> with any
      questions related to the SINBAD software release.

##REFERENCES
  [1] H. Mansour, F. Herrmann, O. Yilmaz. Improved wavefield reconstruction from randomized sampling via weighted one-norm minimization. submitted to Geophysics (2012)
