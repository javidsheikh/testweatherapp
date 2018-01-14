# TestWeatherApp

Clone the repo locally ([https://javidsheikh@bitbucket.org/javidsheikh/testweatherapp.git]) and run pod install. Open TestWeatherApp.xcworkspace and then run the project.
The app will load by default the forecast for your location.
Forecasts for other cities can be loaded by entering a city in the text field and clicking Get 5-Day Forecast.

## Potential Improvements:
* More unit tests, particularly view and model classes.
* More/better error handling.
* Group each weather forecast period by day - each table view row is a day within which is a horizontally scrollable collection view where each cell contains the forecast for a three hour period for that day.
* Fix bug where table header view disappears when error alert displayed.
* Customise layouts for different device sizes.
* Handle location services denied.
* Handle current location not found.
* Adjust time for each period by timezone.