% Generate a number of ISM grid files based on the same projection
% at different resolutions. Checks if integer subdivision for chosen base grid
% and resolution
% CISM AIS version
% Heiko Goelzer, June 2022 (heig@norceresearch.no)

clear all
close all

% for checking 
isaninteger = @(x) mod(x, 1) == 0;

%% Specify mapping information. This is EPSG 3031
proj_info.earthradius=6378137.0;
proj_info.eccentricity=0.081819190842621;
proj_info.standard_parallel=-71.;
proj_info.longitude_rot=0.;
% offset of grid node centers
proj_info.falseeasting=3040000;
proj_info.falsenorthing=3040000;

%% Specify output angle type (degrees or radians)
%output_data_type='radians';
output_data_type='degrees';

%% Specify various ISM grids at different resolution
%rk = [2 4 8 16 32 64]
rk = [16]
%rk = 2;
%rk = 32; 
%rk = 64; 
%rk = 608; % upper limit

% grid dimensions of 1 km base grid
nx_base=6080;
ny_base=6080;

% choose which output file to write
flag_nc = 1;
flag_txt = 0;
flag_xy = 1;

index=0;
for r=rk
% For any resolution but check integer grid numbers
    nx = (nx_base)/(r);
    ny = (ny_base)/(r);
    if(isaninteger(nx) & isaninteger(ny))
        index=index+1;
        grid(index).dx=r*1000.;
        grid(index).dy=r*1000.;
        grid(index).nx_centers=(nx_base)/(r);
        grid(index).ny_centers=(ny_base)/(r);
        grid(index).LatLonOutputFileName=['grid_CISM_AIS_' sprintf('%05d',r*1000) 'm.nc'];
        grid(index).CDOOutputFileName=['grid_CISM_AIS_' sprintf('%05d',r*1000) 'm.txt'];
        grid(index).xyOutputFileName=['xy_CISM_AIS_' sprintf('%05d',r*1000) 'm.nc'];
    else
        disp(['Warning: resolution ' num2str(r) ' km is not comensurable, skipped.'])
    end
end

% Create grids and write out
for g=1:length(grid)
    success = generate_CISM_CDO_files_nc(grid(g),proj_info,output_data_type,flag_nc,flag_txt,flag_xy);
end
