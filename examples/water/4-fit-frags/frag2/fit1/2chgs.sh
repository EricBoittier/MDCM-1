#!/bin/bash

#SBATCH --job-name=frag2fit1q2
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --partition=long

WORKDIR=/home/boittier/MDCM-1/examples/water/4-fit-frags
BINDIR=/home/boittier/MDCM-1/bin
REFDIR=/home/boittier/MDCM-1/ref
MTPFILE=/home/boittier/MDCM-1/examples/water/2-mtp-fit/fitted-mtpl.dat
PCUBE=/data/boittier/energies/h2o_geom.xyz.dir/h2o_1.chk.fchk.potential.cube
DCUBE=/data/boittier/energies/h2o_geom.xyz.dir/h2o_1.chk.fchk.density.cube
NTRY=3
ATOMLIST="1,3"
MINCHG=2
MAXCHG=2
NAME=2chgs

cd /home/boittier/MDCM-1/examples/water/4-fit-frags/frag2/fit1

$BINDIR/pcubefit.x -greedy $MTPFILE -esp $PCUBE -dens $DCUBE -ncmin $MINCHG -ncmax $MAXCHG -atom $ATOMLIST -nacmax 4 -ntry $NTRY -v > $NAME.out

