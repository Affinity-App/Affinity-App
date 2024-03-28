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

# Function to generate random data for each sensor
def generate_data():
    return {
        "power_consumption" : str(format(round(20 + random.uniform(-1.0, +1.0), 2), '.2f')),
        "pressure" : str(format(blood_pressure, '.2f')),
        "flow_rate" : str(format(round(random.uniform(4.5, 5.5), 2), '.2f')),
        "bpm": str(format(round(random.uniform(75, 77), 2), '.2f'))
        
    }

# Function to update blood pressure within range and increment by random value less than 1
def update_blood_pressure():
    global blood_pressure
    change = random.uniform(-1.0, 1.0)  # Generate random change between -1.0 and 1.0
    blood_pressure += change
    blood_pressure = max(min(blood_pressure, 110.0), 90.0)  # Ensure blood pressure stays within range

# Upload data to Firebase
def upload_data(duration_seconds):
    global blood_pressure  # Access the global blood pressure variable
    start_time = time.time()  # Record the start time
    while True:
        if time.time() - start_time >= duration_seconds:
            break  # Exit the loop if desired duration is reached
        
        update_blood_pressure()  # Update blood pressure
        data = generate_data()
        db.collection("sensor_data").document("power_consumption").set({"watts per hour": data["power_consumption"]}) 
        db.collection("sensor_data").document("blood_pressure").set({"mmHg": data["pressure"]})             #mmHg
        db.collection("sensor_data").document("flow_rate").set({"liters per minute": data["flow_rate"]})                #watts/hour
        db.collection("sensor_data").document("bpm").set({"beats per minute": data["bpm"]})                                  #bpm
        print("Data uploaded successfully.")
        time.sleep(1)  # Adjust the time interval as needed

if __name__ == "__main__":
    duration_seconds = 25  # Specify the desired duration in seconds
    upload_data(duration_seconds)