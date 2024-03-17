import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import random
import time

# Replace the path with the path to your service account key JSON file
cred = credentials.Certificate("cardiacengineering_app/python/affinity-app-1018-firebase-adminsdk-uto31-4574cd060c.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

# Initialize blood pressure with a random value between 90-110
blood_pressure = random.randint(900, 1100) / 10  # To have one decimal place

# Function to generate random data for each sensor
def generate_data():
    return {
        "power_consumption": round(random.uniform(45,50), 1),  # Power consumption between 40-60 watts/h
        "pressure": format(blood_pressure, '.1f'),  # Format blood pressure to one decimal place
        "flow_rate": round(random.uniform(4.5, 5.5), 1 ),  # Round flow rate to one decimal place
        "bpm": round(random.uniform(75,77), 1)
    }

# Function to update blood pressure within range and increment by random value less than 1
def update_blood_pressure():
    global blood_pressure
    change = random.uniform(-1.0, 1.0)  # Generate random change between -1.0 and 1.0
    blood_pressure += change
    blood_pressure = max(min(blood_pressure, 110.0), 90.0)  # Ensure blood pressure stays within range

# Upload data to Firebase
def upload_data():
    global blood_pressure  # Access the global blood pressure variable
    first_upload = True  # Flag to indicate the first upload
    while True:
        if not first_upload:
            update_blood_pressure()  # Update blood pressure after the first upload
        data = generate_data()
        db.collection("sensor_data").document("power_consumption").set({"watts per hour": data["power_consumption"]}) 
        db.collection("sensor_data").document("blood_pressure").set({"mmHg": data["pressure"]})             #mmHg
        db.collection("sensor_data").document("flow_rate").set({"liters per minute": data["flow_rate"]})                #watts/hour
        db.collection("sensor_data").document("bpm").set({"beats per minute": data["bpm"]})                                  #bpm
        print("Data uploaded successfully.")
        time.sleep(1)  # Adjust the time interval as needed
        first_upload = False  # Update the flag after the first upload

if __name__ == "__main__":
    upload_data()
