# MDCM
Machine learning code to fit Minimal Distributed Charge Models (MDCMs)

## Authors:
Oliver Unke (original author) and Mike Devereux (Michael.Devereux@unibas.ch)

## References:
*Unke, O. T.; Devereux, M.; Meuwly, M. Minimal distributed charges:  Multipolar qual-ity at the cost of point charge electrostatics.J. Chem. Phys.2017,147, 161712*

## Code Overview:
Two utilities are provided:
1. The python utility "mtpfit.py" fits high-ranking (*l*=5) atomic multipoles to the molecular electrostatic potential (MEP) across a grid provided in Gaussian cube file format. It also requires a second Gaussian cube file containing the electron density at each corresponding point, in order to define the exclusion zone inside the molecule where points are discarded and outside a minimum density cut-off where the MEP is typically small.
1. The Fortran source compiles machine-learning code to fit distributed charges in a series of stages. Each stage is run separately in a different "mode", so the code must be called multiple times. Briefly, the first step fits atomic charge models with different numbers of charges to the electrostatic potential generated by the atomic multipoles from mtpfit.py. The second step then combines the atomic charge models to fit fragment models. The third and final step refines the molecular model built from individual fragment models.
1. The shell script 5-combine.sh is a helper script to try all permutations of fitted fragment models that yield a desired number of charges for the total molecule, and to use the quality of those models to estimate the best molecular model that can be created from the fragment models available with the total number of charges requested

## Compilation:
* Only the MDCM Fortran code requires compilation, type "make" in the folder that contains the Makefile and two binaries (cubefit.x and pcubefit.x) are created. pcubefit.x is parallelized code that uses OpenMP, cubefit.x is serial code.
* Note that due to the nature of DE, the speedup using the parallelized code can be small and it is better to run more fits simultaneously than a single fit with more cores wherever possible

## Running:
### mtpfit.py
`mtpfit.py -pot $PCUBE -dens $DCUBE -lmax 5 -qtot 0.0`

Options:
* -pot:   MEP cube file
* -dens:  electron density cube file
* -lmax:  maximum rank for atomic multipoles (ditriantapole)
* -qtot:  total molecular charge

### (p)cubefit.x
**Atomic charge fitting:**
`pcubefit.x -greedy $FITTED-MTPL -esp $PCUBE -dens $DCUBE -nacmin $MINCHG -nacmax $MAXCHG -atom $ATOMINDEX -ntry $NTRY -onlymultipoles -v > $OUTFILE`

Options:
* -greedy:  use "greedy" fitting algorithm in differential evolution fitting (recommended), and define $MTPFILE containing fitted atomic multipoles
* -esp: define Gaussian cube file "$PCUBE" containing the molecular electrostatic potential
* -dens: define Gaussian cube file "$DCUBE" containing the molecular electron density
* -nacmin: define lowest number of charges to fit per atom (usually 1)
* -nacmax: define highest number of charges to fit per atom (usually 3-4)
* -atom: define index of atom to be fitted (corresponds to ordering in cube files). Fitting atoms separately allows efficient parallelization of the fitting process.
* -ntry: set number of complete fitting runs. As the fitting code involves making random "mutations" to existing populations of candidate solutions, better results may be obtained by repeating the fitting process a few times and selecting the best result
* -onlymultipoles: state that we want to fit multipole moments only in this step and not atomic charges
* -v: verbose output

**Fragment charge fitting:**
`pcubefit.x -greedy $MTPFILE -esp $PCUBE -dens $DCUBE -ncmin $MINCHG -ncmax $MAXCHG -atom $ATOMLIST -nacmax $MAXCHG -ntry $NTRY -v > $OUTFILE`

Options:
* -greedy:  use "greedy" fitting algorithm in differential evolution fitting (recommended), and define $MTPFILE containing fitted atomic multipoles
* -esp: define Gaussian cube file "$PCUBE" containing the molecular electrostatic potential
* -dens: define Gaussian cube file "$DCUBE" containing the molecular electron density
* -nacmax: the highest number of charges per atom used during atom fitting in the previous step
* -ncmin: define lowest number of charges to fit for this fragment
* -ncmax: define highest number of charges to fit for this fragment
* -atom: define a comma-separated list of atom indices to be fitted without spaces (indices correspond to atom ordering in cube files). Fitting fragments allows efficient fitting of models with too many charges to fit efficiently all at once
* -ntry: set number of complete fitting runs. As the fitting code involves making random "mutations" to existing populations of candidate solutions, better results may be obtained by repeating the fitting process a few times and selecting the best result
* -v: verbose output

**Combine fragment models to build molecular models**
`5-combine.sh`
Options are set inside the script by defining the shell variables:
* WORKDIR: the root folder of the working directory
* BINDIR: the folder containing the (p)cubefit.x binaries
* FRAGDIR: the folder containing the fitted fragment models
* NFRAG: the number of non-overlapping fragments that were fitted for the molecule
* NFIT: the number of fits that were performed for each fragment
* MINCHGS: the lowest number of charges for the molecular charge model
* MAXCHGS: the maximum number of charges for the molecular charge model

**Molecular MDCM refinement**
`pcubefit.x -xyz $INITIALXYZ $MTPFILE -esp $PCUBE -dens $DCUBE -nacmax $MAXATMCHG -ntry $NTRY -v > $OUTFILE`

Options:
* -xyz: defines the file containing the molecular charge model to be refined (usually the charge model created by combining fitted fragment models), and the file containing the fitted atomic multipoles
* -esp: define Gaussian cube file "$PCUBE" containing the molecular electrostatic potential
* -dens: define Gaussian cube file "$DCUBE" containing the molecular electron density
* -nacmax: the highest number of charges per atom used during atom fitting in the atomic charge fitting step
* -ntry: set number of complete fitting runs. As the fitting code involves making random "mutations" to existing populations of candidate solutions, better results may be obtained by repeating the fitting process a few times and selecting the best result
* -v: verbose output
