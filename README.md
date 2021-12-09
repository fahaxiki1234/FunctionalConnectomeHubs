FunctionalConnectomeHubs
Date 09/12/2021
E-mail: zhileixu@163.com


This repository provides code and source data that support the findings of the article entitled "Mapping Consistent, Reproducible, and Transcriptionally Relevant Connectome Hubs of the Human Brain" by Xu et al., 2021, https://doi.org/10.1101/2021.11.29.470494

If you use the code and/or data of this repository, please reference our work:
Xu, Z., Xia, M., Wang, X., Liao, X., Zhao, T., and He, Y. (2021). Mapping Consistent, Reproducible, and Transcriptionally Relevant Connectome Hubs of the Human Brain. bioRxiv, 2021.2011.2029.470494.

Please replace the "YOURPATH" string with your own path when using the code of this repository.

##Code##
1. Resting-state Functional MRI Preprocessing:
	PIPE_Preproces.m
	RUN_Preproces.m
2. Functional Connectivity Strength (FCS):
	PIPE_FCS.m
	RUN_FCS.m
	PIPE_Regression.m
	RUN_PoolMeasurement.m
	RUN_Regression.m
3. Random-Effects Meta-Analysis:
	PIPE_MetaAnalysis.m
	RUN_MetaAnalysis.m
	RUN_REMA.m
4. Mapping Seed-to-Whole-Brain Connectivity Profiles of Brain Hubs:
	PIPE_SeedBasedFC.m
	RUN_SeedBasedFC.m
5. Generating Surrogate FCS Map and Hub Map:
	FCS_Surrogate.py
	Hub_Surrogate.py

##BrainMask##
The gray matter mask used in our work.

##SurfaceFile##
The brain surface used to render our results in our work.

##Figure##
Code, source NIfTI file, and source data of the Figures 1 to 5 and S1 to S9 in our work.