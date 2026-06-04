import os
import pickle
from flask import Blueprint, request, jsonify

predict_bp = Blueprint('predict', __name__)

MODEL_PATH = os.path.join(os.path.dirname(__file__), '..', 'model', 'price_model.pkl')

def _load_model():
    if os.path.exists(MODEL_PATH):
        with open(MODEL_PATH, 'rb') as f:
            return pickle.load(f)
    return None

@predict_bp.route('/predict-price', methods=['POST'])
def predict_price():
    data = request.get_json() or {}
    city = data.get('city', 'Islamabad')
    size_marla = float(data.get('size_marla', 5))
    block = data.get('block', 'A')
    category = data.get('category', 'residential')

    model = _load_model()
    if model is None:
        # Fallback heuristic for Pakistan plot pricing (PKR per marla)
        base_rates = {'Islamabad': 700000, 'Lahore': 550000, 'Karachi': 600000}
        rate = base_rates.get(city, 500000)
        block_multiplier = {'A': 1.2, 'B': 1.0, 'C': 0.9}.get(block, 1.0)
        predicted = size_marla * rate * block_multiplier
    else:
        predicted = float(model.predict([[size_marla, hash(city) % 100, hash(block) % 10]])[0])

    return jsonify({
        'predicted_price_pkr': round(predicted, 0),
        'city': city,
        'size_marla': size_marla,
        'block': block,
        'category': category,
    })
