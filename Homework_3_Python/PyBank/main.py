## PyBank
import os
import csv
import datetime
from datetime import date
today = str(date.today())

csvpath = os.path.join('..', 'PyBank','budget_data.csv')

# Determine total months
total_months = int(0)
with open(csvpath, newline="") as csvfile:
    csvreader = csv.reader(csvfile, delimiter=",")   
    csv_header = next(csvreader)

    for row in csvreader:
        if row[0]:
            total_months += 1

# Determine total net profit
total_net = int(0)
with open(csvpath, newline="") as csvfile:
    csvreader = csv.reader(csvfile, delimiter=",")   
    csv_header = next(csvreader)

    for row in csvreader:
        if row[1]:
            total_net += int(row[1])

# Determine the average change
with open(csvpath, newline="") as csvfile:
    csvreader = csv.reader(csvfile, delimiter=",")   
    csv_header = next(csvreader) #skip the header
    total_changes = 0
    individual_profits = []
    individual_months = []
    individual_changes = []

    for row in csvreader:
        current_month_amount =int(row[1])
        current_month = row[0]
        individual_profits.append(current_month_amount)
        individual_months.append(current_month)

for n in range(1,86):
    individual_changes.append(individual_profits[n]-individual_profits[n-1])
    total_changes=sum(individual_changes)
    average_change = total_changes/(total_months-1)

# Determine the greatest increase
greatest_increase_amount = individual_changes[0]
for n in range(1,85):
    if individual_changes[n] > greatest_increase_amount:
        greatest_increase_amount = individual_changes[n]
        greatest_increase_month = individual_months[n+1]

# Determine the greatest increase
greatest_decrease_amount = individual_changes[0]
for n in range(1,85):
    if individual_changes[n] < greatest_decrease_amount:
        greatest_decrease_amount = individual_changes[n]
        greatest_decrease_month = individual_months[n+1]

print("                            ")
print("                            ")
print(f"Financial Analysis {today}")
print("--------------------------------------------------------")
print(f"Total Months: {total_months}")
print(f"Total: ${total_net}")
print(f"Average Change: ${round(average_change,2)}")
print(f"Greatest increase in profits: ${greatest_increase_amount} for {greatest_increase_month}")
print(f"Greatest decrease in profits: ${greatest_decrease_amount} for {greatest_decrease_month}")
print("                            ")

with open("Financial Analysis Output.txt", "w") as text_file:
    #print("                            ", file = text_file)
    #print("                            ", file = text_file)
    print(f"Financial Analysis {today}", file = text_file)
    print("--------------------------------------------------------", file = text_file)
    print(f"Total Months: {total_months}", file = text_file)
    print(f"Total: ${total_net}", file = text_file)
    print(f"Average Change: ${round(average_change,2)}", file = text_file)
    print(f"Greatest increase in profits: ${greatest_increase_amount} for {greatest_increase_month}", file = text_file)
    print(f"Greatest decrease in profits: ${greatest_decrease_amount} for {greatest_decrease_month}", file = text_file)
    #print("                            ", file = text_file)