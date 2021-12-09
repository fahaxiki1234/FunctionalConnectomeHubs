function RUN_MetaAnalysis( InputPath, OutputPath )

load( 'YOURPATH/SiteList.mat' );

SiteNumber = size( SiteList, 1 );

load( 'YOURPATH/BrainMask/rAAL2_WithoutCER_Mask.mat' );
load( 'YOURPATH/BrainMask/rAAL2_WithoutCER_Mask_Header.mat' );
VoxelNumber = sum( MaskIndex > 0.5 );
Header.dt( 1 ) = 16;

%%

Beta = zeros( SiteNumber, VoxelNumber );
SE = zeros( SiteNumber, VoxelNumber );

for SiteIndex = 1:SiteNumber
    Temp = load( [ InputPath, filesep, SiteList{ SiteIndex, 1 }, '.mat' ], 'Beta', 'SE' );
    Beta( SiteIndex, : ) = Temp.Beta;
    SE( SiteIndex, : ) = Temp.SE;
end

REMA = RUN_REMA( Beta, SE );

mkdir( OutputPath );

save( [ OutputPath, filesep, 'REMA.mat' ], 'REMA' );

Header.fname = [ OutputPath, filesep, 'MEAN.nii' ];
Volume = double( MaskIndex );
Volume( MaskIndex ) = REMA.MStar(:);
Volume = reshape( Volume, Header.dim( 1, 1 ), Header.dim( 1, 2 ), Header.dim( 1, 3 ) );
spm_write_vol( Header, Volume );

Header.fname = [ OutputPath, filesep, 'SE.nii' ];
Volume = double( MaskIndex );
Volume( MaskIndex ) = REMA.SE_MStar(:);
Volume = reshape( Volume, Header.dim( 1, 1 ), Header.dim( 1, 2 ), Header.dim( 1, 3 ) );
spm_write_vol( Header, Volume );

Header.fname = [ OutputPath, filesep, 'ISquare.nii' ];
Volume = double( MaskIndex );
Volume( MaskIndex ) = REMA.ISquare(:);
Volume = reshape( Volume, Header.dim( 1, 1 ), Header.dim( 1, 2 ), Header.dim( 1, 3 ) );
spm_write_vol( Header, Volume );

Header.fname = [ OutputPath, filesep, 'ZValue.nii' ];
Volume = double( MaskIndex );
Volume( MaskIndex ) = ( REMA.MStar - 0 )./REMA.SE_MStar;
Volume = reshape( Volume, Header.dim( 1, 1 ), Header.dim( 1, 2 ), Header.dim( 1, 3 ) );
spm_write_vol( Header, Volume );

end