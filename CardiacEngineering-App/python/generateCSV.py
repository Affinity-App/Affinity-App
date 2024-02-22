import csv
import os

def generate_data_csv():
  """
  Generates a CSV file named "data#".csv, where # is an incremented number
  based on existing files in the current directory.

  Args:
    data: The data to write to the CSV file.
  """

  # Get existing data files
  data_files = [f for f in os.listdir() if f.startswith("data")]

  # Extract existing indices (if any)
  # loops through each file f in the list data_files
  # checks the char in between the _ and the . in the file name
  # creates an array of the numbers
  indices = [int(f.split(".")[0].split("_")[-1]) for f in data_files if f.split(".")[0].split("_")[-1].isdigit()]

  # Find the next available index which is 1 bigger than the max
  next_index = 1 if not indices else max(indices) + 1

  # Generate the filename
  target_directory = "CardiacEngineering-App/python/csv"
  filename = f"data_{next_index}.csv"
  full_filename = os.path.join(target_directory, filename)

  # Write the data to the CSV file
  data = [{"firstName": "Caleb", "lastName" : "Aragones"},
          {"firstName": "Dart", "lastName" : "Calitz"},
          {"firstName": "Tim", "lastName" : "Allec"},
          {"firstName": "Vince", "lastName" : "Melara"},
          {"firstName": "Brian", "lastName" : "Lee"},
          {"firstName": "Phinehas", "lastName" : "Maina"},
          ]
  
  with open(full_filename, "w") as csvfile:
    fieldnames = data[0].keys()
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    writer.writerows(data)

  print(f"Data saved to: {full_filename}")

def generate_data():
    # Time (Hour, Minute, Seconds), RPM, Pressure (PSI), Battery, Flow (GPM)
        # Time will be random time, but hard coded for 3 minutes
        # RPM will be RHR average of 21 year olds
        # Pressure will be random between 45 - 55 PSI
        # Battery will start at random number above 50, and decrease by one every 10 seconds for testing purposes
        # Flow I have no idea it'll be randomly going up and down between 95 and 105
    
  return "hello" # temp

generate_data_csv() # generates a csv with team member names