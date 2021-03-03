#!/bin/bash

#SBATCH --job-name=frag1fit1q19
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --partition=long

WORKDIR=/home/boittier/MDCM-1/examples/bromobutadiene/4-fit-frags
BINDIR=/home/boittier/MDCM-1/bin
REFDIR=/data/boittier/gaussian_scans/bromobutadiene
MTPFILE=/home/boittier/MDCM-1/examples/bromobutadiene/2-mtp-fit/fitted-mtpl.dat
PCUBE=/data/boittier/gaussian_scans/bromobutadiene/scan_extract_0.xyz.chk.fchk.pot.cube
DCUBE=/data/boittier/gaussian_scans/bromobutadiene/scan_extract_0.xyz.chk.fchk.den.cube
NTRY=3
ATOMLIST="1,2,3,4,5,6,7,8,9,10"
MINCHG=19
MAXCHG=19
NAME=19chgs

cd /home/boittier/MDCM-1/examples/bromobutadiene/4-fit-frags/frag1/fit1

$BINDIR/pcubefit.x -greedy $MTPFILE -esp $PCUBE -dens $DCUBE -ncmin $MINCHG -ncmax $MAXCHG -atom $ATOMLIST -nacmax 4 -ntry $NTRY -v > $NAME.out

