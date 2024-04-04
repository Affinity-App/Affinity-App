import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import random
import time
import os
import datetime

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

# Function to generate random data for each sensor
def generate_data(x_value):
    update_blood_pressure()  # Update blood pressure values
    combined_pressure = str(format(systolic_pressure, '.1f')) + "/" + str(format(diastolic_pressure, '.1f'))

    return {
        "x-value": str(x_value),
        "y_value": combined_pressure
    }

# Upload data to Firebase
def upload_data(duration_seconds):
    start_time = time.time()  # Record the start time
    x_value = 0  # Initialize x_value
    data_array = []
    
    while True:
        if time.time() - start_time >= duration_seconds:
            break  # Exit the loop if desired duration is reached
        
        data = generate_data(x_value)  # Generate new blood pressure data with current x_value
        data_array.append(data)

        if len(data_array) >= 31:  # New session starts after every 31 data points
            # Generate timestamp for the session
            timestamp = datetime.datetime.now().strftime("%m-%d-%y %H:%M")
            session_name = f"session {timestamp}"

            # Upload data to Firebase
            session_collection_ref = db.collection("large_heart_data").document("blood pressure").collection(session_name)
            session_collection_ref.document("data").set({"data": data_array})
            print(f"Data uploaded for session {session_name}.")
            
            # Reset data array for the new session
            data_array = []

        time.sleep(1)  # Adjust the time interval as needed
        x_value += 1  # Increment x_value

if __name__ == "__main__":
    duration_seconds = 31 # Specify the desired duration in seconds
    
    upload_data(duration_seconds)
