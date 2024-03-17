import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import random
import time

# Initialize Firebase Admin SDK
cred = credentials.Certificate("cardiacengineering_app/python/affinity-app-1018-firebase-adminsdk-uto31-4574cd060c.json")  # Update with your service account key file
firebase_admin.initialize_app(cred)

# Get a reference to the Firestore database
db = firestore.client()

def update_battery_data():
    battery_consumption = 100
    while battery_consumption > 0:
        print(f"Battery consumption: {battery_consumption}%")
        doc_ref = db.collection("battery_data").document("generated")
        doc_ref.set({"percent%": battery_consumption})  # Update the document with current battery consumption
        time.sleep(5)  # Wait for 5 seconds
        battery_consumption -= 1

def update_flow_rate():
    while True:
        normal_flow_rate = 5.000
        deviation = round(random.uniform(-0.150, 0.150), 3)
        flow_rate = round(normal_flow_rate + deviation, 3)  # Add deviation and round to 3 decimal places
        print(f"Flow Rate: {flow_rate} liters per minute")
        doc_ref = db.collection("flow_rate").document("generated")
        doc_ref.set({"rate": flow_rate})  # Update the document with flow rate data
        time.sleep(1)  # Wait for 1 second

def update_blood_pressure():
    while True:
        pressure = random.randint(80, 120)  # Random blood pressure between 80 and 120
        print(f"Blood Pressure: {pressure} mmHg")
        doc_ref = db.collection("pressure_data").document("generated")
        doc_ref.set({"pressure": pressure})  # Update the document with blood pressure data
        time.sleep(1)  # Wait for 1 second

def generate_rpm():
    # Generate initial RPM value
    rpm = random.randint(60, 100)

    while True:
        # Simulate RPM fluctuations by +-2
        rpm += random.choice([-2, 0, 2])
        # Ensure RPM stays within the range of 60 to 100
        rpm = max(60, min(rpm, 100))
        yield rpm
        time.sleep(1)  # Adjust sleep duration as needed

def upload_rpm_data():
    rpm_generator = generate_rpm()
    doc_ref = db.collection('rpm_data').document("generated")

    while True:
        rpm_value = next(rpm_generator)
        # Update RPM data in Firestore
        doc_ref.update({
            'rpm': rpm_value
        })
        print(f"RPM data updated: {rpm_value}")
        time.sleep(1)  # Adjust sleep duration as needed (every 1 second)

# Run each function in a separate thread to execute simultaneously
import threading

battery_thread = threading.Thread(target=update_battery_data)
flow_rate_thread = threading.Thread(target=update_flow_rate)
blood_pressure_thread = threading.Thread(target=update_blood_pressure)
rpm_thread = threading.Thread(target=upload_rpm_data)

battery_thread.start()
flow_rate_thread.start()
blood_pressure_thread.start()
rpm_thread.start()
