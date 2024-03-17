import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import random
import time

# Replace the path with the path to your service account key JSON file
cred = credentials.Certificate("cardiacengineering_app/python/affinity-app-1018-firebase-adminsdk-uto31-4574cd060c.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

# Initialize blood pressure with a random value in the range 80-120
blood_pressure = random.randint(800, 1200) / 10  # To have one decimal place

# Function to generate random data for each sensor
def generate_data():
    return {
        "battery": random.randint(0, 100),
        "blood_pressure": {
            "pressure": format(blood_pressure, '.1f')  # Format to one decimal place
        },
        "flow_rate": round(random.uniform(0.5, 2.0), 1),  # Round flow rate to one decimal place
        "rpm": random.randint(500, 1000)
    }

# Function to update blood pressure within range and increment by random value less than 2.0
def update_blood_pressure():
    global blood_pressure
    change = random.uniform(-2.0, 2.0)  # Generate random change between -2.0 and 2.0
    blood_pressure += change
    blood_pressure = max(min(blood_pressure, 120.0), 80.0)  # Ensure blood pressure stays within range

# Upload data to Firebase
def upload_data():
    global blood_pressure  # Access the global blood pressure variable
    first_upload = True  # Flag to indicate the first upload
    while True:
        if not first_upload:
            update_blood_pressure()  # Update blood pressure after the first upload
        data = generate_data()
        db.collection("sensor_data").document("battery").set({"value": data["battery"]})
        db.collection("sensor_data").document("blood_pressure").set(data["blood_pressure"])
        db.collection("sensor_data").document("flow_rate").set({"value": data["flow_rate"]})
        db.collection("sensor_data").document("rpm").set({"value": data["rpm"]})
        print("Data uploaded successfully.")
        time.sleep(1)  # Adjust the time interval as needed
        first_upload = False  # Update the flag after the first upload

if __name__ == "__main__":
    upload_data()
