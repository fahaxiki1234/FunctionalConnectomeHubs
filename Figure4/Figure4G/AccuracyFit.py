import pandas
import seaborn
import matplotlib.pyplot as pyplot
from loess.loess_1d import loess_1d

seaborn.set( style="ticks" )

Accuracy = pandas.read_csv( r"YOURPATH\AccuracyFit.csv", header=None )

fig = pyplot.figure( figsize=( 1.8, 1.41 ) )
ax = fig.add_subplot()

pyplot.plot( [ 150, 150 ], [ 0.905, 0.920 ], color="0.3", linewidth=0.8, linestyle='--' )
seaborn.scatterplot( x=Accuracy.loc[0], y=Accuracy.loc[1], color="0.2", s=5 )
xout, yout, weigts = loess_1d( Accuracy.loc[0].values, Accuracy.loc[1].values, frac=0.2 )
seaborn.lineplot( x=xout, y=yout, color="0" )

ax.set_xlim( [ 100, 300 ] )
ax.set_xticks( [ 100, 150, 200, 250, 300 ] )
ax.set_ylim( [ 0.905, 0.920 ] )
ax.set_yticks( [ 0.905, 0.910, 0.915, 0.920 ] )

fig.subplots_adjust( left=0.04, bottom=0.04, right=0.99, top=0.99 )
fig.savefig( r"YOURPATH\AccuracyFit+.tiff", dpi=600 )

pyplot.show()