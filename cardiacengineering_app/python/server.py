from flask import Flask

app = Flask(__name__)

@app.route('/record_now', methods=['POST'])
def record_now():
    # Execute the Python code when the endpoint is hit
    import generateAll  # Assuming your Python script is named firebase_data_upload.py
    return 'Recording initiated'

if __name__ == '__main__':
    app.run(debug=True)
