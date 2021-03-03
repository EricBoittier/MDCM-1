#!/bin/bash




ROOT=/home/boittier/MDCM-1
WORKDIR=$ROOT/examples/water/7-make-mdcd
BINDIR=$ROOT/bin
REFDIR=$ROOT/ref
# INPUT
PCUBE=/data/boittier/energies/h2o_geom.xyz.dir/h2o_1.chk.fchk.potential.cube # Generated in step 1
DCUBE=/data/boittier/energies/h2o_geom.xyz.dir/h2o_1.chk.fchk.density.cube # Supplied by user (see step 1)
# OUTPUT
MTPFILE=$WORKDIR/fitted-mtpl.dat


FITTED_CHARGE=$ROOT/examples/water/6-refine-simplex/refined/6-charges/6_charges_refined.xyz
OUTPUT_MDCM=water.dcm
FRAMES=frames.txt


$BINDIR/comb-xyz-to-dcm.pl $FITTED_CHARGE $DCUBE $FRAMES $OUTPUT_MDCM



