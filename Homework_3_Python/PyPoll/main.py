## PyPoll
import os
import csv
import datetime
from datetime import date
today = str(date.today())

csvpath = os.path.join('..', 'PyPoll','election_data.csv')

# Determine total votes
total_votes = int(0)
with open(csvpath, newline="") as csvfile:
    csvreader = csv.reader(csvfile, delimiter=",")   
    csv_header = next(csvreader)

    for row in csvreader:
        if row[0]:
            total_votes += 1

#Get a complete list of candidates who received votes
last_name = []
with open(csvpath, newline="") as csvfile:
    csvreader = csv.reader(csvfile, delimiter=",")   
    csv_header = next(csvreader)

    for row in csvreader:
        if row[2] not in last_name:
            last_name.append(str(row[2]))

#Find the total number of votes each candidate won
total_won = []
for n in range(len(last_name)):
   total_won.append(0)

with open(csvpath, newline="") as csvfile:
    csvreader = csv.reader(csvfile, delimiter=",")   
    csv_header = next(csvreader)

    for row in csvreader:
        for n in range(len(last_name)):
            if row[2] == last_name[n]:
                total_won[n] += 1
                break

#Determine the percentage of votes each candidate won
percent_won = []
for n in range(len(last_name)):
   percent_won.append((total_won[n]/total_votes)*100)

# Find the winner of the election based on popular vote
winner = "nobody"
winning_percent = 0
for n in range(len(last_name)):
   if percent_won[n] > winning_percent:
       winning_percent = percent_won[n]
       winner = last_name[n]

# Add the candidates and information to a dictionary and print!
candidate = []
for n in range(len(last_name)):
   candidate.append(str())

print(f"                                   ", file = text_file)
print(f"                                   ", file = text_file)
print(f"Election Results", file = text_file)
print(f"---------------------------", file = text_file)
print(f"Total Votes: {total_votes}", file = text_file)
print(f"---------------------------", file = text_file)

for n in range(len(last_name)):
    candidate[n] = {'name':str(last_name[n]), 'percent':percent_won[n], 'total':total_won[n]}
    print(f"{(candidate[n]['name'])}: {round((candidate[n]['percent']),3)}% ({(candidate[n]['total'])})", file = text_file)

print(f"---------------------------", file = text_file)
print(f"Winner: {winner}", file = text_file)
print(f"-------------------------", file = text_file)
print(f"                                   ", file = text_file)

with open("Election Results Output.txt", "w") as text_file:
    #print(f"                                   ", file = text_file)
    #print(f"                                   ", file = text_file)
    print(f"Election Results", file = text_file)
    print(f"---------------------------", file = text_file)
    print(f"Total Votes: {total_votes}", file = text_file)
    print(f"---------------------------", file = text_file)

    for n in range(len(last_name)):
        candidate[n] = {'name':str(last_name[n]), 'percent':percent_won[n], 'total':total_won[n]}
        print(f"{(candidate[n]['name'])}: {round((candidate[n]['percent']),3)}% ({(candidate[n]['total'])})", file = text_file)

    print(f"---------------------------", file = text_file)
    print(f"Winner: {winner}", file = text_file)
    print(f"-------------------------", file = text_file)
    #print(f"                                   ", file = text_file)
