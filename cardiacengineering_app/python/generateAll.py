import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import random
import time

# Replace the path with the path to your service account key JSON file
cred = credentials.Certificate("cardiacengineering_app/python/affinity-app-1018-firebase-adminsdk-uto31-4574cd060c.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

# Initialize power consumption with 50 watts/h
power_consumption = 50

# Function to generate random data for each sensor
def generate_data():
    return {
        "power_consumption": round(power_consumption, 1),  # Round power consumption to one decimal place
        "blood_pressure": {
            "pressure": format(random.randint(800, 1200) / 10, '.1f')  # Format blood pressure to one decimal place
        },
        "flow_rate": round(random.uniform(0.5, 2.0), 1),  # Round flow rate to one decimal place
        "rpm": random.randint(500, 1000)
    }

# Function to update power consumption within range and increment by random value less than 2.0
def update_power_consumption():
    global power_consumption
    change = random.uniform(-1.0, 1.0)  # Generate random change between -1.0 and 1.0
    power_consumption += change
    power_consumption = max(0, power_consumption)  # Ensure power consumption is non-negative

# Upload data to Firebase
def upload_data():
    global power_consumption  # Access the global power consumption variable
    first_upload = True  # Flag to indicate the first upload
    while True:
        if not first_upload:
            update_power_consumption()  # Update power consumption after the first upload
        data = generate_data()
        db.collection("sensor_data").document("power_consumption").set({"value": data["power_consumption"]})
        db.collection("sensor_data").document("blood_pressure").set({"pressure": data["blood_pressure"]})
        db.collection("sensor_data").document("flow_rate").set({"value": data["flow_rate"]})
        db.collection("sensor_data").document("rpm").set({"value": data["rpm"]})
        print("Data uploaded successfully.")
        time.sleep(1)  # Adjust the time interval as needed
        first_upload = False  # Update the flag after the first upload

if __name__ == "__main__":
    upload_data()
