import pandas
import seaborn
import matplotlib.pyplot as pyplot

seaborn.set(style="ticks")

AccuracyCohend = pandas.read_csv(r"YOURPATH\Accuracy_Cohend.csv", header=None)

fig = pyplot.figure(figsize=(1.2, 1.26))
ax = fig.add_subplot()

seaborn.barplot(x=AccuracyCohend.loc[0], y=AccuracyCohend.loc[1], palette=["0.8", "0.5", "0.2"], ci=95)

ax.set_xlim([-0.6, 2.6])
ax.set_ylim([0.2, 1])
pyplot.axis("off")

fig.subplots_adjust(left=0, bottom=0, right=1, top=1)
fig.savefig(r"YOURPATH\Accuracy_Cohend.tiff", dpi=600)

pyplot.show()