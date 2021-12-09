import pandas
import seaborn
import matplotlib.pyplot as pyplot

seaborn.set(style="ticks")

Accuracy = pandas.read_csv(r"YOURPATH\Accuracy.csv", header=None)

fig = pyplot.figure(figsize=(1.18, 1.26))
ax = fig.add_subplot()

seaborn.lineplot([-0.6, 1.6], [0.5, 0.5], linestyle="dashed", color="0.3")
seaborn.lineplot([-0.6, 1.6], [0.6518, 0.6526], linestyle="dashed", color="tab:green")
seaborn.barplot(x=Accuracy.loc[0], y=Accuracy.loc[2], hue=Accuracy.loc[1], palette=["tab:orange", "tab:blue"], ci=95)

ax.set_xlim([-0.6, 1.6])
ax.set_ylim([0.2, 1])
pyplot.axis("off")
pyplot.legend(bbox_to_anchor=(1.01, 1), borderaxespad=0)

fig.subplots_adjust(left=0, bottom=0, right=1, top=1)
fig.savefig(r"YOURPATH\Accuracy.tiff", dpi=600)

pyplot.show()