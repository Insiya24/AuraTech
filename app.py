from flask import Flask, render_template, request, jsonify
from geopy.geocoders import Nominatim

app = Flask(__name__)

intern_locations = {}

def get_location(latitude, longitude):
    geolocator = Nominatim(user_agent="geoapi")
    location = geolocator.reverse((latitude, longitude), exactly_one=True)
    return location.address if location else "Location not found"

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/send-location", methods=["POST"])
def send_location():
    data = request.json
    name = data.get("name")
    latitude = data.get("latitude")
    longitude = data.get("longitude")
    
    if name and latitude and longitude:
        location_name = get_location(latitude, longitude)
        intern_locations[name] = location_name
        return jsonify({"success": True, "location": location_name})
    return jsonify({"success": False, "error": "Invalid data"}), 400

@app.route("/coordinator")
def coordinator():
    return render_template("coordinator.html", interns=intern_locations)

if __name__ == "__main__":
    app.run(debug=True)
