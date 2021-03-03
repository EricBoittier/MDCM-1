#!/bin/bash

#SBATCH --job-name=atom10
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --partition=short

WORKDIR=/home/boittier/MDCM-1/examples/bromobutadiene/3-fit-atoms
BINDIR=/home/boittier/MDCM-1/bin
REFDIR=/data/boittier/gaussian_scans/bromobutadiene
MTPFILE=/home/boittier/MDCM-1/examples/water/2-mtp-fit/fitted-mtpl.dat
PCUBE=/data/boittier/gaussian_scans/bromobutadiene/scan_extract_0.xyz.chk.fchk.pot.cube
DCUBE=/data/boittier/gaussian_scans/bromobutadiene/scan_extract_0.xyz.chk.fchk.den.cube
NTRY=4
ATOMINDEX=10
MAXCHG=4

cd $WORKDIR/fit1

$BINDIR/pcubefit.x -greedy $MTPFILE -esp $PCUBE -dens $DCUBE -nacmin 1 -nacmax $MAXCHG -atom $ATOMINDEX -ntry $NTRY -onlymultipoles -v > atom10-fit.out

