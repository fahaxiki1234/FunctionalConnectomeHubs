function [ VolumeToSurface, VolumeToMMP ] = RUN_VolumeToSurface( Volume, InterpMethod )

if ~exist( 'InterpMethod', 'var' )
    InterpMethod = 'linear';
end

WorkingDirectory = 'YOURPATH';
PathToBALSA = 'YOURPATH/BALSA';
PathToSurface = 'YOURPATH/SurfaceFile';

BrainMask = spm_vol( 'YOURPATH/BrainMask/rAAL2_WithoutCER.nii' );
BrainMask = spm_read_vols( BrainMask );
SubcortexMask = ( BrainMask > 7000 ).*( BrainMask < 8000 ) + ( BrainMask > 4200 ).*( BrainMask < 4300 ) + ( BrainMask > 4100 ).*( BrainMask < 4110 );

if ischar( Volume )
    Header = spm_vol( Volume );
    Volume = spm_read_vols( Header );
else
    load( 'YOURPATH/BrainMask/rAAL2_WithoutCER_Mask.mat' );
    load( 'YOURPATH/BrainMask/rAAL2_WithoutCER_Mask_Header.mat' );
    Temp = double( MaskIndex );
    Temp( MaskIndex ) = Volume;
    Volume = reshape( Temp, Header.dim( 1 ), Header.dim( 2 ), Header.dim( 3 ) );
end

Volume( SubcortexMask > 0.5 ) = 0;
Header.fname = [ WorkingDirectory, filesep, 'Temp', filesep, 'Temp.nii' ];
spm_write_vol( Header, Volume );
OutputFile = Header.fname;

Header = spm_vol( OutputFile );
[ Volume, XYZ ] = spm_read_vols( Header );

for LR = [ 'L', 'R' ]
    load( [ PathToSurface, filesep, 'midthickness.', LR, '.mat' ] );
    Vertices = Surface.vertices;
    BoundingBox = [ min( Vertices( :, 1 ) ) - abs( Header.mat( 1, 1 ) ), max( Vertices( :, 1 ) ) + abs( Header.mat( 1, 1 ) );  ...
        min( Vertices( :, 2 ) ) - abs( Header.mat( 2, 2 ) ), max( Vertices( :, 2 ) ) + abs( Header.mat( 2, 2 ) ); ...
        min( Vertices( :, 3 ) ) - abs( Header.mat( 3, 3 ) ), max( Vertices( :, 3 ) ) + abs( Header.mat( 3, 3 ) ) ];
    BoundingBox = ( XYZ( 1, : ) > BoundingBox( 1, 1 ) ).*( XYZ( 1, : ) < BoundingBox( 1, 2 ) ).*...
        ( XYZ( 2, : ) > BoundingBox( 2, 1 ) ).*( XYZ( 2, : ) < BoundingBox( 2, 2 ) ).*...
        ( XYZ( 3, : ) > BoundingBox( 3, 1 ) ).*( XYZ( 3, : ) < BoundingBox( 3, 2 ) );
    
    VertexValue = scatteredInterpolant( XYZ( 1, BoundingBox > 0.5 )', XYZ( 2, BoundingBox > 0.5 )', XYZ( 3, BoundingBox > 0.5 )', Volume( BoundingBox > 0.5 )', InterpMethod );
    VertexValue = VertexValue( double( Vertices( :, 1 ) ), double( Vertices( :, 2 ) ), double( Vertices( :, 3 ) ) );
        
    VolumeToSurface.( LR ) = VertexValue;
end

end