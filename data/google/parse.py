import json
import csv
import time

with open('Location History.json') as infile:
	data = json.load(infile)
	locations = data['locations']
	with open('location_history.csv', 'w') as output:
		writer = csv.writer(output, lineterminator='\n')
		writer.writerow(['datetime', 'latitude', 'longitude'])
		for location in locations:
			timestamp = int(location['timestampMs'])/1000
			datetime = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(timestamp))
			latitude = int(location['latitudeE7']) / 1E7
			longitude = int(location['longitudeE7']) / 1E7
			writer.writerow([datetime, latitude, longitude])

# TODO: Filter to year