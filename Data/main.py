import os
import json
import shutil

# Source and destination folders
source_folder = "E:/Minor Project-II Data/DATA/Male T20I"
destination_folder = "D:/Minor_Project-II/Data/All India Matches/T20I"
c=0
# Condition function
def condition(json_data):
    # Define your condition here
    # For example, extract files where a specific key exists
    return 'India' in json_data['info']['teams']
    

# Iterate through each file in the source folder
for filename in os.listdir(source_folder):
    print(filename)
    if filename.endswith(".json"):
        # Read JSON file
        with open(os.path.join(source_folder, filename), 'r') as file:
            json_data = json.load(file)
        
        # Check condition
        if condition(json_data):
            c+=1
            # date = json_data['info']['dates'][0].split('-')[0]
            print("India's Match",filename)
            # date_folder = os.path.join(destination_folder, date)
            # if not os.path.exists(date_folder):
                # os.makedirs(date_folder) 
            # Move file to destination folder
            shutil.copy(os.path.join(source_folder, filename), os.path.join(destination_folder, filename))
    
print(c,'Files Moved Successfully!')