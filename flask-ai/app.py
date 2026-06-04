from flask import Flask, request, jsonify
from flask_cors import CORS
from routes.predict import predict_bp
import os

app = Flask(__name__)
CORS(app)
app.register_blueprint(predict_bp, url_prefix='/api')

@app.route('/health')
def health():
    return jsonify({'status': 'ok', 'service': 'ManzilIQ Price AI'})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=int(os.getenv('PORT', 8000)), debug=True)
