clear;
clc;

VertexNumber = 64984;
FiberLength = ft_read_cifti( 'YOURPATH/iFOD2.76.mean-length-maps.dscalar.nii' );

Fiber = zeros( 124, VertexNumber );
for LengthIndex = 1:124
    Temp = [ 'ctl_map_at_', num2str( 2*LengthIndex ), '_', num2str( 2*LengthIndex + 2 ), '_mm' ];
    Fiber( LengthIndex, : ) = FiberLength.( Temp );
end
CortexMask = ~isnan( Fiber( 1, : ) );

Hub = [ Hub.L; Hub.R ]';

D = zeros( 1, 124 );
for counter = 1:124
    [ ~, ~, ~, Temp ] = ttest2( Fiber( counter, CortexMask.*( Hub > 0.5 ) > 0.5 ), Fiber( counter, CortexMask.*( Hub < 0.5 ) > 0.5 ) );
    D( counter ) = Temp.tstat/( Temp.df^0.5 );
end

Length = 2*( 1:124 ) + 1;
csvwrite( 'YOURPATH/Length_Cohensd.csv', [ Length( 1:end ); D( 1:end ) ] );