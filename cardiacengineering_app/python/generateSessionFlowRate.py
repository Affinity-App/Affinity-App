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

# Function to generate random data for each sensor
def generate_data(previous_flow_rate, x_value):
    normal_flow_rate = 5.000
    max_deviation = 0.250
    deviation = round(random.uniform(-max_deviation, max_deviation), 3)
    flow_rate = round(normal_flow_rate + deviation, 3)
    flow_rate = min(max(flow_rate, 3.000), 3.500)  # Ensure flow rate is within bounds
    
    return {
        "x_value": str(x_value), 
        "y_value": str(format(flow_rate, '.3f'))  # Format flow rate value to 3 decimal places
    }



# Upload data to Firebase
def upload_data(duration_seconds):
    start_time = time.time()  # Record the start time
    x_value = 0
    data_array = []
    previous_flow_rate = 0
    
    while True:
        if time.time() - start_time >= duration_seconds:
            break  # Exit the loop if desired duration is reached
        
        flow_rate = generate_data(previous_flow_rate, x_value)["y_value"]
        previous_flow_rate = float(flow_rate)

        data = generate_data(previous_flow_rate, x_value)
        data_array.append(data)

        if len(data_array) >= 31:  # New session starts after every 31 data points
            # Generate timestamp for the session
            timestamp = datetime.datetime.now().strftime("%m-%d-%y %H:%M")
            session_name = f"session {timestamp}"

            # Upload data to Firebase
            session_collection_ref = db.collection("large_heart_data").document("flow rate").collection(session_name)
            session_collection_ref.document("data").set({"data": data_array})
            print(f"Data uploaded for session {session_name}.")
            
            # Reset data array for the new session
            data_array = []

        time.sleep(1)  # Adjust the time interval as needed
        x_value += 1

if __name__ == "__main__":
    duration_seconds = 31 # Specify the desired duration in seconds
    
    upload_data(duration_seconds)
