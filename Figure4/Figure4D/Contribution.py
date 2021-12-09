import pandas
import seaborn
import matplotlib.pyplot as pyplot

seaborn.set(style="ticks")

Contribution = pandas.read_csv(r"YOURPATH\Contribution.csv", header=None)

fig = pyplot.figure(figsize=(1.26, 1.26))
ax = fig.add_subplot()

seaborn.kdeplot(data=Contribution, x=Contribution.loc[1], fill=True, color="tab:gray", alpha=1, linewidth=0)

ax.set_xlim([-4.2, 0.2])
ax.set_xticks([ -4, -3, -2, -1, 0 ])
ax.set_ylim([-0.05, 1.55])
ax.set_yticks([ 0, 0.5, 1, 1.5 ])

fig.subplots_adjust(left=0.04, bottom=0.04, right=0.99, top=0.99)
fig.savefig(r"YOURPATH\Contribution.tiff", dpi=600)

pyplot.show()