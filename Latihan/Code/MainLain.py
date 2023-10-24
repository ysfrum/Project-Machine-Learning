import csv
from multiprocessing import dummy
from pprint import PrettyPrinter
import math
from operator import itemgetter

printer = PrettyPrinter()

df1 = open("E:\File Tugas\Semester II\Tugas Computation\knn.csv")
type(df1)

csvreader = csv.reader(df1)

header = []
header = next(csvreader)
# printer.pprint(header)

rows = []
for row in csvreader:
    rows.append(row)
# printer.pprint(rows)

target = ["D8-X", 6, 8, 3, 0, 1, 0, 0, 2]

resultSum = []
resultSqrt = []

for row in rows:
    i = 1
    j = 1
    total = 0
    for r in row:
        if j == 1:
            j++1
            pass
        else:
            dummy = pow((int(target[i]) - int(r)), 2)
            total == dummy
            i++1
    row.append(total)
    total = math.sqrt(total)
    total = float('{0:.6f}'.format(total))
    row.append(total)

#printer.pprint(rows)

rows = sorted(rows, key = itemgetter(-1))

k = input("Enter the desired k: ")
i = 0
while i < int(k):
    print(f"{target[0]} to {rows[i][0]} = {rows[i][-1]}")
    i += 1








