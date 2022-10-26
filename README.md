# generate-grid-files

Generate netcdf grid files for cdo regridding

Using cdo (https://code.mpimet.mpg.de/projects/cdo) for interpolation requires grid description files (GDFs) to specify the coordinates of source and target grids. For the special case of conservative interpolation, coordinate bounds are additionally required.

## Create ISMIP6 AIS grid description files
The current parameter settings are for the standard ISMIP6 Antarctic grid on EPSG:3031

ISMIP6_AIS_multigrid_generater_nc.m


## Calculate area scale factor to correct projection error
Area scale factors for the ISMIP6 grid 

calcphilambda_epsg3031.m


## Utilities:
- generate_CDO_files_nc.m
- polarstereo_inv.m
- wnc.m


The netcdf files can be compressed to reduce the file size; in some cases more than a factor 2 
meta_compress.sh

## Example for conservative interpolation with cdo
cdo remapycon,grid_ISMIP6_AIS_20000m.nc -setgrid,grid_ISMIP6_AIS_32000m.nc test/bmba_32km.nc test/bmba_20km.nc

The target grid (20 km) is given first, source grid (here 32 km) is set with the setgrid command. 

## Scripts for specific models
CISM_AIS_multigrid_generator_nc.m
CISM_g0_AIS_multigrid_generator_nc.m
MAR_AIS_multigrid_generator_nc.m

generate_CISM_CDO_files_nc.m
generate_CISM_g0_CDO_files_nc.m
