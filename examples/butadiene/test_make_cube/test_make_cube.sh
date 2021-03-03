
# Modify Slurm script below for your cluster environment

# FOLDERS
ROOT=/home/boittier/MDCM-1
EXAMPLE=butadiene
WORKDIR=$ROOT/examples/$EXAMPLE/make_test_cube
BINDIR=$ROOT/bin
FRAGDIR=$ROOT/examples/$EXAMPLE/5-combine-frags  # folder containing combined fragment xyz files
REFDIR=/data/boittier/gaussian_scans/$EXAMPLE

# INPUT
MTPFILE=$ROOT/examples/$EXAMPLE/2-mtp-fit/fitted-mtpl.dat
PCUBE=$REFDIR/scan_extract_0.xyz.chk.fchk.pot.cube # Generated in step 1
DCUBE=$REFDIR/scan_extract_0.xyz.chk.fchk.den.cube # Supplied by user (see step 1)
XYZ=$ROOT/examples/butadiene/6-refine-simplex/refined/13-charges/13_charges_refined.xyz


$BINDIR/pcubefit.x -generate -esp $PCUBE -dens $DCUBE -xyz $XYZ -prefix 13chgs

