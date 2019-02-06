import json
import csv
import time
import sys

start_date = time.strptime(sys.argv[1], '%Y-%m-%d')
end_date = time.strptime(sys.argv[2], '%Y-%m-%d')
with open('Location History.json') as infile:
	data = json.load(infile)
	locations = data['locations']
	with open('location_history_cleaned.csv', 'w') as outfile:
		writer = csv.writer(outfile, lineterminator='\n')
		writer.writerow(['datetime', 'latitude', 'longitude'])
		for location in locations:
			timestamp = int(location['timestampMs'])/1000
			if time.localtime(timestamp) <= end_date and time.localtime(timestamp) >= start_date:
				datetime = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(timestamp))
				latitude = int(location['latitudeE7']) / 1E7
				longitude = int(location['longitudeE7']) / 1E7
				writer.writerow([datetime, latitude, longitude])