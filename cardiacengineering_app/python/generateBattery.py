import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
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

update_battery_data()