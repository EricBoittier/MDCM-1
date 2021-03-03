#!/bin/bash

# Here we fit atomic MDCM models to the atomic multipoles from the previous step
# To improve quality we should run more fits to choose the best, and also
# increase the number of DE tries for each fit. Here we show a minimal example
# for simplicity with a single fit and only 4 refinement attempts (NTRY) per fit

# Note: adapt the Slurm script below to whatever cluster you're using...

# FOLDERS
ROOT=/home/boittier/MDCM-1
BINDIR=$ROOT/bin
REFDIR=$ROOT/ref
EXAMPLE=butadiene
WORKDIR=$ROOT/examples/$EXAMPLE/3-fit-atoms
BINDIR=$ROOT/bin
REFDIR=/data/boittier/gaussian_scans/$EXAMPLE

# INPUT
PCUBE=$REFDIR/scan_extract_0.xyz.chk.fchk.pot.cube # Generated in step 1
DCUBE=$REFDIR/scan_extract_0.xyz.chk.fchk.den.cube # Supplied by user (see step 1)
MTPDIR=$ROOT/examples/$EXAMPLE/2-mtp-fit
MTPFILE=$MTPDIR/fitted-mtpl.dat # from step 2

# FITTING PARAMETERS
NFIT=1     # number of separate fits to perform for each atom (more is better but needs more cores)
NTRY=4      # number of tries for each fit (more is better but slower)
NATOM=10    # total atoms in molecule to fit (usually number of atoms in molecule)
MAXCHG=4      # max charges per atom to fit (4 is usually enough for l=2 quality)

cd $WORKDIR

for ((j=1; j<=$NFIT; j++)); do
  cd $WORKDIR
  mkdir fit$j && cd fit$j

  for ((i=1; i<=$NATOM; i++)); do

    # Adapt this submission script for your cluster environment
    SCRIPT="atom"$i".sh"
    echo "#!/bin/bash

#SBATCH --job-name=atom$i
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --partition=short

WORKDIR=$WORKDIR
BINDIR=$BINDIR
REFDIR=$REFDIR
MTPFILE=$MTPFILE
PCUBE=$PCUBE
DCUBE=$DCUBE
NTRY=$NTRY
ATOMINDEX=$i
MAXCHG=$MAXCHG

cd \$WORKDIR/fit$j

\$BINDIR/pcubefit.x -greedy \$MTPFILE -esp \$PCUBE -dens \$DCUBE -nacmin 1 -nacmax \$MAXCHG -atom \$ATOMINDEX -ntry \$NTRY -onlymultipoles -v > atom$i-fit.out
" > $SCRIPT

    sbatch $SCRIPT
  done
done

