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

def update_flow_rate():
    while True:
        normal_flow_rate = 5.000
        deviation = random.uniform(-0.150, 0.150)
        flow_rate = round(normal_flow_rate + deviation, 3)  # Add deviation and round to 3 decimal places
        print(f"Flow Rate: {flow_rate} liters per minute")
        doc_ref = db.collection("flow_rate").document("generated")
        doc_ref.set({"rate": flow_rate})  # Update the document with flow rate data
        time.sleep(1)  # Wait for 1 seconds

update_flow_rate()
