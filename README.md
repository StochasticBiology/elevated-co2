# elevated-co2

Data analysis and modelling of root behaviour under elevated CO2

The complete pipeline is run by executing `run.sh`. Raw data is in `Data/`. Output from Caladis is in `Caladis/`.

There are 5 parts of the analysis, which run.sh serially executes. The corresponding manuscript figures are given in square brackets.

**1. Rhizotron data**

* `process-s1.sh` -- pulls raw rhizotron data into different files for analysis
* `rhizo-analysis.R` -- time series of rhizotron observations [2, 4]
* `bid-analysis-wrapper.R` [wrapping `bid-lik.R`] -- birth-immigration-death model fitting of rhizotron data [2, S2]

**2. Soil coring data**

* `process-s2.sh` -- pulls raw soil coring data into different files for analysis
* `core-weights-analysis.R` -- analyses coring data (live/dead biomass, bulk and by horizon) [3]

**3. Root physiology**

* `process-roots.sh` -- pulls raw root physiology data into different files for analysis
* `roots.R` -- analyses and plots root physiology data (lengths and widths, bulk and by horizon) [4, S3]

**4. Belowground productivity**

* `process-s3.sh` -- pulls raw belowground productivity data into different files for analysis
* `production.R` -- analyses and plots belowground productivity data [5]

**5. Caladis NPP estimates**

* `process-caladis.sh` -- pulls Caladis output into different files for analysis
* `caladis.R` -- plots Caladis output [5]

The specific output files that make up each final figure are

* Fig 1 -- (illustration)
* Fig 2 -- `output-data1.pdf` and `bid-analysis-y1.svg`
* Fig 3 -- `output-weights2.pdf` and `output-weights1.pdf` 
* Fig 4 -- `root-widths.pdf` and `roots-width-all.pdf` and `roots-width-horizon.pdf`
* Fig 5 -- `production-ts.pdf` and `production-years.pdf` and `caladis-plots.svg`
* Fig S1 -- (illustration)
* Fig S2 -- `bid-analysis-y2.svg`
* Fig S3 -- `roots-length-all.pdf` and `roots-length-horizon.pdf`
* Fig S4 -- (illustration)
* Fig S5 -- (illustration)