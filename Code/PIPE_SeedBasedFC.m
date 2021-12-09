clear;
clc;

InputPath = 'YOURPATH/Preprocess_xbcdswran';
OutputPath = 'YOURPATH/SeedBasedFC/xbcWGSdswran_DM';

Opt.mode                = 'batch'; % qsub session
Opt.max_queued          = 2;
Opt.flag_verbose        = true;
Opt.flag_pause          = true;
Opt.flag_update         = false;
Opt.time_between_checks = 5;

%%

load( 'YOURPATH/Participant_Update.mat' );

% load( 'YOURPATH/Figure2/Figure2B/ZValue_P0.001_ClusterSize200_Extreme15_Seed6.mat' );
load( 'YOURPATH/Figure2/Figure2B/SeedBasedFC_DM_Seed6.mat' );

Pipeline = [];
for counter = Range( 1 ):Range( 2 )
    IndividualPath = [ InputPath, Participant_Update.Path{ counter }, filesep, 'FunRaw', filesep, num2str( Participant_Update.ID( counter ), [ '%.', Participant_Update.IDLength{ counter }, 'd' ] ) ];
    InputFile = [ IndividualPath filesep, 'xbcWGSdswranrest.nii' ];

    Pipeline.( [ 'PP_', num2str( counter, '%.4d' ) ] ).opt.InputFile    = InputFile;
    Pipeline.( [ 'PP_', num2str( counter, '%.4d' ) ] ).opt.OutputFile   = [ OutputPath, Participant_Update.Path{ counter }, filesep, num2str( Participant_Update.ID( counter ), [ '%.', Participant_Update.IDLength{ counter }, 'd' ] ) ]; 
    Pipeline.( [ 'PP_', num2str( counter, '%.4d' ) ] ).opt.Seed         = Seed;
    Pipeline.( [ 'PP_', num2str( counter, '%.4d' ) ] ).command          = 'RUN_SeedBasedFC( opt.InputFile, opt.OutputFile, opt.Seed )';
end

PipeLogPath = [ pwd, filesep, 'SeedBasedFCLogs_', datestr( now, 30 ) ];

while exist( PipeLogPath, 'dir' ) == 7
    PipeLogPath = [ pwd, filesep, 'SeedBasedFCLogs_', datestr( now, 30 ) ];
end
mkdir( PipeLogPath );
Opt.path_logs = PipeLogPath;

addpath( pwd );

psom_run_pipeline( Pipeline, Opt );

end