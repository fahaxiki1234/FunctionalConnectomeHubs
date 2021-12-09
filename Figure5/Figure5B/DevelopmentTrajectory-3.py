import numpy
import pandas
import seaborn
import matplotlib.pyplot as pyplot
from loess.loess_1d import loess_1d

seaborn.set(style='ticks')

fig = pyplot.figure(figsize=(3, 1))
ax = fig.add_subplot()

ax.plot( ( 5.8074, 5.8074 ), ( 0, 1 ), 'k--', linewidth=0.8)
#ax.plot( ( 6.5078, 6.5078 ), ( 0, 1 ), 'k--', linewidth=0.8)
#ax.plot( ( 7.3923, 7.3923 ), ( 0, 1 ), 'k--', linewidth=0.8)
ax.plot( ( 8.0553, 8.0553 ), ( 0, 1 ), 'k--', linewidth=0.8)
ax.plot( ( 9.3015, 9.3015 ), ( 0, 1 ), 'k--', linewidth=0.8)
ax.plot( ( 12.1818, 12.1818 ), ( 0, 1 ), 'k--', linewidth=0.8)
ax.plot( ( 12.8853, 12.8853 ), ( 0, 1 ), 'k--', linewidth=0.8)

AxonDevelopment = pandas.read_csv(r"E:\DATA\BrainSpanAtlas\DevelopmentTrajectory-AxonDevelopment-Hub.csv", header=None)
xout, yout, weigts = loess_1d(AxonDevelopment.loc[0].values, AxonDevelopment.loc[1].values, frac=0.1)
seaborn.lineplot(x=xout, y=yout, linewidth=1, color="tab:brown", ci=None)

AxonDevelopment = pandas.read_csv(r"E:\DATA\BrainSpanAtlas\DevelopmentTrajectory-AxonDevelopment-NonHub.csv", header=None)
xout, yout, weigts = loess_1d(AxonDevelopment.loc[0].values, AxonDevelopment.loc[1].values, frac=0.1)
seaborn.lineplot(x=xout, y=yout, linewidth=1, color="tab:brown", linestyle='--', ci=None)


Myelination = pandas.read_csv(r"E:\DATA\BrainSpanAtlas\DevelopmentTrajectory-Myelination-Hub.csv", header=None)
xout, yout, weigts = loess_1d(Myelination.loc[0].values, Myelination.loc[1].values, frac=0.1)
seaborn.lineplot(x=xout, y=yout, linewidth=1, color="tab:cyan", ci=None)

Myelination = pandas.read_csv(r"E:\DATA\BrainSpanAtlas\DevelopmentTrajectory-Myelination-NonHub.csv", header=None)
xout, yout, weigts = loess_1d(Myelination.loc[0].values, Myelination.loc[1].values, frac=0.1)
seaborn.lineplot(x=xout, y=yout, linewidth=1, color="tab:cyan", linestyle='--', ci=None)

ax.set_xlim(5.7, 14)
ax.set_xticks([])
#ax.set_xticks([5.8074, 6.5078, 7.3923, 8.0553, 9.3015, 12.1818, 12.8853] )
ax.set_xticks([5.8074, 8.0553, 9.3015, 12.1818, 12.8853] )
ax.set_xticklabels([])
#ax.set_xticklabels( ["8 PCW", "13 PCW", "24 PCW", "Birth", "1 PNY", "12 PNY", "20 PNY"] )
#ax.set_xlabel("Age")

ax.set_ylim(-0.01, 1.01)
ax.set_yticks([0, 0.5, 1])
ax.set_yticklabels([])
#ax.set_ylabel("Expression level")

fig.subplots_adjust(left=0.02, bottom=0.05, right=0.99, top=0.99)
fig.savefig(r"E:\DATA\BrainSpanAtlas\DevelopmentTrajectory-3.tiff", dpi=600)

pyplot.show()