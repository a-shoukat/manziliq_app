"""Train price prediction model from plot data exported from Supabase."""

import pickle
import os

MODEL_DIR = os.path.dirname(__file__)
MODEL_PATH = os.path.join(MODEL_DIR, 'price_model.pkl')

def train_sample_model():
    try:
        from sklearn.linear_model import LinearRegression
        import numpy as np
        X = np.array([[5, 50, 1], [10, 50, 1], [5, 60, 2], [1, 80, 3], [5, 55, 1]])
        y = np.array([3500000, 6500000, 3200000, 15000000, 3300000])
        model = LinearRegression().fit(X, y)
        with open(MODEL_PATH, 'wb') as f:
            pickle.dump(model, f)
        print(f'Model saved to {MODEL_PATH}')
    except ImportError:
        print('Install scikit-learn: pip install scikit-learn')

if __name__ == '__main__':
    train_sample_model()
