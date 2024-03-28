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

def update_blood_pressure():
    while True:
        pressure = random.randint(80, 120)  # Random blood pressure between 80 and 120
        print(f"Blood Pressure: {pressure} mmHg")
        doc_ref = db.collection("pressure_data").document("generated")
        doc_ref.set({"pressure": pressure})  # Update the document with blood pressure data
        time.sleep(1)  # Wait for 5 seconds

update_blood_pressure()