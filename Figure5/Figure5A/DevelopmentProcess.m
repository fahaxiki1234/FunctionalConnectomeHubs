close all;
clc;


load( 'YOURPATH\Figure4A\Hub1158.csv' );
load( 'YOURPATH\Figure4A\AHBA1158x10027.csv' );

load( 'YOURPATH\AHBAprocessed\ROIxGene_aparcaseg_RNAseq.mat', 'probeInformation' );
EntrezID = load( 'YOURPATH\BrainSpanAtlas\EntrezID.txt' );
GeneSymbol = importdata( 'YOURPATH\BrainSpanAtlas\GeneSymbol.txt' );

DevelopmentProcessPC = zeros( 1158*6, 3 );
Counter = 0;
for Process = { 'NeuronDifferentiation', 'NeuronMigration', 'DendriteDevelopment', 'SynapseDevelopment', 'AxonDevelopment', 'Myelination', 'AG' }
    ProcessGenes = importdata( [ 'YOURPATH\BrainSpanAtlas\', Process{ 1 }, '.txt' ]  );
    Index = ismember( GeneSymbol, ProcessGenes );
    Index = ismember( probeInformation.EntrezID, EntrezID( Index ) );
    Data = AHBA1158x10027( :, Index );
    [ ~, PC ] = pca( Data, 'Centered', false );
    PC = PC( :, 1 );
    if corr( PC, mean( Data, 2 ) ) < 0
        PC = -PC;
    end
    PC = ( PC( :, 1 ) - min( PC( :, 1 ) ) )/( max( PC( :, 1 ) ) - min( PC( :, 1 ) ) );
    DevelopmentProcessPC( Counter*1158 + 1:( Counter + 1 )*1158, : ) = [ Counter*ones( 1158, 1 ), Hub1158, PC ];
    Counter = Counter + 1;
end
csvwrite( 'YOURPATH\DevelopmentProcess.csv', DevelopmentProcessPC' );