import numpy as np

import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func

import datetime as dt

from flask import Flask, jsonify


#################################################
# Database Setup
#################################################
engine = create_engine("sqlite:///Resources/hawaii.sqlite")

# reflect an existing database into a new model
Base = automap_base()
# reflect the tables
Base.prepare(engine, reflect=True)

# Save reference to the table
Measurement = Base.classes.measurement
Station = Base.classes.station

# Create our session (link) from Python to the DB
session = Session(engine)

#################################################
# Flask Setup
#################################################
app = Flask(__name__)

#################################################
# Flask Routes
#################################################

@app.route("/")
def welcome():
    return (
        f"Welcome to the Homework 8 Flask App!<br/>"
        f"Available Routes:<br/>"
        f"/api/v1.0/precipitation"
        f"/api/v1.0/stations"
        f"/api/v1.0/tobs"
        f"/api/v1.0/<start>"
        f"/api/v1.0/<start>/<end>"
    )

@app.route("/api/v1.0/precipitation")
def precipitation():
    """Convert the query results to a Dictionary using date as the key and prcp as the value."""
    results = session.query(Measurement).all()    
    precipitation = []
    for measurement in results:
        prcp_dict = {}
        prcp_dict["date"] = measurement.date
        prcp_dict["precipitation"] = measurement.prcp
        precipitation.append(prcp_dict)
    return jsonify(precipitation)

@app.route("/api/v1.0/stations")
def stations():
    """Return a JSON list of stations from the dataset."""
    results = session.query(Station.name).all()
    all_names = list(np.ravel(results))
    return jsonify(all_names)


@app.route("/api/v1.0/tobs")
def tobs():
    """Return a JSON list of Temperature Observations (tobs) for the previous year"""
    year_ago = dt.date(2017, 8, 23) - dt.timedelta(days=365)
    tobs_data = session.query(Measurement.date, func.avg(Measurement.tobs)).\
    filter(Measurement.date > year_ago).\
    order_by(Measurement.date).\
    group_by(Measurement.date).all()
    return jsonify(tobs_data)

@app.route("/api/v1.0/<start>/<end>")
def startend():
    """Return a JSON list of the minimum temperature, the average temperature, and the max temperature for a given start or start-end range."""
    year_ago = dt.date(2017, 8, 23) - dt.timedelta(days=365)
    tobs_data = session.query(Measurement.date, func.avg(Measurement.tobs)).\
    filter(Measurement.date > year_ago).\
    order_by(Measurement.date).\
    group_by(Measurement.date).all()

    return jsonify(tobs_data)

if __name__ == "__main__":
    app.run(debug=True)
