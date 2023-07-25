# Purpose, Description

This is the COSMO-CLM atmospheric-model component of the IOW earth-system model. 
The original source code is from the starter package v2.0 
(~~https://redc.clm-community.eu/projects/cclm-sp/files/cclm-sp_2.0.tgz~~, now https://www.clm-community.eu/wiki/wg-suptech/cosmo-clm/starter-package/files/cclm-sp_2.0.tgz)


**IMPORTANT:**
If you only see a `cclm.patch` instead of the actual source files, you have to get first the original release of CCLM from https://www.clm-community.eu/wiki/wg-suptech/cosmo-clm/starter-package/files/.
From here you have to download `cclm-sp_2.0.tgz`.
You can only login to that site if you are a member of the CLM community. So request for an account there if not done yet. 
After you have downloaded the archive `cclm-sp_2.0.tgz` put it into the directory of the CCLM code, i.e. 

``` bash
cp /path/to/downloads/cclm-sp_2.0.tgz /root/of/IOW_ESM/CCLM/
```

where you have to put your correpsonding paths.
Note that there is already a placeholder named `cclm-sp_2.0.tgz` that can be overwritten.
There is nothing more for you to do, the rest is managed by the build scripts.


If you want to view the full sources without building you can use the delivered `patch` tool as

``` bash
cd /root/of/IOW_ESM/CCLM/
../../patch/merge_patch.sh cclm-sp_2.0/src/cclm cclm.patch cclm
```

This will create the directory `cclm` with the full sources.

**IMPORTANT: You are not allowed to share the full sources with people that are not members of the CLM community! Thus, do not push the full sources to any public repository!**


# Authors

* SK      (sven.karsten@io-warnemuende.de)
* HR      (hagen.radtke@io-warnemuende.de)


# Versions

## 1.01.00 (latest release)

| date        | author(s)   | link      |
|---          |---          |---        |
| 2022-07-25  | SK          |  [1.01.00](https://git.io-warnemuende.de/iow_esm/components.cclm/src/branch/1.01.00)     | 

<details>

### changes
* added bias correction module
  * currently additive corrections of shortwave and longwave radiation fluxes are supported
  * correction is applied as anual cycle, i.e. for each month there should be a correction file (NetCDF) that contains
    a field that is added to the actual flux
  * these files must be placed in folder called `corrections` that is placed in the input folder of the CCLM model
  * the files must be named `ALWD_S-MM.nc` for the longwave correction and `ASWD_S-MM.nc` for the shortwave correction
  * the `MM` indicates the month and goes from `01` to `12`
* fixed bug with ssending of diffusive radiation
  * before only the net flux of diffusive shortwave radiation was sent
  * however, the MOM model subtracted additionally the reflected part
  * now the full downward flux of diffusive radiation is sent
* templates for build scripts have been added
* script for patching is added, using the Linux tools `diff` and `patch`
  * if the patch and the correct original source is given, the files are merged via the build script
  * the patch files are meant to be uploaded to a public server like github
  * that way the code can only be seen by selected people who have the right original sources
    

### dependencies
* OASIS3-MCT libraries
* see build scripts for more dependencies  
  
### known issues
* in coupled model this version leads to too cold summer SST 
  when evaluated from 1959-2019
  * tested bias correction can improve on that
* model is not running on phy-2

### tested with
* intensively tested on both HLRN machines
  * using example setups available under:
    (coupled) /scratch/usr/mviowmod/IOW_ESM/setups/
              MOM5_Baltic-CCLM_Eurocordex/example_3nm_0.22deg/1.00.00
         and  https://zenodo.org/record/8167743/files/1.00.00.tar.gz (https://doi.org/10.5281/zenodo.8167743)    
    (uncoupled) /scratch/usr/mviowmod/IOW_ESM/setups/
                CCLM_Eurocordex/example_0.22deg/1.00.00
* can be built and run on Haumea but output is not intensively tested
  
</details>

<details>
<summary><b><i>older versions</i></b></summary>

## 1.00.03

| date        | author(s)   | link      |
|---          |---          |---        |
| 2022-12-22  | SK          | [1.00.03](https://git.io-warnemuende.de/iow_esm/components.cclm/src/branch/1.00.03)     | 

<details>

### changes
* updated build.sh script
* mainly a release for a new version of main
    
### dependencies
* OASIS3-MCT libraries
* see build scripts for more dependencies  
  
### known issues
* in coupled model this version leads to too cold summer SST 
  when evaluated from 1979-2009
* model is not running on phy-2

### tested with
* intensively tested on both HLRN machines
  * using example setups available under:
    (coupled) /scratch/usr/mviowmod/IOW_ESM/setups/
              MOM5_Baltic-CCLM_Eurocordex/example_3nm_0.22deg/1.00.00
    (uncoupled) /scratch/usr/mviowmod/IOW_ESM/setups/
                CCLM_Eurocordex/example_0.22deg/1.00.00
* can be built and run on Haumea but output is not intensively tested
  
</details>

## 1.00.02

| date        | author(s)   | link      |
|---          |---          |---        |
| 2022-05-31  | SK          | [1.00.02](https://git.io-warnemuende.de/iow_esm/components.cclm/src/branch/1.00.02)     | 

<details>

### changes
* changed number of shells for Shepard interpolation.
  * was necessary for the coupling to the 3nm MOM5 setup
    
### dependencies
* OASIS3-MCT libraries
* see build scripts for more dependencies  
  
### known issues
* in coupled model this version leads to too cold summer SST 
  when evaluated from 1979-2009
* model is not running on phy-2

### tested with
* intensively tested on both HLRN machines
  * using example setups available under:
    (coupled) /scratch/usr/mviowmod/IOW_ESM/setups/
              MOM5_Baltic-CCLM_Eurocordex/example_8nm_0.22deg/1.00.00
    (uncoupled) /scratch/usr/mviowmod/IOW_ESM/setups/
                CCLM_Eurocordex/example_0.22deg/1.00.00
* can be built and run on Haumea but output is not intensively tested
  
</details>

## 1.00.01 

| date        | author(s)   | link      |
|---          |---          |---        |
| 2022-04-27  | SK          | [1.00.01](https://git.io-warnemuende.de/iow_esm/components.cclm/src/branch/1.00.01)       | 

<details>

### changes
* fixed flux injection
  * take in to account implicitness in calculation scheme of slow tendencies:
    also matrix coefficients have to be modified, see changes in 
    cclm/src/src_slow_tendencies_rk.f90    
* intensive cleaning of coupling interface
  * removed all currently unused parts of the code
    
### dependencies
* OASIS3-MCT libraries
* see build scripts for more dependencies  
  
### known issues
* in coupled model this version leads to too cold summer SST 
  when evaluated from 1979-2009
* model is not running on phy-2

### tested with
* intensively tested on both HLRN machines
  * using example setups available under:
    (coupled) /scratch/usr/mviowmod/IOW_ESM/setups/
              MOM5_Baltic-CCLM_Eurocordex/example_8nm_0.22deg/1.00.00
    (uncoupled) /scratch/usr/mviowmod/IOW_ESM/setups/
                CCLM_Eurocordex/example_0.22deg/1.00.00
* can be built and run on Haumea but output is not intensively tested
  
</details>


## 1.00.00 

| date        | author(s)   | link      |
|---          |---          |---        |
| 2022-01-28  | SK, HR      | [1.00.00](https://git.io-warnemuende.de/iow_esm/components.cclm/src/branch/1.00.00)  |  

<details> 

### changes
* initial release
* main codes is based on starter package v2.0: 
  https://redc.clm-community.eu/projects/cclm-sp/files/cclm-sp_2.0.tgz
* coupling interface is based on work of H. Hagemann (hereon) and has been modified
  by IOW colleagues  
* adapted Fopts and added build scripts for 
  * both HLRN supercomputers
  * Rostock University's cluster Haumea
  * for IOW phy-2 machine (model is not running here)
* added OASIS interface to flux calculator
  * read in SST, fraction of ice and black body radiation
  * SST is stored in variable t_s
  * fraction of ice in fr_ice
  * black body radiation is stored in t_g_rad which is used in radiation routine 
    for thermal surface flux
  * send variables to calculate fluxes for evaporation, latent and sensible heat,
    momentum 
  * send radiation and precipitation
  * receive calculated fluxes in diagnostic variables shfl_s, lhfl_s, qvflx, 
    umfl_s, vmfl_s
    * these diagnostic variables were not directly used by CCLM
    * thus, fluxes are "injected" in solver for slow tendencies 
     (only Runge-Kutta version)
* executable can run in coupled model or as stand alone
  * use parameter ytype_oce in INPUT_OASIS for control, see also documentation in
      iow_esm/main project

### dependencies
* OASIS3-MCT libraries
* see build scripts for more dependencies  

### known issues
* in coupled model this version leads to too cold winter temperatures 
  when evaluated from 1979-2009
* model is not running on phy-2

### tested with
* intensively tested on both HLRN machines
  * using example setups available under:
    (coupled) /scratch/usr/mviowmod/IOW_ESM/setups/
              MOM5_Baltic-CCLM_Eurocordex/example_8nm_0.22deg/1.00.00
    (uncoupled) /scratch/usr/mviowmod/IOW_ESM/setups/
                CCLM_Eurocordex/example_0.22deg/1.00.00
   * results exhibit known issues
  * can be built and run on Haumea but output is not intensively tested

</details>
</details>
