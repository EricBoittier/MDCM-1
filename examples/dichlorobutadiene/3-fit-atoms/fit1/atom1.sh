#!/bin/bash

#SBATCH --job-name=atom1
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --partition=short

WORKDIR=/home/boittier/MDCM-1/examples/water/3-fit-atoms
BINDIR=/home/boittier/MDCM-1/bin
REFDIR=/home/boittier/MDCM-1/ref
MTPFILE=/home/boittier/MDCM-1/examples/water/2-mtp-fit/fitted-mtpl.dat
PCUBE=/data/boittier/energies/h2o_geom.xyz.dir/h2o_1.chk.fchk.potential.cube
DCUBE=/data/boittier/energies/h2o_geom.xyz.dir/h2o_1.chk.fchk.density.cube
NTRY=4
ATOMINDEX=1
MAXCHG=3

cd $WORKDIR/fit1

$BINDIR/pcubefit.x -greedy $MTPFILE -esp $PCUBE -dens $DCUBE -nacmin 1 -nacmax $MAXCHG -atom $ATOMINDEX -ntry $NTRY -onlymultipoles -v > atom1-fit.out

