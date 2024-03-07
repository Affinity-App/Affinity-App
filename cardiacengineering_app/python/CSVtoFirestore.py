import panda as pd
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# initialize firebase admin sdk
cred = credentials.Certificate('cardiacengineering_app\python\affinity-app-1018-firebase-adminsdk-uto31-3175c4cc5e.json')
firebase_admin.initialize_app(cred)
db = firestore.client()

#read csv file
csv_file = "cardiacengineering_app\python\csv\data_1.csv"
df = pd.read_csv(csv_file)

#convert data frame to dictionary
data = df.to_dict(orient='records')

#define firestore collection reference
collection_ref = db.collection('')

for item in data:
    collection_ref.add(item)