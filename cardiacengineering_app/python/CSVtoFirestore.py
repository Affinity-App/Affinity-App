import pandas as pd
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# Initialize Firebase Admin SDK
cred = credentials.Certificate('cardiacengineering_app\python\affinity-app-1018-firebase-adminsdk-uto31-3175c4cc5e.json')  # Replace with the correct path to your service account key file
firebase_admin.initialize_app(cred)
db = firestore.client()

# Read CSV file
csv_file = "cardiacengineering_app\python\csv\data_1.csv"  # Replace with the correct path to your CSV file
df = pd.read_csv(csv_file)

# Convert DataFrame to dictionary
data = df.to_dict(orient='records')

# Define Firestore collection reference
collection_ref = db.collection('your_collection_name')  # Replace 'your_collection_name' with the name of your Firestore collection

# Insert data into Firestore
for item in data:
    collection_ref.add(item)
