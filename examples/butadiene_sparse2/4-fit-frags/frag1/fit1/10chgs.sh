#!/bin/bash

#SBATCH --job-name=frag1fit1q10
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --partition=long

WORKDIR=/home/boittier/MDCM-1/examples/butadiene/4-fit-frags
BINDIR=/home/boittier/MDCM-1/bin
REFDIR=/data/boittier/gaussian_scans/butadiene
MTPFILE=/home/boittier/MDCM-1/examples/butadiene/2-mtp-fit/fitted-mtpl.dat
PCUBE=/data/boittier/gaussian_scans/butadiene/scan_extract_0.xyz.chk.fchk.pot.cube
DCUBE=/data/boittier/gaussian_scans/butadiene/scan_extract_0.xyz.chk.fchk.den.cube
NTRY=3
ATOMLIST="1,2,5,6,7"
MINCHG=10
MAXCHG=10
NAME=10chgs

cd /home/boittier/MDCM-1/examples/butadiene/4-fit-frags/frag1/fit1

$BINDIR/pcubefit.x -greedy $MTPFILE -esp $PCUBE -dens $DCUBE -ncmin $MINCHG -ncmax $MAXCHG -atom $ATOMLIST -nacmax 4 -ntry $NTRY -v > $NAME.out

