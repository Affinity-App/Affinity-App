import firebase_admin
from firebase_admin import credentials, firestore
import random
import time

# Initialize Firebase Admin SDK
cred = credentials.Certificate("cardiacengineering_app/python/affinity-app-1018-firebase-adminsdk-uto31-4574cd060c.json")
firebase_admin.initialize_app(cred)

# Initialize Firestore
db = firestore.client()

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

# Run the function to continuously upload RPM data
upload_rpm_data()
