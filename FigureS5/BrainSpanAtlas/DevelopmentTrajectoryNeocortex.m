close all;
clc;

load( 'AgeGenderStructure.mat' );
load( 'EntrezID.txt' );
GeneSymbol = importdata( 'GeneSymbol.txt' );

load( 'HubStructure.txt' );
load( 'NonHubStructure.txt' );

%%
for Process = { 'NeuronDifferentiation', 'NeuronMigration', 'DendriteDevelopment', 'SynapseDevelopment', 'AxonDevelopment', 'Myelination', 'AG' }
    ProcessGenes = importdata( [ Process{ 1 }, '.txt' ] );
    RowIndex = ismember( GeneSymbol, ProcessGenes );
    HubIndex = ismember( AgeGenderStructure( :, 3 ), HubStructure );
    NonHubIndex = ismember( AgeGenderStructure( :, 3 ), NonHubStructure );
    
    Data1 = [ AgeGenderStructure( HubIndex, 1 ), expression_matrix( RowIndex, [ 0; HubIndex ] > 0.5 )' ];
    Data2 = [ AgeGenderStructure( NonHubIndex, 1 ), expression_matrix( RowIndex, [ 0; NonHubIndex ] > 0.5 )' ];
    
    Data = zscore( [ Data1( :, 2:end ); Data2( :, 2:end ) ] );
    [ ~, PC ] = pca( Data, 'Centered', false );
    if corr( PC( :, 1 ), mean( Data, 2 ) ) < 0
        PC = -PC;
    end
    PC = ( PC( :, 1 ) - min( PC( :, 1 ) ) )/( max( PC( :, 1 ) ) - min( PC( :, 1 ) ) );
    csvwrite( [ pwd, filesep, 'DevelopmentTrajectoryNeocortex-', Process{ 1 }, '-Hub.csv' ], [ log2( Data1( :, 1 )' ); PC( 1:numel( Data1( :, 1 ) ), 1 )' ] );
    csvwrite( [ pwd, filesep, 'DevelopmentTrajectoryNeocortex-', Process{ 1 }, '-NonHub.csv' ], [ log2( Data2( :, 1 )' ); PC( numel( Data1( :, 1 ) ) + 1:end, 1 )' ] );
end