import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import random
import time
import os

# Set the environment variable to specify the path to your service account key JSON file
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = r"C:/Users/User/Downloads/affinity-app-1018-firebase-adminsdk-uto31-4574cd060c.json"

# Function to initialize Firebase app with credentials
def initialize_firebase():
    # Fetch the value of the environment variable
    key_file_path = os.environ.get('GOOGLE_APPLICATION_CREDENTIALS')

    if key_file_path is None:
        raise ValueError("GOOGLE_APPLICATION_CREDENTIALS environment variable is not set")

    # Create credentials object using the specified path
    cred = credentials.Certificate(key_file_path)

    # Initialize Firebase app with the credentials
    firebase_admin.initialize_app(cred)

# Initialize Firebase app with credentials
initialize_firebase()

# Get Firestore client
db = firestore.client()

# Initialize blood pressure with a random value between 90-110
blood_pressure = random.randint(900, 1100) / 10  # To have one decimal place

# Initialize x_values
x_value = 0

# Function to generate random data for each sensor
def generate_data():
    return {
        "power_consumption": str(format(round(20 + random.uniform(-1.0, +1.0), 2), '.2f')),
        "pressure": f"{systolic_pressure:.2f}/{diastolic_pressure:.2f}",
        "flow_rate": str(format(round(random.uniform(4.5, 5.5), 2), '.2f')),
        "bpm": str(format(round(random.uniform(75, 77), 2), '.2f'))
    }

# Global variables to store blood pressure
systolic_pressure = 120.0
diastolic_pressure = 80.0

# Function to update blood pressure within range and increment by random value less than 1
def update_blood_pressure():
    global systolic_pressure
    global diastolic_pressure
    systolic_change = random.uniform(-1.0, 1.0)  # Generate random change for systolic pressure
    diastolic_change = random.uniform(-1.0, 1.0)  # Generate random change for diastolic pressure
    systolic_pressure += systolic_change
    diastolic_pressure += diastolic_change
    # Ensure blood pressure stays within reasonable ranges
    systolic_pressure = max(min(systolic_pressure, 180.0), 90.0)
    diastolic_pressure = max(min(diastolic_pressure, 120.0), 60.0)
    # Adjust diastolic pressure if it's too high or too low
    if diastolic_pressure >= systolic_pressure:
        diastolic_pressure = systolic_pressure - random.uniform(30, 50)  # Adjust within a reasonable range
    elif diastolic_pressure < 50:
        diastolic_pressure = random.uniform(50, 60)  # Adjust within a reasonable range

# Upload data to Firebase
def upload_data(duration_seconds):
    global blood_pressure, x_value  # Access the global variables
    start_time = time.time()  # Record the start time
    while True:
        if time.time() - start_time >= duration_seconds:
            break  # Exit the loop if desired duration is reached
        
        update_blood_pressure()  # Update blood pressure
        data = generate_data()
        
        # Update the live data for blood_pressure"
        db.collection("sensor_data").document("blood_pressure").update({
            "data": {
                "x_value": x_value,  # Use the current x_value
                "y_value": data["pressure"]
            }
        })

        db.collection("large_heart_data").document("blood pressure").collection("live session").document("data").update({
            "data": ([{ "x_value": x_value, "y_value": data["pressure"] }])
        })

        # update live data for bpm
        db.collection("sensor_data").document("bpm").update({
            "data": {
                "x_value": x_value,  # Use the current x_value
                "y_value": data["bpm"]
            }
        })

        db.collection("large_heart_data").document("bpm").collection("live session").document("data").update({
            "data": ([{ "x_value": str(x_value), "y_value": data["bpm"] }])
        })

        # update live data for flow rate
        db.collection("sensor_data").document("flow_rate").update({
            "data": {
                "x_value": x_value,  # Use the current x_value
                "y_value": data["flow_rate"]
            }
        })
        
        db.collection("large_heart_data").document("flow rate").collection("live session").document("data").update({
            "data": ([{ "x_value": x_value, "y_value": data["flow_rate"] }])
        })

        # update live data for power consumption
        db.collection("sensor_data").document("power_consumption").update({
            "data": {
                "x_value": x_value,  # Use the current x_value
                "y_value": data["power_consumption"]
            }
        })

        db.collection("large_heart_data").document("power consumption").collection("live session").document("data").update({
            "data": ([{ "x_value": x_value, "y_value": data["power_consumption"] }])
        })
        
        print("Data uploaded successfully.")
        
        # Increment x_value
        x_value += 1
        
        time.sleep(1)  # Adjust the time interval as needed

if __name__ == "__main__":
    duration_seconds = 60  # Specify the desired duration in seconds
    x_value = 0  # Reset x_value
    upload_data(duration_seconds)
