#!/bin/bash

# Here we fit new atomic multipoles to the reference MEP in the PCUBE cube file
# Note this step is probably unnecessary when fitting to a multipolar MEP, but
# it's still useful to demonstrate how to fit to the DFT MEP instead

# In the second step we generate a Gaussian-format MEP cube file using our newly
# fitted multipoles

# In the final step we compare the MEP in the new cube file to the reference MEP
# from our original cube file at different distances from the nuclei

# FOLDERS
ROOT=/home/boittier/MDCM-1/
WORKDIR=$ROOT/examples/water/2-mtp-fit
BINDIR=$ROOT/bin
REFDIR=$ROOT/ref
# INPUT
PCUBE=/data/boittier/energies/h2o_geom.xyz.dir/h2o_1.chk.fchk.potential.cube # Generated in step 1
DCUBE=/data/boittier/energies/h2o_geom.xyz.dir/h2o_1.chk.fchk.density.cube # Supplied by user (see step 1)
# OUTPUT
MTPFILE=$WORKDIR/fitted-mtpl.dat

cd $WORKDIR

# Fit new multipoles to reference MEP from $PCUBE (can be ab initio or multipolar MEP)
$BINDIR/mtpfit.py -pot $PCUBE -dens $DCUBE -lmax 5 -qtot 0.0

# Generate cube file from the newly fitted multipoles
$BINDIR/pcubefit.x -v -generate -multipole -esp $PCUBE -dens $DCUBE -xyz $MTPFILE > generate-cube-l5.log

# Examine quality of fitted multipoles by comparing newly fitted multipolar and reference
# MEP
$BINDIR/pcubefit.x -v -analysis -esp $PCUBE -esp2 $WORKDIR/ditriantapole_expansion.cube -dens $DCUBE > analyze-cube-l5.log

