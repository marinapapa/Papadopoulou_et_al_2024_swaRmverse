## Accompanying material for _"swaRmverse: an R package for the comparative analysis of collective motion"_


**Authors:** Papadopoulou Marina, Garnier Simon, King Andrew J.

---
The repository includes the code to reproduce the analysis and figures of the manuscript presenting the [**swaRmverse**](https://github.com/marinapapa/swaRmverse) R package (available on [CRAN](https://cran.r-project.org/web/packages/swaRmverse/index.html)).

### Code

All analysis and plotting is performed in R.

1. _sensitivity\_analysis.R_: performs a sensitivity analysis on the thresholds for the definition of an event of collective motion on goat herds. 

2. _fig2.R_: reproduces Figure 2, based on the data expoerted from (1).

3. _goats\_vs_\_sheep.R_: analysis of trajectories of goats and sheep using the swaRmverse pacakge, as presented in the case-study. From raw data to 'swarm\_space' comparison. 

4. _fig3.R_: reproduces Figure 3, based on the data exported from (3).

5. _biohybrid\_swarm\_space.R_: analyses simulated trajectories of pigeon-like flocks and adds them to pre-calculated metrics of collective motion from 4 empirical systems. 

6. _fig4.R_: reproduces Figure 4, based on the data exported from (1), (3) and (5).

### Data

1. _loc\_data.RData_: the raw data of goat herds from: https://github.com/swarm-lab/goatCollectiveDecision/tree/master

2. _simulated\_raw_*: the simulated data of pigeon-like agents in the [HoPE](https://github.com/marinapapa/HoPE-model) model, from: https://github.com/marinapapa/SelfOrg-ColEsc-Pigeons. The simulated_raw.zip file should be downloaded from Zenodo: https://doi.org/10.5281/zenodo.4993109, and exported in the *data* folder. The *no_avoid* folder is being used by the _biohybrid\_swarm\_space.R_ script. 

3. _sens\_analysis\_goats.csv_: the file with the events' summary across thresholds for polarization and speed, exported from _sensitivity\_analysis.R_

4. goats\_vs\_sheep\_metrics.csv: the file with the events of collective motion of sheep and goats, exported by the _goats\_vs\_sheep.R_.

5. _all\_species\_and\_model\_metrics.csv_: the file exported by _biohybrid\_swarm\_space.R_, with metrics of collective motion across real and simulated groups.

The trajectories of goats and sheep used in our case-study (in _goats\_vs\_sheep.R_) are unpublished and kindly provided by Lisa O'Bryan (https://obryan.rice.edu/) to showcase the functionality of the package. For inquiries about the raw data please contact the authors and Dr. O'Bryan. 

### Citation:

_Papadopoulou M.*, Garnier S., King A.J. (2024) swaRmverse: an R package for the comparative analysis of collective motion. Methods in Ecology and Evolution._

#### Contact:

*Marina Papadopoulou: m.papadopoulou.rug@gmail.com

