import firebase_admin
from firebase_admin import credentials, firestore

# Initialize Firebase Admin SDK
cred = credentials.Certificate("cardiacengineering_app\\python\\affinity-app-1018-firebase-adminsdk-uto31-4574cd060c.json")
firebase_admin.initialize_app(cred)

# Initialize Firestore
db = firestore.client()

def upload_rpm_data(rpm_data):
    # Assuming rpm_data is a list of RPM values
    # Loop through the RPM data and upload each value to Firestore
    for rpm_value in rpm_data:
        # Create a document reference
        doc_ref = db.collection('rpm_data').document()
        # Set data in Firestore document
        doc_ref.set({
            'rpm_value': rpm_value
        })

# Assuming you have a list of RPM values generated
rpm_values = [79, 80, 81]  # Replace with your generated RPM values
upload_rpm_data(rpm_values)
