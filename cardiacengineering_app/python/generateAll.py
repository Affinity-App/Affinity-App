import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import random
import time

# Replace the path with the path to your service account key JSON file
cred = credentials.Certificate("cardiacengineering_app/python/affinity-app-1018-firebase-adminsdk-uto31-4574cd060c.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

# Function to generate random data for each sensor
def generate_data():
    blood_pressure = random.randint(80, 120)  # Generate blood pressure in the range 80-120
    blood_pressure += random.choice([-2, 0, 2])  # Add a random increment or decrement of ±2
    
    return {
        "battery": random.randint(0, 100),
        "blood_pressure": {
            "pressure": blood_pressure
        },
        "flow_rate": random.uniform(0.5, 2.0),
        "rpm": random.randint(500, 1000)
    }

# Upload data to Firebase
def upload_data():
    while True:
        data = generate_data()
        db.collection("sensor_data").document("battery").set({"value": data["battery"]})
        db.collection("sensor_data").document("blood_pressure").set(data["blood_pressure"])
        db.collection("sensor_data").document("flow_rate").set({"value": data["flow_rate"]})
        db.collection("sensor_data").document("rpm").set({"value": data["rpm"]})
        print("Data uploaded successfully.")
        time.sleep(1)  # Adjust the time interval as needed

if __name__ == "__main__":
    upload_data()
