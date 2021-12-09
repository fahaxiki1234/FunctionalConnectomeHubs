import numpy
from brainsmash.workbench.geo import volume
from brainsmash.mapgen.sampled import Sampled

coord_file = "YOURPATH\FCS_Surrogate\FCSXYZ.txt"
output_dir = "YOURPATH\FCS_Surrogate"

filenames = volume(coord_file, output_dir)

brain_map = "YOURPATH\FCS_Surrogate\FCS.txt"
gen = Sampled(x=brain_map, D=filenames['D'], index=filenames['index'])
surrogate_maps = gen(n=10000)
numpy.savetxt( "YOURPATH\FCS_Surrogate\FCS_Surrogate.txt", surrogate_maps, fmt="%.6e", delimiter=",", header="")

brain_map = "YOURPATH\FCS_Surrogate\FCS.txt"
gen = Sampled(x=brain_map, D=filenames['D'], index=filenames['index'])
surrogate_maps = gen(n=10000)
numpy.savetxt( "YOURPATH\FCS_Surrogate\FCS_Surrogate.txt", surrogate_maps, fmt="%.6e", delimiter=",", header="")