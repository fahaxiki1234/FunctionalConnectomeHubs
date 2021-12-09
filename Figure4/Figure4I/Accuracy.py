import pandas
import seaborn
import matplotlib.pyplot as pyplot

seaborn.set(style="ticks")

Accuracy = pandas.read_csv(r"YOURPATH\Accuracy.csv", header=None)

fig = pyplot.figure(figsize=(1.8, 1.26))

ax = fig.add_subplot(1, 3, 1)
seaborn.barplot(x=Accuracy.loc[0], y=Accuracy.loc[2], hue=Accuracy.loc[1], color="tab:orange", ci=95)
ax.set_ylim([0.2, 1])
pyplot.axis("off")
pyplot.legend(bbox_to_anchor=(1.01, 2), borderaxespad=0)

ax = fig.add_subplot(1, 3, 2)
seaborn.barplot(x=Accuracy.loc[0], y=Accuracy.loc[3], hue=Accuracy.loc[1], color="tab:blue", ci=95)
ax.set_ylim([0.2, 1])
pyplot.axis("off")
pyplot.legend(bbox_to_anchor=(1.01, 2), borderaxespad=0)

ax = fig.add_subplot(1, 3, 3)
seaborn.barplot(x=Accuracy.loc[0], y=Accuracy.loc[4], hue=Accuracy.loc[1], color="tab:green", ci=95)
ax.set_ylim([0.2, 1])
pyplot.axis("off")
pyplot.legend(bbox_to_anchor=(1.01, 2), borderaxespad=0)

fig.subplots_adjust(left=0, bottom=0, right=1, top=1)
fig.savefig(r"YOURPATH\Accuracy.tiff", dpi=600)

pyplot.show()