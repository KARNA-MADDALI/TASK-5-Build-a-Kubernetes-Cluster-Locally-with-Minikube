from flask import Flask, request, jsonify

app = Flask(__name__)
expenses = []

@app.route("/expenses", methods=["GET"])
def get_expenses():
    return jsonify(expenses)

@app.route("/expenses", methods=["POST"])
def add_expense():
    data = request.get_json()
    expense = {
        "id": len(expenses) + 1,
        "name": data.get("name"),
        "amount": data.get("amount"),
        "category": data.get("category")
    }
    expenses.append(expense)
    return jsonify(expense), 201

@app.route("/expenses/<int:id>", methods=["DELETE"])
def delete_expense(id):
    global expenses
    expenses = [e for e in expenses if e["id"] != id]
    return '', 204

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)