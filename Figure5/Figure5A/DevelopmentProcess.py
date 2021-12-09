import pandas
import seaborn
import matplotlib.pyplot as pyplot

seaborn.set(style="ticks")

DevelopmentProcess = pandas.read_csv(r"YOUPATH\DevelopmentProcess.csv", header=None)

fig = pyplot.figure(figsize=(3, 1.26))
ax = fig.add_subplot()

seaborn.barplot(x=DevelopmentProcess.loc[0], y=DevelopmentProcess.loc[2], hue=DevelopmentProcess.loc[1], hue_order=[1, 0], palette=["tab:red", "tab:blue"], ci=95)

ax.set_xlim([-0.6, 5.6])
ax.set_ylim([0, 0.8])
pyplot.axis("off")
pyplot.legend(bbox_to_anchor=(100, 100), borderaxespad=0)

fig.subplots_adjust(left=0, bottom=0, right=1, top=1)
fig.savefig(r"YOUPATH\DevelopmentProcess.tiff", dpi=600)

pyplot.show()