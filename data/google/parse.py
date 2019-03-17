import csv
import json
import sys
import time


def json_to_csv(start=None, end=None):
	try:
		infile = open('Location History.json')
	except (FileNotFoundError, IOError):
		print('\n  ERROR\n  "Location History.json" not found in this directory.\n')
	else:
		data = json.load(infile)
		locations = data['locations']
		with open('location_history_cleaned.csv', 'w') as outfile:
			writer = csv.writer(outfile, lineterminator='\n')
			writer.writerow(['datetime', 'latitude', 'longitude'])
			if start != None and end != None:
				for location in locations:
					timestamp = int(location['timestampMs'])/1000
					date_test(location, timestamp, start, end, writer)
			else:
				for location in locations:
					timestamp = int(location['timestampMs'])/1000
					parse_and_write_row(location, timestamp, writer)


def date_test(l, t, s, e, w):
	if time.localtime(t) <= e and time.localtime(t) >= s:
		parse_and_write_row(l, t, w)


def parse_and_write_row(l, t, w):
	datetime = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(t))
	latitude = int(l['latitudeE7']) / 1E7
	longitude = int(l['longitudeE7']) / 1E7
	w.writerow([datetime, latitude, longitude])

if len(sys.argv) == 1:
	json_to_csv()
elif len(sys.argv) == 2:
	if sys.argv[1] == '-h' or sys.argv[1] == '--help':
		print('\n  HELP\n  This is where helpful things should be printed... Sucks.\n')
	else:
		print('\n  ERROR\n  Program accepts zero arguments or two date arguments.')
		print('  Use "-h" or "--help" flag if you need some help.\n')
elif len(sys.argv) == 3:
	try:
		start_date = time.strptime(sys.argv[1], '%Y-%m-%d')
		end_date = time.strptime(sys.argv[2], '%Y-%m-%d')
	except ValueError:
		print('\n  ERROR\n  Dates must be formatted as "YYYY-MM-DD"\n')
	except:
		print('\n  ERROR\n  Your dates formatted properly, but something else went wrong...\n')
	else:
		json_to_csv(start_date, end_date)
elif len(sys.argv) > 3:
	print('\n  ERROR\n  Program accepts zero arguments or two date arguments.')
	print('  Use "-h" or "--help" flag if you need some help.\n')