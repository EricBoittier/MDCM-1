#!/bin/bash

#SBATCH --job-name=atom3
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --partition=short

WORKDIR=/home/boittier/MDCM-1/examples/butadiene_sparse2/3-fit-atoms
BINDIR=/home/boittier/MDCM-1/bin
REFDIR=/data/boittier/gaussian_scans/butadiene
MTPFILE=/home/boittier/MDCM-1/examples/butadiene_sparse2/2-mtp-fit/fitted-mtpl.dat
PCUBE=/data/boittier/gaussian_scans/butadiene/scan_extract_0.2.pot.cube
DCUBE=/data/boittier/gaussian_scans/butadiene/scan_extract_0.2.den.cube
NTRY=4
ATOMINDEX=3
MAXCHG=4

cd $WORKDIR/fit1

$BINDIR/pcubefit.x -greedy $MTPFILE -esp $PCUBE -dens $DCUBE -nacmin 1 -nacmax $MAXCHG -atom $ATOMINDEX -ntry $NTRY -onlymultipoles -v > atom3-fit.out

