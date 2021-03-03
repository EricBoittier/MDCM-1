#!/bin/bash

#SBATCH --job-name=refine-7chg
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --partition=long

cd /home/boittier/MDCM-1/examples/water/6-refine-simplex/refined/7-charges

/home/boittier/MDCM-1/bin/pcubefit.x -xyz /home/boittier/MDCM-1/examples/water/4-fit-frags/frag1/fit1/7charges.xyz /home/boittier/MDCM-1/examples/water/2-mtp-fit/fitted-mtpl.dat -simplex -esp /data/boittier/energies/h2o_geom.xyz.dir/h2o_1.chk.fchk.potential.cube -dens /data/boittier/energies/h2o_geom.xyz.dir/h2o_1.chk.fchk.density.cube -nacmax 3 -ntry 1 -v > 7-charges.out

