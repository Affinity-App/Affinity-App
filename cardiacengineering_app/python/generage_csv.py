import csv
import os
import random

def generate_data_csv():
  """
  Generates a CSV file named "data#".csv, where # is an incremented number
  based on existing files in the current directory.

  Args:
    data: The data to write to the CSV file.
  """

  # Get existing data files
  target_directory = "cardiacengineering_app/python/csv"
  data_files = [f for f in os.listdir(target_directory) if f.startswith("data")]

  # Extract existing indices (if any)
  # loops through each file f in the list data_files
  # checks the char in between the _ and the . in the file name
  # creates an array of the numbers
  indices = [int(f.split(".")[0].split("_")[-1]) for f in data_files if f.split(".")[0].split("_")[-1].isdigit()]

  # Find the next available index which is 1 bigger than the max
  next_index = 1 if not indices else max(indices) + 1

  # Generate the filename
  filename = f"data_{next_index}.csv"
  full_filename = os.path.join(target_directory, filename)

  # Write the data to the CSV file
  heartData = generate_data()
  
  with open(full_filename, "w") as csvfile:
    fieldnames = heartData[0].keys()
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    writer.writeheader()
    writer.writerows(heartData)

  print(f"Data saved to: {full_filename}")

def generate_data(): # Time (seconds), RPM, Pressure (psi), Battery (number), Flow (GPM)
  # Time will be random time, but hard coded for 3 minutes
  minutes = 3
  seconds = minutes * 60

  # RPM will be RPM average of 21 year olds between 60-100 (provided by gemini.google.com)
  rpm = random.randint(60, 100)
  print(f"Initial RPM: {rpm}")
    
  def generate_RPM(val):
    rpmStep = 3
    rpmMin = 60
    rpmMax = 100

    dice = random.randint(0, 21)
    
    # 33% chance each
    if dice <= 7 and val >= rpmMin + rpmStep:
        return val - rpmStep  # Decrease
    elif dice > 14 and val <= rpmMax - rpmStep:
        return val + rpmStep  # Increase
    else:
        return val  # Stay the same

  # Pressure will be random between 45 - 55 psi and change
  psi = random.randint(45, 55)
  print(f"Initial psi: {psi}")

  def generate_PSI(val):
    psiStep = 1
    psiMin = 45
    psiMax = 55

    dice = random.randint(0, 21)
    
    # 33% chance each
    if dice <= 7 and val >= psiMin + psiStep:
      return val - psiStep  # Decrease
    elif dice > 14 and val <= psiMax - psiStep:
      return val + psiStep  # Increase
    else:
      return val  # Stay the same

  # Battery will start at random number above 70, and decrease by one every 36 seconds for testing purposes
  battery = random.randint(70, 100)
  print(f"Initial Battery Percent: {battery}")

  def generate_battery(val, second):
    if second != seconds:
      if second % 36 == 0:
        return val - 1
    return val
     
  # Flow I have no idea it'll be randomly going up and down between 95 and 105
  gpm = 100
  print(f"Initial GPM: {gpm}")

  def generate_GPM(val):
    gpmStep = 1
    gpmMin = 95
    gpmMax = 105

    dice = random.randint(0, 21)
    
    # 33% chance each
    if dice <= 7 and val >= gpmMin + gpmStep:
      return val - gpmStep  # Decrease
    elif dice > 14 and val <= gpmMax - gpmStep:
      return val + gpmStep  # Increase
    else:
      return val  # Stay the same

  data = []

  # only iterate for each second
  for i in range(seconds):
    input = {"Second": i, "RPM": rpm, "Battery": battery, "Flow": gpm}
    data.append(input)

    rpm = generate_RPM(rpm)
    psi = generate_PSI(psi)
    battery = generate_battery(battery, i)
    gpm = generate_GPM(gpm)
  
  return data 

generate_data_csv() # generates a csv with team member names